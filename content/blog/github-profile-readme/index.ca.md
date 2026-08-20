---
title: "Com un GIF per al meu perfil de GitHub va acabar sent el Parallax Scene Editor"
description: Volia un GIF petit i nostàlgic per al README del meu perfil de GitHub. Una setmana després tenia, en el seu lloc, una eina per muntar escenes de parallax en pixel art.
date: 2026-08-20
image: github-profile-screenshot.png
keywords:
  - GitHub
  - Pokémon
  - pixel art
  - parallax
  - Aseprite
  - JavaScript
  - GitHub Actions
readingTime: true
comments: true
draft: false
categories:
  - Programming
  - Game Dev
tags:
  - Pokémon
  - pixel art
  - open source
  - GitHub Actions
---
Benvinguts a un nou post!

Aquest cop va d'una cosa petita: el README del meu perfil de GitHub. Volia que fos simple, un GIF que digués alguna cosa de mi, una mica friqui però sense passar-se, una descripció curta i poca cosa més. Al final se'm va escapar de les mans força més del que tocava.

## La idea

El punt de partida va ser la intro de Pokémon Maragda: el personatge surt en bicicleta mentre uns quants Pokémon corren al seu costat, just abans dels crèdits. Aquesta escena sempre m'ha agradat, així que volia alguna cosa amb el mateix esperit, personalitzada, però que es reconegués la mateixa idea. Senzill, en teoria.

![](PokemonEmeraldIntro.jpg)

## Primer intent: Aseprite

Em vaig descarregar [Aseprite](https://www.aseprite.org/) perquè feia temps que volia una excusa per aprendre'l. Mentre m'hi familiaritzava, vaig demanar a Claude que anés extraient els sprites de [pokeemerald](https://github.com/pret/pokeemerald), el projecte de descompilació. No hi tenia gaire fe, però ho va fer força bé: va treure els sprites força ordenats, per parts, i després els va ajuntar en diversos spritesheets, i el mateix amb els fons de les diferents escenes, urbà, mar i bosc.

Li vaig preguntar si era capaç de recrear l'escena original a Aseprite, i també ho va aconseguir. Aquí em vaig trobar amb el problema de debò: Aseprite funciona per frames. No hi ha manera, que jo sàpiga, de moure't lliurement entre keyframes arbitraris i que interpoli; cada frame el dibuixes o el col·loques a mà. Perfecte per fer sprites, no tant per coreografiar una càmera i actors al llarg de centenars de frames.

## Plot twist

Així que li vaig demanar que muntés la mateixa escena directament a partir d'un JSON amb les dades i posicions dels actors, tretes directament del joc. Imitava a la perfecció l'escena original. I aquí és quan va aparèixer la idea que de debò volia: i si un projectet d'una tarda el convertia en un d'una setmana?

Així va néixer el [Parallax Scene Editor](https://github.com/christt105/parallax-scene-editor). Li vaig demanar una pàgina web que treballés amb sprites i un JSON que descrivís l'escena, i vam anar iterant a partir d'aquí. Dues restriccions des del principi: tot local, i havia d'escriure directament al disc, no quedar-se en un estat intern de l'aplicació que exportes a mà al final.

## L'editor

### Parallax

Abans de continuar, un incís per a qui no li soni el terme. El parallax és el truc de tota la vida per donar sensació de profunditat en 2D. En lloc d'un únic fons, s'apilen diverses capes (cel, muntanyes, arbres, terra...) i cadascuna es mou a la seva pròpia velocitat, les llunyanes més a poc a poc, les properes més ràpid. L'ull interpreta aquesta diferència de velocitat com a distància, encara que a sota només hi hagi sprites plans. És la mateixa tècnica dels jocs de 16 bits, i la que fa servir Pokémon Maragda a la seva intro.

![Exemple de parallax scrolling amb diverses capes movent-se a diferent velocitat](https://images.squarespace-cdn.com/content/551a19f8e4b0e8322a93850a/1573861732601-PTWHSU2HW5BZ9C2IASCM/Intro_Parallax.gif?content-type=image%2Fgif)
*Exemple de [slynyrd.com](https://www.slynyrd.com/blog/2019/11/12/pixelblog-23-parallax-scrolling), que té un post sencer molt recomanable sobre com dibuixar parallax scrolling en pixel art.*

### Fent servir l'editor

Com sempre us deixo el repositori de l'editor amb el codi font per a qui vulgui trastejar.

{{< github-repo-card owner="christt105" repo="parallax-scene-editor" >}}

Anem a veure com funciona aquesta petita eina.

![L'editor obert sobre l'escena de demostració, amb les capes, els actors i la línia de temps visibles](parallax-editor-loop.gif)

Una escena de parallax aquí és un únic fitxer JSON: càmera, capes, actors, keyframes. L'edites mentre es reprodueix en bucle, i t'avisa en vermell en el moment en què alguna cosa no tancarà bé. Algunes de les coses que va acabar fent:

- **Llegeix i escriu directament al teu disc.** Obres una carpeta amb la File System Access API (només Chromium) i a partir d'aquí cada canvi s'escriu de nou al mateix fitxer uns quants centenars de mil·lisegons després que deixis de tocar res. Un missatge al costat de Save diu en tot moment on està escrivint.
- **Els sprites es recarreguen sols.** Repintes alguna cosa a Aseprite, guardes, i un parell de segons després ja és al canvas, sense que hagis de fer res.
- **Actors amb keyframes i easing**, més moviment `sine`/`cosine`/`wobble` a sobre per als detalls petits, un rebot a la bici, un ocell que es mou una mica mentre vola, sense haver-ho de dibuixar a mà.
- **Fa l'aritmètica de tancament de bucle per tu.** Si la velocitat d'una capa no encaixa al tile, o el nombre de cels d'un actor no divideix el bucle, l'editor no es limita a avisar-te: t'ofereix la solució exacta, les dues velocitats més properes que sí que tanquen, o una nova durada de bucle, amb un botó per a cadascuna.
- **Onion skin, línia de temps arrossegable, historial de desfer**, les coses de sempre que voldries i trobaries a faltar si no hi fossin.
- **Exporta a GIF, WebM o una seqüència de PNG.** El codificador de GIF està escrit des de zero. Si tota l'animació cap en 256 colors, que és el cas de gairebé tot el pixel art, la paleta és exacta.

Així es veu ja treballant sobre el projecte de veritat, amb el ciclista, Mudkip i un Tropius volant, i el panell de la dreta avisant en vermell que el cicle de Tropius no tanca el bucle:

![L'editor amb el projecte de Pokémon Maragda carregat, mostrant el ciclista, Mudkip, un Tropius volant i l'avís de tancament de bucle](editor-pokemon-project.png)

És completament open source, sense dependències ni pas de compilació, així que GitHub Pages el serveix tal qual. Hi ha una versió en viu a [christt105.github.io/parallax-scene-editor](https://christt105.github.io/parallax-scene-editor/) per si li voleu fer un cop d'ull.

## Fent el GIF de debò

Amb l'editor en un estat prou madur, vaig tornar al GIF en si. Vaig conservar el personatge en bicicleta, el vaig posicionar a l'escena, i em vaig posar a buscar un Pokémon corrent per posar al seu costat. Vaig trobar un spritesheet de Mudkip de Pokémon Mundo Misteriós que, sorprenentment, encaixava gairebé de fàbrica en la mida i la perspectiva que necessitava. Casualitat que és el meu Pokémon preferit.

![Un peluix de Mudkip del Pokémon Center del Japó que em va regalar un amic que em coneix molt bé](IMG_20260820_224501.jpg)

L'únic problema va ser el color. L'estil artístic de Mundo Misteriós és prou diferent al de Maragda perquè Mudkip desentonés al costat de tota la resta. Vaig demanar a Claude que analitzés els altres sprites de Pokémon que ja hi havia a l'escena i ajustés la paleta de Mudkip per igualar-la, i el resultat no està malament, sobretot al voltant de la vora.

![El spritesheet de Mudkip tal com surt de Pokémon Mundo Misteriós, sense retocar](mudkip-original.png)

![El spritesheet de Mudkip ja recolorit i ajustat, tal com es fa servir al projecte](mudkip-project.png)

![El spritesheet de Torchic fet servir al Pokémon Maragda](torchic-project.png)

També vaig provar unes animacions personalitzades de Pokémon que vaig trobar per internet, però l'estil i la perspectiva estaven massa lluny com per encaixar, així que les vaig descartar i em vaig quedar amb el protagonista i un Mudkip corrent sobre un fons de bosc. Hauria estat bé muntar un equip complet de sis que hagués jugat en algun moment, però portar els sprites a aquest nivell de consistència és més del que vull assumir ara mateix. Vaig aplicar un lleuger zoom out i ho vaig deixar aquí, senzill, però net.

![El resultat final: el ciclista i un Mudkip corrent en bucle sobre un fons de bosc](bike-ride.gif)

## Automatitzant l'actualització

L'editor exporta a GIF i WebM, així que el pla era: el repo del projecte de Pokémon exporta el GIF, i el README del perfil el referencia. Volia que això fos el més automàtic possible, així que vaig afegir una [GitHub Action](https://github.com/christt105/PokemonEmeraldIntroVideo/blob/main/.github/workflows/export.yml) al repo de [PokemonEmeraldIntroVideo](https://github.com/christt105/PokemonEmeraldIntroVideo) que s'executa a cada push: fa checkout d'una build de l'editor, la condueix en mode headless amb Playwright, i fa commit del GIF i el WebM resultants directament a `out/`.

{{< github-repo-card owner="christt105" repo="PokemonEmeraldIntroVideo" >}}

El README del perfil simplement apunta a la URL raw d'aquest fitxer. Així que en el moment en què toco una velocitat o moc un keyframe a l'escena i faig push, l'animació es regenera sola i el README s'actualitza amb ella, sense el pas d'exportar-commitejar-pushejar per la meva banda.

## El resultat

Una descripció de mi mateix, curta a propòsit, i una petita llista de l'stack que faig servir al dia a dia. Aquest gif és just a dalt de tot, com a capçalera, que és en realitat tota la idea: alguna cosa que digui una mica de mi abans que ho faci una sola paraula.

![El perfil de GitHub en mode fosc, amb el gif del ciclista en bucle a la capçalera del README](github-profile-loop.gif)

Tot això es va allargar força més del previst, i em fa gràcia haver acabat fent un editor de parallax complet només per aconseguir un GIF animat en una pàgina de perfil. No vaig arribar a mirar si ja existia alguna cosa semblant, però aquí està el meu, de codi obert, perquè qui vulgui retòrcer-lo cap a una altra cosa ho pugui fer. Ja tinc una altra idea per al README, una mica més ambiciosa, però aquesta és per a un altre post (si la vida m'ho permet).

Espero que us hagi agradat, i podeu provar l'editor si teniu al cap alguna escena de parallax pròpia.

Fins la propera!
