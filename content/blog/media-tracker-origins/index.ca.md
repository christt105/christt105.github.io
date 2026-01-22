---
title: "A la recerca del registre multimèdia definitiu: Els orígens"
description: Primera part d'una sèrie sobre la meva experiència portant un registre de pel·lícules, sèries i jocs. Un repàs a les eines i aprenentatges que em van portar al meu sistema actual.
date: 2026-01-22
image: cover.jpg
keywords:
  - media tracker
  - evolució
  - eines
  - pel·lícules
  - videojocs
  - sèries
  - organització
  - notion
readingTime: true
comments: true
draft: false
categories:
  - Media Tracker
tags:
  - Tracking
  - Organització
  - Retrospectiva
  - Notion
---
Hola de nou. Aquesta vegada ha passat menys temps des de l'últim post, i espero que sigui una mica més curt que l'anterior.

Vaig fer un post sobre aquest tema, però em va quedar excessivament llarg, així que l'he dividit en tres. Aquest serà el primer post dels tres, en el qual explicaré la meva experiència portant un registre de pel·lícules, sèries i jocs que he vist i jugat. En els següents dos posts, explicaré les dues noves eines per portar el meu registre multimèdia.

## Antecedents
Soc una persona a qui li agrada saber el que va fer i quan ho va fer, però a la vegada tinc mala memòria. D'altra banda, mai he tingut molta cultura cinèfila. Veia pel·lícules dins de la normalitat, però el que feien per la televisió i de tant en tant el que hi havia al cinema. De sèries pràcticament no en veia res, recordo veure *The Walking Dead* i *Breaking Bad* però no en vaig acabar cap. Pel que fa als jocs, la cosa canvia. De petit m'encantaven i vaig jugar-ne a bastants. Hi va haver una època que vaig deixar de jugar-hi, després hi vaig tornar amb força més moderació, em vaig posar a estudiar desenvolupament de videojocs i ara els faig. Quan em vaig fer gran, li vaig acabar agafant el gust a les pel·lícules i sèries; vaig començar a veure-les d'una altra manera. També hi va ajudar que ara és molt més fàcil tenir accés a qualsevol pel·lícula.

Tenir un control del que veus i jugues és bastant satisfactori. És informació sobre tu plasmada en un mitjà que et permet veure els teus gustos i evolució cultural. És per això que em va venir de gust tenir un registre multimèdia. El problema és que no hi ha cap solució disponible que compleixi totes les meves necessitats. Així que en aquest post faré retrospectiva de la meva evolució usant diferents eines per tenir un registre multimèdia.

## Twitter i TvTime
Tot va començar el 2022 quan em vaig adonar que no havia jugat a res del que portàvem d'any ni estava acostumat a veure sèries ni pel·lícules. Volia portar un control del que veia i jugava, així que vaig començar a fer un fil de Twitter amb els jocs que m'anava passant, i vaig fer servir [TvTime](https://www.tvtime.com) per portar un registre de les pel·lícules i sèries. Em vaig passar diversos jocs seguits aquell mes, però ho vaig deixar de banda. Estava fent servir TvTime per portar un control dels episodis però a vegades m'oblidava de seleccionar un episodi com a vist, soc una mica desastre.

El 2023 vaig començar un altre fil per a tot el que jugava i veia aquell any. Ara sí que ho portava més seriosament. Quan acabava un joc, una pel·lícula o una sèrie, escrivia un tuit amb un comentari i hi afegia imatges.

Vaig continuar el 2024 amb el mateix. TvTime el feia servir per portar el control del que veia per no oblidar-me de l'episodi pel qual anava i tenir perspectiva del que estava consumint.

## Stash i Backloggd
Per a les pel·lícules i sèries, TvTime estava bé, però per als videojocs tenia un problema. Vaig estar remenant diverses opcions.

Primerament vaig trobar [Stash](https://stash.games/), que és una aplicació per al mòbil per portar un tracking dels videojocs. Pots marcar els jocs com a completats amb la història principal, la principal més les secundàries o completat al 100%.

Posteriorment vaig veure [Backloggd](https://backloggd.com/) i vaig estar investigant. És molt semblant a Stash però en web. Tenien al roadmap una cosa que m'interessava molt i era la creació d'una API. Per la qual cosa podria llegir i modificar dades externament. Mai la van arribar a crear i la van treure del roadmap.

## Notion
Amb les eines prèviament esmentades podia portar un tracking de tot, però no era propietari de les meves dades, no tenia manera d'extreure les dades per ficar-les en una altra eina per si arribessin a descontinuar-la. Just el 2024 em va arribar la febre de [Notion](https://www.notion.com). Amb aquesta eina podia crear-me les meves pròpies bases de dades i se'm va acudir tenir el tracking allà. La idea era seguir usant Twitter com a aparador social, i TvTime com a tracker episòdic. El problema principal amb Twitter era que no podia modificar el tuit si hi havia algun error, és informació molt volàtil i buscar alguna cosa s'estava tornant molt complicat. TvTime simplement funcionava, li faltava alguna cosa com poder veure per on anaven els meus amics en cada sèrie, però per la resta simplement em funcionava.

D'altra banda, amb Notion podia generar una base de dades i que cada element fos una pel·lícula, sèrie o videojoc. Podia editar qualsevol nota en qualsevol moment i podia publicar-ho al web. Posteriorment van afegir possibilitat de fer gràfics per mostrar estadístiques. Tot era molt bonic, així que vaig crear una [plantilla](https://www.notion.com/templates/media-tracker-es) i vaig començar a migrar-ho tot a Notion. Vaig publicar [la pàgina web](https://christt105.notion.site/media-tracker) amb Notion i vaig seguir usant Twitter i TvTime com de costum; anava fent el tracking de les sèries a TvTime i en acabar una sèrie, joc o pel·lícula, la publicava a Twitter i l'afegia a Notion.

A Notion tenia diverses seccions on es mostraven els elements. Cada pel·lícula, sèrie o videojoc té diverses propietats. Les essencials són:
- Portada (Imatge): normalment la URL directa de la imatge de [tmdb](https://www.themoviedb.org/) o [thetvdb](https://www.thetvdb.com/), o una imatge penjada.
- Tipus (Seleccionar): Pel·lícula, Sèrie o Videojoc.
- Estat (Estat): Sense Començar, En curs, Pausat, Abandonat o Acabat.
- Completat (Data): Data de completat.
- Llançament (Data): Data de llançament, amb possibilitat de notificació per avisar.
- Propietats (Selecció múltiple): Diferents propietats com la plataforma de joc, si l'he vist al cinema, si és anime o si l'he completat al 100%.

![Exemple Nota a Notion](NotionMarioGalaxy2.png)

Cada vegada que volia afegir un nou element, el que havia de fer era anar a [TMDB](https://www.themoviedb.org/), [TVDB](https://www.thetvdb.com/) o [SteamGridDB](https://www.steamgriddb.com/), buscar el nom, copiar-lo, tornar a Notion, crear una nova nota, enganxar el nom, tornar al web, buscar pels cartells el que més m'agradés, copiar la URL, tornar a Notion, enganxar-lo a la secció de cover com a URL i finalment seleccionar el tipus d'element que és. No és excessiva feina, però res comparable al flux que he aconseguit ara.

Hi ha altres propietats com botons que canvien l'estat i la data o "recomanat a gent", però no són interessants. Amb totes aquestes propietats es pot fer un tracker més que decent.

### La web amb Notion
Notion et permet publicar les teves notes al web. Vaig publicar el Media Tracker amb Notion i em va generar aquesta URL: https://christt105.notion.site/media-tracker. La web és bàsicament la interfície de Notion però sense la possibilitat d'interactuar. No es pot canviar l'estil, per la qual cosa les portades queden molt petites i el resultat deixa bastant a desitjar.

![Web amb Notion](NotionFullScreen.png)

### Media Cover Recap
Abans d'acabar el 2024, em va agradar la idea de fer un collage amb totes les portades de tot el que havia consumit aquell any i em vaig posar a treballar-hi. Per solucionar això, Notion té una API que em permetia agafar informació de les meves bases de dades i així és com vaig fer el [Media Cover Recap](/ca/projects/mediacoverrecap/), un projecte web de [Godot](https://godotengine.org/es/) que generava collages de la base de dades de Notion. Òbviament Godot no és la millor eina per a això, però per aquell temps estava molt obsessionat amb Godot i vaig voler provar.

Funcionava decentment però el problema principal era el [CORS](https://developer.mozilla.org/es/docs/Web/HTTP/Guides/CORS), que no es permeten peticions HTTP d'un servei a un altre. Per la qual cosa o creava un petit servidor que redireccionés les peticions o ho feia aplicació d'escriptori i mòbil. I tampoc seria una bona solució perquè les imatges amb links poden deixar d'estar disponibles o l'API de Notion pot canviar i deixaria de funcionar. Així que tot el temps que li vaig dedicar a aquest projecte estava destinat a anar-se'n a les escombraries.

![Media Cover Recap a Godot](MediaCoverRecap.png)

## Conclusió
Vist tot això, volia alguna cosa més, donar-li una petita empenta perquè fos perfecte i em sentís còmode amb el que estava usant. La solució de Notion era més que decent, però tenia grans inconvenients. L'afegir un nou element era una mica incòmode, únicament podria usar-lo amb connexió a internet, navegar entre els elements era tediós i no permetia una estructura perfecta, la web era bastant lletja i immutable i el media cover recap estava destinat a la desaparició. Encara que fos molt poc probable, Notion podia eliminar tot el meu contingut si volgués.

És per això, i perquè vaig començar a fer servir [Obsidian](https://Obsidian.md), que vaig decidir crear una nova solució al meu Media Tracker, aquesta vegada una mica més complexa de configurar però molt més còmoda d'usar. He aconseguit una eina que s'adapta perfectament a mi. És còmoda i té tot el que necessito. Però això ho explicaré en el següent post.

Fins aviat!