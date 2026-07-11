---
title: Impartint un Taller de Creació de Videojocs amb Unity i Godot
description: La meva experiència donant un taller de Unity i Godot per a adolescents.
date: 2026-07-10T15:34:15Z
draft: true
image: cover.png
tags:
  - Godot
  - Unity
  - Educació
  - Desenvolupament
---

¡Hola de nou!

Aquesta setmana he estat bastant enfeinat impartint un taller a adolescents sobre desenvolupament de videojocs. Ja és el segon any que em fico en aquest embolic i, per sort, ha sortit bastant millor que l'anterior.

La veritat és que ensenyar sempre m'ha agradat. No soc el millor professor del món, però intento que els conceptes quedin clars. Gaudeixo molt preparant els materials, explicant-los i, sobretot, veient com ells també m'ensenyen coses a mi.

L'oportunitat va sorgir a la universitat on vaig estudiar, en col·laboració amb l'ajuntament, com a part d'un programa per fomentar la universitat entre els joves.

## L'any passat: La meva primera experiència

L'any passat vaig tenir estudiants des de primer fins a quart d'ESO, i la veritat és que em vaig passar bastant amb el material. En la meva defensa diré que era la meva primera experiència i que m'havien dit que els alumnes serien més grans. El format era de 4 dies, a tres hores per dia.

Per afegir una mica de context, a principis d'aquell mateix any havia fet un taller de només dues hores amb alumnes de quart d'ESO i Batxillerat. Com que teníem tan poc temps, em vaig decantar per fer un clon de Flappy Bird a Unity. La idea era donar-los un projecte buit amb els sprites i programar-lo entre tots. Amb arribar a que l'ocell saltés i les canonades apareguessin, ja era suficient per a una primera presa de contacte. 

Per si a algú li serveix, el material d'aquell taller el teniu aquí:

{{< github-repo-card owner="christt105" repo="FlappyBirdUnityWorkshop" >}}

![Flappy Bird Clone fet a Unity](flappy_bird.png)

Com que el taller d'estiu eren quatre dies seguits, vaig pensar ingènuament que donaria temps a acabar el Flappy Bird i que necessitaria més jocs per omplir. Vaig decidir fer un joc per dia perquè, si algú faltava, l'endemà pogués començar de zero amb la resta. Vaig preparar un Pong (Unity), el Flappy Bird (Unity), un Asteroids (Godot) i un plataformes 3D (Godot).

Fer el Flappy Bird va ser mitja obligació, ja que havien publicitat el taller utilitzant el logo d'Unity. Jo vaig insistir bastant que Godot era molt millor per a adolescents. Pesa tot just 100MB, és descarregar i obrir. Res dels 15GB d'Unity ni la tortura d'obligar els xavals a crear-se comptes. A més, els temps de compilació a Unity en ordinadors poc potents són un horror, i GDScript és molt més net per a ells. Vaig ser bastant pesat per colar Godot al temari, i la veritat és que va sortir bé. Una altra cosa no, però convencent sobre productes pels quals no em paga ningú, soc un geni.

Al final, la cosa va anar una mica pitjor del que esperava. Encara que s'ho van passar molt bé, no va donar temps a acabar gairebé cap joc. Als més petits els costava la vida seguir el ritme, i havia d'anar un per un arreglant el que tocaven, cosa que deixava els grans esperant avorrits.

El millor dia va ser, sens dubte, l'últim, amb el plataformes 3D. Vaig preparar una versió modificada de l'excel·lent *Starter-Kit* de Kenney. Vam esborrar un parell de línies perquè el personatge no esogués d'inici, les vam programar junts ràpid i, a partir d'aquí, els vaig deixar crear els seus propis nivells arrossegant plataformes i monedes. S'ho van passar molt bé. Alguns fins i tot van treure paper i bolígraf per dissenyar els nivells abans de muntar-los. 

![Joc de Plataformes 3D a Godot](platformer3D.png)

## Aquest any: Millorant la fórmula

Per a aquest any volia millorar l'experiència. Com que no em van donar molta més informació, vaig assumir que tindria el mateix rang d'edats. Vaig utilitzar el mateix repositori que l'any passat:

{{< github-repo-card owner="christt105" repo="CITMGameWorkshop" >}}

La decisió més important va ser retallar contingut. Quatre jocs eren massa, així que em vaig quedar amb els dos més visuals: Flappy Bird i el plataformes 3D. Així teníem dos dies d'Unity i dos de Godot. Potser utilitzar dos motors els podia confondre una mica, però m'interessava que veiessin que hi ha diverses eines amb els seus pros i contres (i perquè l'organització volia Unity i jo Godot, per què mentir).

El primer dia ho vaig plantejar igual: projecte buit i fer el Flappy Bird entre tots. El segon dia els vaig passar el projecte ja avançat, vaig esborrar algunes parts per omplir-les junts i els vaig deixar temps lliure per afegir mecàniques i canviar els sprites.

El tercer dia el vam dedicar a omplir codi per crear les mecàniques base del plataformes, i l'últim dia va ser sencerament perquè creessin el seu propi nivell mentre jo els ajudava a programar qualsevol cosa que se'ls acudís.

## Utilitzant IA per millorar el material

Quan estava preparant tot això per a aquest any, encara tenia la subscripció a Claude, així que vaig decidir aprofitar-la per fer coses que per temps (o mandra) no hauria fet.

L'any passat vaig notar que els més autònoms s'avorrien si jo estava ajudant els més petits. Així que li vaig demanar a Claude que em generés unes guies pas a pas perquè els que anaven perduts poguessin repassar, i els avançats poguessin afegir mecàniques extra pel seu compte. 

Les guies estaven genial, però en format arxiu anaven a ser una mica complexes de consultar per a ells. Com que GitHub Pages és súper fàcil d'utilitzar, li vaig demanar a la IA que muntés una web senzilla amb les guies. Va quedar exactament com volia: accessible i molt visual. També vaig integrar les presentacions utilitzant un format de diapositives en Markdown que em va ensenyar Claude. Tot va quedar en un únic punt de consulta amb enllaços de descàrrega. La web és aquesta: [CITMGameWorkshop](https://christt105.github.io/CITMGameWorkshop/).

![Pàgina Web del Taller](web_screenshot.png)

Per últim, el tema de tenir una branca amb la solució i una altra amb la plantilla era un caos de mantenir. La IA em va donar la idea d'utilitzar comentaris específics al codi complet. Vaig muntar un CI a GitHub Actions que, en fer push, busca aquests comentaris, elimina els trossos de codi corresponents i actualitza la *release* amb la plantilla llesta per als alumnes. Una meravella que, sense IA, sortia totalment del meu scope per al temps que tenia.

```python
# Script que uso al CI per generar la plantilla buida
import glob, re
for f in glob.glob('FlappyBirdWorkshop/Assets/Scripts/**/*.cs', recursive=True):
    with open(f, 'r', encoding='utf-8') as file:
        content = file.read()
    
    # Elimina tot el codi de solució entre els marcadors
    content = re.sub(r'([ \t]*)// <SOL>.*?[ \t]*// </SOL>\n?', r'\1\n', content, flags=re.DOTALL)
    
    with open(f, 'w', encoding='utf-8') as file:
        file.write(content)
```

## El desenvolupament del taller

El taller d'aquest any ha anat fenomenal. Per a la meva sorpresa, tots els alumnes eren de tercer i quart d'ESO, així que el nivell estava molt més unificat. Van estar súper concentrats, sense necessitat d'anar al darrere d'ells, i no van parar de fer preguntes i tenir idees.

El meu objectiu principal era despertar la seva creativitat, i l'últim dia va ser un èxit total. Un xaval va descobrir que si emparentava objectes, es movien junts. Així que va fer una plataforma que queia en trepitjar-la i li va penjar un munt de punxes mortals. Bàsicament, si trepitjaves, et queia una pluja de punxes que havies d'esquivar. Un altre alumne es va muntar un sistema de "diàlegs" molt xulo utilitzant àrees i triggers que havíem vist per sobre. Tots van acabar el seu nivell i van acabar jugant als dels altres.

Al final els vaig preguntar quin motor els havia agradat més, i la majoria va dir Godot. Per a un taller és imbatible: en 10 minuts ja ho tenien tots descarregat, obert i llest. Amb Unity sempre es perd molt més temps, i com a algun li falli el login del compte, ja vas amb retard.

## Conclusions

Encara que aquest any ha anat genial, crec que serà l'última vegada que faci el taller, el meu Last Dance. He canviat de feina, l'horari és més estricte i aquesta vegada he hagut de gastar dies de vacances per poder donar-lo. M'agrada molt fer-ho, però no sé si em compensa perdre aquests dies.

Si ho hagués de repetir, tinc clares un parell de coses: ho faria 100% a Godot. Faria el Flappy Bird a Godot perquè l'editor els soni des del primer dia. I el dia del plataformes 3D els donaria un projecte amb moltes mecàniques ja fetes perquè no s'agobiïn programant i se centrin a dissenyar nivells i arrossegar objectes des del minut u.

M'ho he passat molt bé aquests quatre dies. L'organització també es va quedar molt contenta veient el que els xavals havien aconseguit l'últim dia. Sembla que ja els he convençut que es podria fer tot amb Godot. Jo m'emporto un bon aprenentatge sobre com tractar i ensenyar a adolescents. Al final, el més important en aquestes edats és fomentar-los l'esforç, la creativitat i que vegin que són capaços de crear coses de les quals sentir-se orgullosos.

Us deixo, que el post m'ha quedat una mica extens. Ens veiem en el proper post!
