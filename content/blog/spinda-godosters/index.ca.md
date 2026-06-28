---
title: "Spinda: Analitzant el seu codi en diversos projectes i com l'he recreat a Godosters"
description: Un viatge profund pel codi de Pokémon Maragda, Essentials, Unity i altres eines per entendre com es generen els més de 4.000 milions de patrons de Spinda i com ho he implementat a Godot 4.
date: 2026-06-28
image: cover.png
keywords:
  - godot
  - game dev
  - pokémon
  - spinda
  - shaders
  - maragda
  - essentials
  - unity
readingTime: true
comments: true
draft: false
categories:
  - Godosters
tags:
  - godot
  - devlog
  - programació
  - shaders
  - pokémon
---
Hola de nou. Avui us porto un tema bastant tècnic i una mica friki, però que portava molt de temps volent investigar. Si alguna vegada heu jugat a Pokémon a partir de Rubí, Safir o Maragda, segur que us heu creuat amb Spinda, el Pokémon panda dels patrons infinits.

La veritat és que aquest monstre de butxaca és un autèntic malson a nivell tècnic per a qualsevol desenvolupador que intenti fer un fangame o clon. De la mateixa manera em sembla una mecànica molt interessant que enriqueix el món d'aquestes criatures. Avui destriparem com funciona internament als jocs originals, com ho han resolt en altres eines i, finalment, com ho he implementat jo a Godosters.

![Spinda a l'anime amb diversos patrons de taques](spinda_anime.png)

## Què té d'especial l'Spinda?

Per als qui no ho sapigueu, Spinda és un Pokémon introduït a la tercera generació que té una mecànica única: les seves taques mai són iguals. 

Internament, el joc utilitza el Personality Value (PID), un número de 32 bits únic per a cada Pokémon, per determinar les coordenades exactes de 4 taques a la seva cara. Això vol dir que hi ha ni més ni menys que 4.294.967.296 combinacions possibles.

![Exemples de patrons de Spinda amb diversos PID](spinda_patterns.png)

Però, com es dibuixa això per pantalla sense tenir 4 mil milions d'imatges guardades? Anem a veure-ho.

## La solució original: Pokémon Maragda (Game Boy Advance)

![Spinda original de Pokémon Maragda](spinda_pokemon_emerald.png)

Em vaig posar a bussejar pel codi descompilat de `pokeemerald` a GitHub per entendre com ho feien el 2004 amb els recursos limitats de la GBA.

Lluny d'usar polígons o rotacions estranyes, les 4 taques són simples imatges binàries de 16x16 píxels (1 bit per píxel). 

![Taca 1](spot_0.png) ![Taca 2](spot_1.png) ![Taca 3](spot_2.png) ![Taca 4](spot_3.png)

*(A dalt: Les 4 textures binàries originals extretes de pokeemerald)*

El joc agafa els 32 bits del PID i els divideix en 4 blocs de 8 bits. Per a cada taca, utilitza els primers 4 bits per calcular el desplaçament X (entre -8 i +7 píxels de la seva base) i els altres 4 bits per a la Y.

Per posar-ho tot en perspectiva, aquí teniu la funció principal gairebé completa que fa tota la màgia ([veure a GitHub](https://github.com/pret/pokeemerald/blob/master/src/pokemon.c#L5749-L5787)) *(Nota: ho he adaptat d'una macro de C a una funció normal perquè sigui més fàcil de llegir)*:

```c
void draw_spinda_spots(u32 personality, u8 *dest) 
{
    for (int i = 0; i < 4; i++) 
    {
        u8 x = gSpindaSpotGraphics[i].x + ((personality & 0x0F) - 8);
        u8 y = gSpindaSpotGraphics[i].y + (((personality & 0xF0) >> 4) - 8);

        for (int row = 0; row < SPINDA_SPOT_HEIGHT; row++)
        {
            s32 spotPixelRow = gSpindaSpotGraphics[i].image[row];
            for (int column = x; column < x + SPINDA_SPOT_WIDTH; column++)
            {
                u8 *destPixels = dest + /* ... 
                 ... */;
                if (spotPixelRow & (1 << (column - x)))
                {
                    try_draw_spot_pixel(destPixels, shift);
                }
            }
            y++;
        }
        personality >>= 8;
    }
}
```

Explicat per sobre, aquest és el pas a pas del que fa aquest bloc:
1. **Recorre les 4 taques** en un bucle.
2. **`gSpindaSpotGraphics`** és simplement un Array de dades predefinit que guarda les coordenades inicials base de la cara de l'Spinda i el dibuix binari de les 4 textures de taques que hem vist abans.
3. **Calcula la coordenada final `x` i `y`** sumant-li el desplaçament aleatori extret del `personality` (el PID) a aquesta coordenada base.
4. Amb uns bucles `for` que recorren cada fila i columna del quadrat de la taca de 16x16, el codi en C fa màgia amb els meus estimats punters per buscar quina direcció exacta de la memòria RAM de la consola (`destPixels`) li correspon a aquest píxel de l'sprite base.
5. Comprova la màscara binària de la textura de la taca (`if (spotPixelRow & ...)`), i si en aquest píxel hi ha dibuix, crida a la macro final `TRY_DRAW_SPOT_PIXEL` per acolorir-lo.
6. Finalment, empeny el número del PID 8 bits cap a la dreta (`personality >>= 8`) per poder llegir les posicions pseudoaleatòries de la següent taca a la següent volta del bucle.

Tot i això, com us podeu imaginar, el joc no acoloreix aquest píxel a la babalà dins de `TRY_DRAW_SPOT_PIXEL`; primer s'assegura que la destinació pertanyi a la pell de l'Spinda, per evitar tacar els contorns negres o el fons transparent.

Aquí teniu l'sprite base buit al qual s'apliquen aquests càlculs a la memòria:

![Sprite base de Spinda a GBA (buit)](spinda_gba_front.png)

Per pintar la taca respectant els límits del cos, utilitza la següent macro a [`src/pokemon.c`](https://github.com/pret/pokeemerald/blob/master/src/pokemon.c#L5744-L5747). Aquí us explico línia per línia la màgia darrere de la comprovació:

```c
// Draw spot pixel if this is Spinda's body color
void try_draw_spot_pixel(u8 *pixels, int shift) 
{
    if (((*(pixels) & (0xF << (shift))) >= (FIRST_SPOT_COLOR << (shift))) 
     && ((*(pixels) & (0xF << (shift))) <= (LAST_SPOT_COLOR << (shift)))) 
    { 
        *(pixels) += (SPOT_COLOR_ADJUSTMENT << (shift)); 
    }
}
```

* `if (((*(pixels) & (0xF << (shift))) >= (FIRST_SPOT_COLOR << (shift)))`: Aquesta línia mira el valor del color actual del píxel a la RAM i comprova si és "major o igual" al color més clar de la paleta que correspon al cos de l'Spinda (`FIRST_SPOT_COLOR`). La variable `shift` s'utilitza perquè els píxels a GBA (que són de 4 bits per píxel) a vegades estan agrupats de dos en dos en un mateix byte.
* `&& ((*(pixels) & (0xF << (shift))) <= (LAST_SPOT_COLOR << (shift))))`: I a més a més, comprova si és "menor o igual" al color més fosc del cos de l'Spinda (`LAST_SPOT_COLOR`). Això garanteix al 100% que el píxel que pintarem pertany exclusivament a la pell de l'Spinda, i no pas als seus ulls o contorns negres.
* `*(pixels) += (SPOT_COLOR_ADJUSTMENT << (shift));`: Si es compleixen les condicions de dalt, entra a la instrucció final, on al color del píxel se li suma un ajustament matemàtic (`SPOT_COLOR_ADJUSTMENT`) a la paleta, transformant-lo màgicament al color vermellós de la taca.

Per assegurar-me que ho havia entès bé, vaig estar fent algunes proves. Vaig decidir alterar la ROM original, esborrant justament aquesta mateixa comprovació condicional per obligar al joc a dibuixar les taques ignorant els límits del cos:

```diff
 // Draw spot pixel if this is Spinda's body color
 void try_draw_spot_pixel(u8 *pixels, int shift) 
 {
-    if (((*(pixels) & (0xF << (shift))) >= (FIRST_SPOT_COLOR << (shift))) 
-     && ((*(pixels) & (0xF << (shift))) <= (LAST_SPOT_COLOR << (shift)))) 
-    { 
         *(pixels) += (SPOT_COLOR_ADJUSTMENT << (shift)); 
     }
 }
```

Vaig recompilar el joc modificat, i com podeu observar en aquesta captura final presa des de la meva consola original :), les taques ara suren lliurement sobre el fons i es pinten per damunt dels ulls o les vores negres perquè ja no estan limitades a dibuixar-se només sobre el color principal del cos:

![Imatge de Spinda modificat compilat des de la ROM de pokeemerald](pokeemerald.png)

## La solució a Pokémon Essentials (RPG Maker)

Saltem al món del fangame clàssic. A Pokémon Essentials (basat en Ruby i RPG Maker), la solució és molt més tosca perquè el motor no està pensat per a això. Analitzem el codi que està contingut a [001_FormHandlers.rb#L41-L140](https://github.com/Maruno17/pokemon-essentials/blob/master/Data/Scripts/014_Pokemon/001_Pokemon-related/001_FormHandlers.rb#L41-L140).

En comptes de tocar memòria directament, tenen matrius bidimensionals en codi que dibuixen les taques utilitzant la funció `set_pixel` del motor, píxel a píxel, per programari. Ho han de multiplicar per 2 per com funciona RPG Maker XP.

```rb
def drawSpot(bitmap, spotpattern, x, y, red, green, blue)
  height = spotpattern.length
  width  = spotpattern[0].length
  height.times do |yy|
    spot = spotpattern[yy]
    width.times do |xx|
      next if spot[xx] != 1
      xOrg = (x + xx) * 2
      yOrg = (y + yy) * 2
      color = bitmap.get_pixel(xOrg, yOrg)
      r = color.red + red
      g = color.green + green
      b = color.blue + blue
      color.red   = [[r, 0].max, 255].min
      color.green = [[g, 0].max, 255].min
      color.blue  = [[b, 0].max, 255].min
      bitmap.set_pixel(xOrg, yOrg, color)
      bitmap.set_pixel(xOrg + 1, yOrg, color)
      bitmap.set_pixel(xOrg, yOrg + 1, color)
      bitmap.set_pixel(xOrg + 1, yOrg + 1, color)
    end
  end
end

def pbSpindaSpots(pkmn, bitmap)
  # NOTE: These spots are doubled in size when drawing them.
  spot1 = [
    [0, 0, 1, 1, 1, 1, 0, 0],
    [0, 1, 1, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [0, 1, 1, 1, 1, 1, 1, 0],
    [0, 0, 1, 1, 1, 1, 0, 0]
  ]
  spot2 = [
    [0, 0, 1, 1, 1, 0, 0],
    [0, 1, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [0, 1, 1, 1, 1, 1, 0],
    [0, 0, 1, 1, 1, 0, 0]
  ]
  spot3 = [
    [0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0],
    [0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
    [0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
    [0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
    [0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0]
  ]
  spot4 = [
    [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
    [0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
    [0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0]
  ]
  id = pkmn.personalID
  h = (id >> 28) & 15
  g = (id >> 24) & 15
  f = (id >> 20) & 15
  e = (id >> 16) & 15
  d = (id >> 12) & 15
  c = (id >> 8) & 15
  b = (id >> 4) & 15
  a = (id) & 15
  # NOTE: The coordinates below (b + 33, a + 25 and so on) are doubled when
  #       drawing the spot.
  if pkmn.shiny?
    drawSpot(bitmap, spot1, b + 33, a + 25, -75, -10, -150)
    drawSpot(bitmap, spot2, d + 21, c + 24, -75, -10, -150)
    drawSpot(bitmap, spot3, f + 39, e + 7, -75, -10, -150)
    drawSpot(bitmap, spot4, h + 15, g + 6, -75, -10, -150)
  else
    drawSpot(bitmap, spot1, b + 33, a + 25, 0, -115, -75)
    drawSpot(bitmap, spot2, d + 21, c + 24, 0, -115, -75)
    drawSpot(bitmap, spot3, f + 39, e + 7, 0, -115, -75)
    drawSpot(bitmap, spot4, h + 15, g + 6, 0, -115, -75)
  end
end
```

![Sprite base de Spinda a Pokémon Essentials (buit)](spinda_essentials_front.png)
![Imatge de Spinda a Pokémon Essentials](spinda_essentials.png)

Funciona bé per a imatges estàtiques, però és terriblement ineficient. El gran problema arriba quan intentes animar l'sprite. Si l'Spinda mou el cap, les taques es queden surant al lloc perquè es pinten sobre coordenades estàtiques.

## Deluxe Battle Kit al rescat (Essentials)

Per solucionar aquest problema de l'animació dins del mateix motor d'Essentials, el plugin Deluxe Battle Kit usa una aproximació bastant enginyosa, tot i que poc òptima.

El codi escaneja l'sprite en temps d'execució frame a frame, buscant el color exacte de la boca de l'Spinda `(230, 99, 115)`. Mesura quants píxels s'ha mogut la boca horitzontalment i verticalment des del frame anterior i li aplica aquesta diferència a les coordenades de les taques. Molt intel·ligent per ancorar les taques a la cara, però fer escaneig de píxels per CPU constantment no és el millor per al rendiment. Per no fer el post massa llarg i complex, ometré el codi d'aquesta secció, és una mica enfarragós.

![Sprites de Spinda al Deluxe Battle Kit](spinda_deluxe_battle_kit.png)

![Spinda animat amb el Deluxe Battle Kit](https://i.imgur.com/4rX0dud.gif)

## YAPU (Unity)

YAPU (Yet Another Pokémon Unity) introdueix un canvi de paradigma gegant, ja que treballa a Unity i utilitza shaders a la GPU. A més, les animacions aquí són seqüències de 52 frames on el cap rota i canvia de perspectiva, de manera que un desplaçament estàtic es desquadraria de seguida.

Per solucionar-ho, el desenvolupador de YAPU va crear una eina externa en C# que precalcula una textura enorme de dades (Data Texture o LUT). Aquesta imatge no és per veure-la, sinó que emmagatzema dades matemàtiques als seus colors. Curiosament, aquesta és la mateixa tècnica que utilitzo a [Elit3D](/projects/elit3d/) per enviar en una imatge les dades dels tiles de cada capa i que la GPU pugui processar-ho ràpidament.

En el cas de YAPU, la imatge té 52x4 píxels (52 frames i 4 taques). Als canals vermell i verd de cada píxel, guarda la coordenada base exacta on ha d'anar ancorada cada taca en aquest frame específic. Després, el Shader Graph de Unity simplement llegeix aquests colors, li suma el desplaçament aleatori del PID, i dibuixa la taca. Súper ràpid d'executar, però molt complex i rígid a l'hora de mantenir si decideixes canviar un fotograma de l'animació.

![LUT de Spinda a YAPU](spinda_yapu_lut.png)
> Posar a punt YAPU és una mica complex perquè demana recursos que no estan públics i diversos plugins de pagament que no tinc. Tota l'anàlisi l'he fet sense poder comprovar-ho i el LUT l'he generat amb un script que replica però no és exactament el mateix.
## Com ho he fet a Godosters (Godot 4)

Després d'analitzar tot això, em va tocar pensar com fer-ho al meu projecte. Volia una cosa intermèdia: fugir de l'escaneig per CPU del Battle Kit i evitar la complexitat de l'eina externa de dades de YAPU.

Per sort, Godot 4 és increïble amb els shaders. Són molt semblants a glsl, simples de fer, m'agraden molt. La meva solució actual és un enfocament híbrid:

1. Utilitzo les matrius d'Essentials en codi GDScript, però en lloc de dibuixar per pantalla amb `set_pixel`, les converteixo un sol cop en una `ImageTexture` a la memòria (creant una màscara que li passo a la GPU).
2. L'script en GDScript calcula les matemàtiques del PID (els desplaçaments) i els hi passa com a paràmetres (`uniforms`) al shader.
3. El Fragment Shader s'encarrega de tota la resta. Revisa si el píxel actual cau dins de la màscara de la taca i li aplica el tintat matemàtic de color. 

Anem pas per pas. Primer l'script:

Per implementar això al meu projecte, vaig optar per un sistema híbrid que pren el millor d'ambdós mons: la facilitat d'ús de les matrius d'Essentials i l'altíssim rendiment dels shaders.

He creat una classe `SpindaAppearanceModifier` que hereta del nostre sistema base de modificadors visuals. Aquesta classe compta amb una funció principal, `apply()`, que rep la instància del Pokémon i l'sprite que es renderitzarà.

L'estratègia és la següent:
1. **Definir els patrons**: Reutilitzo les mateixes matrius binàries d'Essentials per donar forma a les taques.
2. **Crear màscares eficients**: En lloc de dibuixar la taca píxel a píxel a la CPU, converteixo aquestes matrius en una textura (`ImageTexture`) utilitzant un `PackedByteArray`. Aquesta és una tècnica súper optimitzada a Godot que permet construir la imatge de cop, evitant iteracions lentes.
3. **Colors precisos**: Vaig extreure els colors exactes de l'sprite original (tant per a la llum com per a l'ombra). L'script assigna els colors normals per defecte i els reemplaça només si el Pokémon és shiny, mantenint un codi molt net.
4. **Calcular coordenades**: Utilitzant el PID, llegim grups de 4 bits per extreure el desplaçament de cada taca (entre 0 i 15 píxels), imitant exactament les matemàtiques de la GBA.
5. **Enviar al Shader**: Finalment, creem una instància única del material (per evitar que diferents Spindas comparteixin les mateixes posicions) i passem totes aquestes variables al shader.

```gd
class_name SpindaAppearanceModifier

extends AppearanceModifier

const SPOT1: Array = [ # Bottom-Right
	[0, 0, 1, 1, 1, 1, 0, 0],
	[0, 1, 1, 1, 1, 1, 1, 0],
	[1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1],
	[0, 1, 1, 1, 1, 1, 1, 0],
	[0, 0, 1, 1, 1, 1, 0, 0],
]
const SPOT2: Array = [ # Bottom-Left
	[0, 0, 1, 1, 1, 0, 0],
	[0, 1, 1, 1, 1, 1, 0],
	[1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1],
	[0, 1, 1, 1, 1, 1, 0],
	[0, 0, 1, 1, 1, 0, 0],
]
const SPOT3: Array = [ # Top-Right
	[0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0],
	[0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
	[0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
	[0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
	[0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
]
const SPOT4: Array = [ # Top-Left
	[0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
	[0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
	[0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0],
]

static var _masks: Array[ImageTexture]

@export var shader: Shader = preload("uid://ck1uhn0oiwgaa")

@export var spot1_base := Vector2(38, 34)
@export var spot2_base := Vector2(26, 33)
@export var spot3_base := Vector2(45, 14)
@export var spot4_base := Vector2(21, 14)

@export var debug_mode: bool = false
@export_group("Colors")
@export var spot_color_normal := Color(238.0 / 255.0, 82.0 / 255.0, 74.0 / 255.0)
@export var spot_shade_color_normal := Color(189.0 / 255.0, 74.0 / 255.0, 49.0 / 255.0)
@export var body_color_normal := Color(230.0 / 255.0, 213.0 / 255.0, 164.0 / 255.0)
@export var body_shade_color_normal := Color(205.0 / 255.0, 164.0 / 255.0, 115.0 / 255.0)

@export var spot_color_shiny := Color(164.0 / 255.0, 205.0 / 255.0, 16.0 / 255.0)
@export var spot_shade_color_shiny := Color(130.0 / 255.0, 170.0 / 255.0, 10.0 / 255.0)
@export var body_color_shiny := Color(184.0 / 255.0, 216.0 / 255.0, 168.0 / 255.0)
@export var body_shade_color_shiny := Color(128.0 / 255.0, 184.0 / 255.0, 112.0 / 255.0)


func apply(monster: Monster, sprite: CanvasItem, context: AppearanceModifier.SpriteContext) -> void:
	# Spots only make sense on the front-facing art.
	if context != AppearanceModifier.SpriteContext.FRONT:
		return

	var id := monster.pid._get_id()
	var x4 := (id) & 15
	var y4 := (id >> 4) & 15
	var x3 := (id >> 8) & 15
	var y3 := (id >> 12) & 15
	var x2 := (id >> 16) & 15
	var y2 := (id >> 20) & 15
	var x1 := (id >> 24) & 15
	var y1 := (id >> 28) & 15

	var masks := _get_masks()
	var mat := ShaderMaterial.new()
	mat.shader = shader

	mat.set_shader_parameter("spot1_tex", masks[0])
	mat.set_shader_parameter("spot2_tex", masks[1])
	mat.set_shader_parameter("spot3_tex", masks[2])
	mat.set_shader_parameter("spot4_tex", masks[3])

	mat.set_shader_parameter("spot1_offset", (spot1_base + Vector2(x1, y1)))
	mat.set_shader_parameter("spot2_offset", (spot2_base + Vector2(x2, y2)))
	mat.set_shader_parameter("spot3_offset", (spot3_base + Vector2(x3, y3)))
	mat.set_shader_parameter("spot4_offset", (spot4_base + Vector2(x4, y4)))

	var spot_color := spot_color_normal
	var spot_shade_color := spot_shade_color_normal
	var body_color := body_color_normal
	var body_shade_color := body_shade_color_normal
	
	if monster.is_shiny:
		spot_color = spot_color_shiny
		spot_shade_color = spot_shade_color_shiny
		body_color = body_color_shiny
		body_shade_color = body_shade_color_shiny
	
	var delta := Vector3(
		spot_color.r - body_color.r,
		spot_color.g - body_color.g,
		spot_color.b - body_color.b
	)
	var shade_delta := Vector3(
		spot_shade_color.r - body_shade_color.r,
		spot_shade_color.g - body_shade_color.g,
		spot_shade_color.b - body_shade_color.b
	)
		
	mat.set_shader_parameter("color_delta", delta)
	mat.set_shader_parameter("shade_delta", shade_delta)
	mat.set_shader_parameter("body_color", Vector3(body_color.r, body_color.g, body_color.b))
	mat.set_shader_parameter("body_shade_color", Vector3(body_shade_color.r, body_shade_color.g, body_shade_color.b))
	mat.set_shader_parameter("debug_mode", debug_mode)

	sprite.material = mat


static func _get_masks() -> Array[ImageTexture]:
	if _masks.is_empty():
		_masks.resize(4)
		_masks[0] = _make_mask(SPOT1)
		_masks[1] = _make_mask(SPOT2)
		_masks[2] = _make_mask(SPOT3)
		_masks[3] = _make_mask(SPOT4)
	return _masks


static func _make_mask(pattern: Array) -> ImageTexture:
	var height := pattern.size()
	var width: int = pattern[0].size()
	
	var data := PackedByteArray()
	data.resize(width * height)
	
	var i := 0
	for y in height:
		for x in width:
			data[i] = pattern[y][x] * 255
			i += 1
			
	var img := Image.create_from_data(width, height, false, Image.FORMAT_L8, data)
	return ImageTexture.create_from_image(img)
```

Ara anem al shader. El shader rep totes les dades i únicament modifica el `fragment`. Primer llegeix el color del píxel de la textura de l'Spinda i comprova que no sigui transparent. Si no ho és, avalua cadascuna de les quatre taques. Per cada taca, revisa que la coordenada caigui dins de la seva àrea corresponent i, tot seguit, llegeix el valor exacte d'aquesta màscara per saber si hi toca dibuixar.

Si hi toca taca, el shader no la pinta a l'engròs. Primer compara el color original del píxel amb els tons de pell crema de l'Spinda. Utilitzant una barreja matemàtica intel·ligent, decideix què fer: si el píxel és pell, el tenyeix de vermell al 100% respectant perfectament si estava il·luminat o a l'ombra. Però si el píxel forma part d'un tret facial, com les línies fosques dels ulls o la boca, ho deixa intacte. D'aquesta manera aconseguim que les taques s'integrin amb un suavitzat perfecte sobre el cos sense esborrar-li la cara al Pokémon.
```glsl
shader_type canvas_item;

uniform sampler2D spot1_tex : filter_nearest, repeat_disable;
uniform sampler2D spot2_tex : filter_nearest, repeat_disable;
uniform sampler2D spot3_tex : filter_nearest, repeat_disable;
uniform sampler2D spot4_tex : filter_nearest, repeat_disable;

uniform vec2 spot1_offset = vec2(0.0);
uniform vec2 spot2_offset = vec2(0.0);
uniform vec2 spot3_offset = vec2(0.0);
uniform vec2 spot4_offset = vec2(0.0);

uniform vec3 color_delta = vec3(0.0);
uniform vec3 shade_delta = vec3(0.0);
uniform vec3 body_color = vec3(0.878, 0.815, 0.627);
uniform vec3 body_shade_color = vec3(0.784, 0.690, 0.501);
uniform float color_tolerance = 0.2;
uniform bool debug_mode = false;


vec3 apply_spot(vec3 col, sampler2D mask, vec2 px, vec2 offset) {
	vec2 rel = px - offset;
	if (rel.x < 0.0 || rel.y < 0.0) {
		return col;
	}
	ivec2 idx = ivec2(rel);
	ivec2 size = textureSize(mask, 0);
	if (idx.x >= size.x || idx.y >= size.y) {
		return col;
	}
	if (texelFetch(mask, idx, 0).r > 0.5) {
		if (debug_mode) {
			col = clamp(col + color_delta, vec3(0.0), vec3(1.0));
		} else {
			float dist_base = distance(col, body_color);
			float dist_shade = distance(col, body_shade_color);
			
			float blend_base = 1.0 - smoothstep(color_tolerance * 0.5, color_tolerance, dist_base);
			float blend_shade = 1.0 - smoothstep(color_tolerance * 0.5, color_tolerance, dist_shade);
			
			if (blend_base > 0.0 || blend_shade > 0.0) {
				if (blend_base > blend_shade) {
					col = mix(col, clamp(col + color_delta, vec3(0.0), vec3(1.0)), blend_base);
				} else {
					col = mix(col, clamp(col + shade_delta, vec3(0.0), vec3(1.0)), blend_shade);
				}
			}
		}
	}
	return col;
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (COLOR.a != 0.0 || debug_mode) {	
		if (debug_mode && COLOR.a == 0.0) {
			COLOR = vec4(0.2, 0.2, 0.2, 0.3);
		}
		vec2 px = floor(UV / TEXTURE_PIXEL_SIZE);
		COLOR.rgb = apply_spot(COLOR.rgb, spot1_tex, px, spot1_offset);
		COLOR.rgb = apply_spot(COLOR.rgb, spot2_tex, px, spot2_offset);
		COLOR.rgb = apply_spot(COLOR.rgb, spot3_tex, px, spot3_offset);
		COLOR.rgb = apply_spot(COLOR.rgb, spot4_tex, px, spot4_offset);
	}
}

```

És rapidíssim perquè la feina pesada s'executa en paral·lel a la targeta gràfica i soluciona el problema de base del pintat estàtic.
![Imatge de l'sprite base buit de Godosters (PokeAPI)](spinda_godosters.png)

Vaig crear una escena a Godot on podia visualitzar cadascun dels monstres que hi ha a la base de dades. Vaig fer un cas especial on, si el Pokémon tenia dins l'array de `AppearanceModifiers`, afegís uns controls per poder editar l'origen dels punts. D'aquesta manera podia veure exactament la posició dels punts per anar comprovant els canvis que feia.
![Captura d'una escena de Godosters per visualitzar tots els monstres](spinda_godosters_editor.png)

### El futur: Animacions Nadiues a Godot

La veritat que amb la solució actual estic bastant content, però encara hereta un problema: si afegeixo un sprite animat, les taques es quedaran fixes igual que passava a Essentials.

Tampoc és que sigui un expert, però donant-li voltes, crec que la millor solució possible és aprofitar la pròpia arquitectura de Godot i el node `AnimationPlayer`. La meva idea per al futur és dividir el desplaçament en dues parts dins del shader:
* `spot1_base`: La posició original de la taca al cos de l'Spinda.
* `spot1_pid_offset`: El desplaçament aleatori generat pel PID.

L'script només calcularà el `pid_offset` un sol cop en instanciar el Pokémon. Per a l'animació, simplement faré servir l'`AnimationPlayer` de Godot per crear una pista que mogui el valor de l'`spot1_base` frame a frame directament des de la línia de temps de l'editor. Així, les taques es mouran amb el cap de forma nadiua, tot per GPU i sense eines externes estranyes.

Fins i tot podria fer un script que escanegi els colors de la boca (com fa el Deluxe Battle Kit) dins de l'editor, i que em generi automàticament els keyframes de l'`AnimationPlayer` per no haver-ho de fer a mà fotograma a fotograma. El millor d'ambdós mons i amb un rendiment perfecte al joc final.

Una altra opció tècnicament impecable seria fugir dels spritesheets i fer les animacions per parts amb esquelets 2D (com feien a la Generació 5). D'aquesta manera, el cap de l'Spinda seria un node independent de Godot i el shader s'aplicaria només a aquesta peça. En animar i rotar el cap, les taques girarien perfectament clavades a ella de forma nadiua. Però sent sincers, animar, trossejar i riggear gairebé mil bestioles a mà és una autèntica bogeria. Així que em quedaré amb l'animació per frames; encara que toqui programar alguns pedaços, és infinitament més ràpid a nivell de producció perquè els assets ja estan tots llestos a internet.

### I als jocs actuals en 3D?

Tot i que el 3D està totalment *out of scope* per Godosters (no per als mapes, per això va néixer Elit3D), és curiós pensar en com va solucionar Game Freak aquest mateix problema a partir de Pokémon X i Y. Amb models 3D, el problema simplement desapareix: Spinda té una malla 3D associada a un esquelet. Les taques es calculen passant el PID al shader del material, que dibuixa les taques directament sobre les UVs del cap. En moure's l'esquelet 3D en qualsevol animació, la textura i les UVs es mouen amb el model de forma 100% nadiua.

![Gif de Spinda en un joc de Pokémon en 3D](spinda_3d_game.gif)

### El curiós cas de Pokémon Diamant Brillant i Perla Lluent (ILCA)

Per acabar, val la pena esmentar el desastre que va ocórrer amb Spinda als remakes de Diamant i Perla desenvolupats per ILCA. 

En replicar aquesta mecànica a Unity, l'estudi va cometre un error d'*Endianness* (l'ordre dels bytes) en llegir el PID. Com que la resta de la saga usa *Little Endian* i ells van assumir *Big Endian*, van acabar llegint els 32 bits literalment a l'inrevés. Per exemple, un valor hexadecimal del PID com `12 34 56 78` el llegien com `78 56 34 12`.

El resultat visual era catastròfic: el patró de taques generat a BDSP era completament diferent del que aquest mateix número produiria en qualsevol altre joc. Això va provocar un xoc crític amb *Pokémon HOME* (curiosament també desenvolupat per ILCA), que sí que llegia el PID correctament. Si transferies un Spinda d'un joc a un altre, les seves taques es recol·locaven màgicament.

Com que arreglar el bug a posteriori hauria alterat els Spindas que els jugadors ja tenien a les seves partides, la solució va ser dràstica: **van prohibir per complet transferir a Spinda**. Avui dia, qualsevol Spinda capturat a BDSP està atrapat en aquest joc per sempre per culpa de llegir 4 bytes en l'ordre equivocat.

A la següent imatge (cortesia de @Atrius97) podeu veure la demostració: han generat dos Spindas amb els bytes del seu PID invertits a propòsit per comprovar com xoquen les versions generades a Pokémon Maragda (correcte) davant de BDSP (error de lectura).

![Comparativa de l'error de lectura de Spinda a BDSP](spinda-bdsp.png)

---

Per cert, si us ha picat la curiositat i voleu trastejar amb les taques de l'Spinda sense haver de tocar codi, us recomano fer-li un cop d'ull a [Spinda Painter](https://wokann.github.io/Tool/Spinda_Painter/Spinda%20Painter%201.3.2.htm). És una eina web genial que et permet pintar i visualitzar el patró de qualsevol Spinda sabent el seu PID i viceversa. M'ha servit bastant durant tota aquesta investigació per anar comprovant coses.

![Pantalla dividida amb el Spinda Painter per comprovar que els punts es pintaven igual amb el mateix PID](spinda_godosters_editor_0.png)
![Pantalla dividida amb el Spinda Painter per comprovar que els punts es pintaven igual amb el mateix PID amb el mode debug activat](spinda_godosters_editor_1.png)

I això és tot per avui. Ha estat un post una mica més dens del normal, però em venia de gust deixar documentada tota aquesta investigació perquè em sembla fascinant com la comunitat ha anat resolent aquest problema de disseny al llarg dels anys.

Canviant una mica de tema, la veritat és que he estat treballant bastant en Godosters últimament i he avançat moltíssim. Això sí, el projecte encara és molt inestable per dins i vull assegurar-me que estigui bé abans de publicar-ho i ensenyar-ho oficialment. Aviat us ensenyaré en detall els nous sistemes que he integrat i quin és el panorama actual de tot això.

Espero que us resulti útil. Deixar un like, un emoji o un comentari per aquí sota s'agraeix moltíssim.

Fins a la propera!