---
title: Sant Jordi Game Jam 2026
description: Crònica de la nostra participació a la Sant Jordi Game Jam 2026 desenvolupant un joc amb el motor Comet Engine.
date: 2026-04-23
image: cover.jpg
keywords: Sant Jordi Game Jam, Comet Engine, desenvolupament de videojocs, indie dev, C++
readingTime: true
comments: true
draft: false
categories:
  - Videojocs
  - Programació
tags:
  - Game Jam
  - Comet Engine
  - Sant Jordi
  - Indie
---
Hola de nou!

Vaig convèncer uns amics per apuntar-nos a la [Sant Jordi Game Jam 2026](https://santjordijam.github.io/), una Game Jam amb temàtica de Sant Jordi, una festivitat molt maca que es fa a Catalunya en la qual el 23 d'abril es regalen roses i llibres.

![Cartell Sant Jordi Game Jam 2026](cartel.webp)

La Game Jam donava unes tres setmanes per desenvolupar un videojoc, la qual cosa ens anava molt bé perquè no tenim gaire temps lliure. A més del joc, també s'ha de publicar una rosa digital.

Una altra cosa que vam decidir va ser el motor amb el qual faríem el joc, encara que no hi va haver gaire debat. Molts pensareu que no n'hi va haver perquè vaig triar Godot, però res més lluny de la realitat. Un dels integrants ([oriorii](https://github.com/OriolCS2)) fa uns quants anys que treballa en un motor de videojocs 2D: [Comet Engine](https://github.com/OriolCS2/CometEngine). Està a punt de treure la versió 2.0 amb un nou sistema de scripting i diverses millores més i, la veritat, era l'oportunitat perfecta per provar-lo fent un joc. És el primer joc que es farà amb Comet Engine.

Feia molt de temps que no participava en la creació d'un videojoc; fa molts anys que faig eines i webs, i la veritat és que ja venia de gust fer alguna cosa més creativa.

El tema de la Game Jam és:

> Tota pedra fa paret

Vam tenir diverses reunions de brainstorming. Hi va haver moltes idees, algunes més boges que d'altres. En un moment vaig voler donar-li un gir a la idea: la tercera persona del singular del present del verb "fer" (fa) i la nota musical "fa" són la mateixa paraula, i se'm va acudir fer-la més allargada i amb un to musical. Al Marc li va fer gràcia la idea i la vam embolicar. Vam dissenyar un sistema bastant complex on el jugador crearia una cançó per derrotar el drac. I vam començar a treballar en el joc.

L'Ori i el Marc van fer bastants avenços, però al cap de dos dies vam tenir una altra idea per donar-li un gir al concepte i se'ns va acudir barrejar un *bullet hell* amb un joc rítmic a l'estil [osu!](https://osu.ppy.sh/). Al mig estaria el drac tirant les boles de foc i el personatge es mouria alhora que clicaria sobre els cercles al ritme de la música.

El Marc i l'Ori hi van tornar a donar canya. El Marc va fer un sistema de ritme amb combos i permetent personalitzar la música. L'Ori va fer el sistema de les boles de foc del drac, alhora que anava arreglant i millorant el motor. Es va afegir el Dídac al projecte i va fer el moviment del personatge. Jo, com sempre, proposo les coses però mai faig res, encara que porto un mes bastant atrafegat. Quan es va calmar la cosa, jo vaig començar a fer les pedres que cauen del cel i que havien de funcionar com a bloquejadors de les boles de foc (d'aquí el tema "Tota pedra fa paret"...). També em vaig encarregar de testejar el motor a Linux i en un Windows amb gràfica integrada; anava raonablement bé.

Hi va haver un temps que ningú va fer res. Jo seguia barallant-me amb les pedres i l'Ori anava millorant i arreglant el motor. Fins que va arribar l'últim dia i calia lliurar.

Ni de fly hi arribàvem. A més, el Marc estava embolicat amb altres temes i l'Ori no podia perquè jugava el Barça... Vaig decidir treure la tisora i retallar i simplificar-ho tot al màxim. Se'm va acudir que només et poguessis moure si feies el joc del ritme, així era més emocionant per esquivar. Vaig posar un temporitzador de minut i mig i em vaig posar a fer *releases* i anar arreglant coses. El motor Comet va donar algun problema per exportar, però es va acabar solucionant sol. Es pot exportar a web per jugar des d'Itch.io, igual que amb Unity i Godot.

Faltava la rosa. La meva idea era fer un *shader* que dibuixés una rosa constantment, però no hi havia temps. Vaig passar per Discord una rosa dibuixada amb el mòbil al principi de la Jam, però volia alguna cosa diferent. Se'm va acudir que fos una rosa dibuixada amb text, així que vaig passar la imatge per un convertidor a ASCII i va quedar decent.

Vam lliurar justos i el joc és bastant lleig, però és jugable. La veritat és que treballar en un videojoc amb un motor propi ha estat una experiència bastant divertida.

Per a qui vulgui provar-lo:

https://christt105.itch.io/sant-jordi-the-stone-song

Això ha estat una petita pausa, vindran moltes més coses.

Fins a la pròxima i Feliç Sant Jordi!