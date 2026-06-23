---
title: "A la recerca del registre multimèdia definitiu: ara és personal"
description: "Vaig dir que la tercera part seria l'última, però he tornat. Amb l'ajuda de Claude he reescrit el meu Media Tracker: un plugin d'Obsidian que substitueix els scripts i el tema d'Hugo dividit perquè qualsevol pugui tenir el seu."
date: 2026-06-24
image: cover.png
keywords:
  - Obsidian
  - Hugo
  - Media Tracker
  - Plugin
  - Claude
  - TMDB
  - TheTVDB
  - IGDB
  - Automatització
readingTime: true
comments: true
categories:
  - Media Tracker
tags:
  - Obsidian
  - Obsidian-plugin
  - Hugo
  - Automation
  - Self-hosted
---

Hola de nou. Sé el que esteu pensant: "vas dir que la tercera part era l'última". I ho era. Però al final d'[aquell post](../media-tracker-hugo) vaig deixar una llista de coses que m'agradaria fer "algun dia", i resulta que aquest dia ha arribat. Així que considereu això un epíleg inesperado de la sèrie "A la recerca del registre multimèdia definitiu".

La novetat és que aquesta vegada no he anat sol. He reescrit bona part del Media Tracker amb l'ajuda de [Claude](../one-month-with-claude), i això ha canviat els comptes: coses que abans no pagava la pena fer perquè "ningú les faria servir" de cop i volta sí que en pagaven la pena, perquè fer-les ja no em costava setmanes. Us compto què he canviat i com està el projecte ara mateix.

## El problema que arrossegava

Si recordeu els dos posts anteriors, el meu Media Tracker tenia dues meitats:

1. **Obsidian**, on creo i edito cada pel·lícula, sèrie o joc. Funcionava a base d'ajuntar tres connectors ([Templater](obsidian://show-plugin?id=templater-obsidian), [Movie Search](obsidian://show-plugin?id=movie-search) i [QuickAdd](obsidian://show-plugin?id=quickadd)) i un grapat de scripts en JavaScript fets a mida.
2. **Hugo**, que converteix aquestes notes en [el web](https://christt105.github.io/MediaTracker/).

Totes dues funcionaven, pero totes dues tenien el mateix defecte: eren **impossibles de compartir**. Perquè una altra persona muntés el mateix havia de clonar el meu vault, instal·lar connectors concrets, importar paquets de QuickAdd, configurar scripts un a un i, a sobre, barallar-se amb un repositori d'Hugo on el contingut i el tema estaven barrejats. Jo mateix ho vaig dir al post anterior: *"hauria d'haver estat un plugin"* i *"una altra cosa important és separar el theme de la pàgina"*. Doncs això és just el que he fet.

## La meitat d'Obsidian: un plugin de veritat

El primer que he fet ha estat llençar a la escombraries els scripts i els tres connectors, i posar-ho tot en un únic plugin natiu d'Obsidian: **[hugo-mediatracker-plugin](https://github.com/christt105/hugo-mediatracker-plugin)**.

Ara no hi ha res a cablejar. Instales el plugin, obres els seus ajustos, hi poses les teves claus de l'API i ja està. Té la seva pròpia pantalla de configuració nativa, ordres, icones a la barra lateral i tecles de drecera configurables.

{{< github-repo-card owner="christt105" repo="hugo-mediatracker-plugin" >}}

![Pantalla d'ajusts nativa del plugin](PluginSettings.png)

El que fa, a grans trets:

- **Pel·lícules i sèries:** busques a **[TMDB](https://www.themoviedb.org/)** o **[TheTVDB](https://www.thetvdb.com/)** i crea la nota amb pòster, bàner, gèneres, repartiment, director, sinopsi i la resta. Pots triar quin proveïdor fa servir cada tipus; el més habitual (com a Jellyfin) és TMDB per a pel·lícules i TheTVDB per a sèries.
- **Sèries amb temporades ben numerades:** TheTVDB respecta la numeració real de les temporades, cosa que s'agraeix moltíssim amb l'anime i les sèries dividides, on TMDB ho fica tot en una sola temporada.
- **Videojocs:** busca a **[IGDB](https://www.igdb.com/)** i, si el joc és a Steam, fa servir l'art oficial automàticament.
- **Temporades:** des de la nota d'una sèrie oberta, genera la nota de la temporada enllaçada amb una ordre, tal com feia el vell script de QuickAdd.
- **Actualitzar imatges:** canvia la portada o el bàner triant d'una galeria paginada, amb **[SteamGridDB](https://www.steamgriddb.com/)** per als jocs.

![Cercador de pel·lícules i sèries del plugin](PluginAddMovie.png)

Una cosa que m'agrada especialment és que no s'inventa cap format nou: les notes que crea porten **exactament les propietats que espera el tema d'Hugo**, així que l'altra meitat del sistema segueix funcionant sinó tocant res. I per als qui feu servir [Pretty Properties](obsidian://show-plugin?id=pretty-properties), les portades i bàners es veuen igual de bé que abans.

![Nota creada pel plugin, amb Pretty Properties mostrant portada i bàner](PluginNote.png)

S'instal·la amb [BRAT](https://github.com/TfTHacker/obsidian42-brat), de manera que s'actualitza sol. El vell [media-tracker-obsidian-template](https://github.com/christt105/media-tracker-obsidian-template), amb els seus scripts i connectors preinstal·lats, l'he **arxivat**: ja no fa falta per a res i només el deixo com a referència històrica.

Volia fer un esment especial al plugin [Gubchik123/obsidian-movie-search-plugin](https://github.com/Gubchik123/obsidian-movie-search-plugin), ja que gran parte del flux el vaig treure d'aquí.

## La meitat d'Hugo: dividir el tema

La segona gran tasca pendent era separar el tema del contingut. Abans tot vivia al mateix repositori perquè, com vaig explicar, no em compensava el temps de fer-ho \"bé\" perquè ningú el fes servir. Ara l'he partit en **tres** peces seguint el patró de [mòduls d'Hugo](https://gohugo.io/hugo-modules/):

```
hugo-mediatracker-theme   →  el tema reutilitzable (mòdul d'Hugo)
mediatracker-starter      →  plantilla "Use this template" llista per clonar
MediaTracker              →  el meu contingut personal + l'script de migració
```

- **[hugo-mediatracker-theme](https://github.com/christt105/hugo-mediatracker-theme)** és el tema, ja com a mòdul independent construït sobre [hugo-blog-awesome](https://github.com/hugo-sid/hugo-blog-awesome). Per fer-lo servir només cal afegir un bloc al `hugo.toml`; les actualitzacions del tema base segueixen arribant soles.
- **[mediatracker-starter](https://github.com/christt105/mediatracker-starter)** és una plantilla de GitHub: li dones a "Use this template", `hugo server`, i tens un web funcionant amb un parell d'exemples de cada tipus. Això és el que ara puc ensenyar a la gent en lloc del meu repositori personal ple de coses meves.
- **[MediaTracker](https://github.com/christt105/MediaTracker)** es queda només amb el meu contingut, la meva configuració i el `migration.py`.

{{< github-repo-card owner="christt105" repo="mediatracker-starter" >}}

![Lloc d'exemple aixecat amb mediatracker-starter](StarterDemo.png)

## I de pas, gairebé tota la llista d'"algun dia"

Com que ja estava ficat en matèria i amb en Claude al costat, vaig aprofitar per ratllar pràcticament tots els "següents passos" que vaig deixar al post anterior:

- **Tipus de mitjans per dades.** Abans, afegir un tipus nou (por exemple, "llibres") significava tocar uns vuit arxius. Ara hi ha un únic `data/media_types.yml`: afegeixes un bloc allà i una entrada de menú, i llest. Les plantilles llegeixen d'aquest arxiu en comptes de tenir la llista de tipus escrita a mà per tot arreu.
- **Nova API per a llibres.** Per a tots aquells amants dels rectangles de coneixement, he provat [Open Library](https://openlibrary.org/) per poder crear notes de llibres molt fàcilment.
- **Estats normalitzats.** Els estats eren literals en espanyol (`Acabado`, `En Curso`...) repartits per la lògica de les plantilles. Ara són claus canòniques (`finished`, `in_progress`, `paused`, `dropped`, `not_started`) i les etiquetes visibles surten dels arxius de traducció. Això deixa preparat el terreny per tenir el web en diversos idiomes.
- **Cerca i filtres.** Era el que més il·lusió em feia. He tret les seccions separades per tipus i ara la pàgina principal té una **barra de filtres** (tipus, estat, nota, gènere, plataforma, any) i un **cercador** que funciona del costat del client. Una sola pantalla per veure-ho tot.

![Barra de filtres i cercador a la pàgina principal](FilterSearch.png)

- **Estadístiques.** Hi ha una pàgina d'estadístiques amb distribució de notes, desglossament per any, gràfics de plataformes i seccions específiques per a anime i cinema. Era una d'aquelles coses "totes de no res però que em feien il·lusió", com el generador de collages.

![Pàgina d'estadístiques](Stats.png)

- **Targetes socials arreglades.** Abans, en compartir un enllaç, no sortia la portada perquè l'`og:image` apuntava a un lloc que no existia. Ara les targetes de xarxes mostren la portada i un fragment de la meva ressenya.

![Vista prèvia d'una targeta social en compartir una entrada](SocialCard.png)

- **RSS millorat.** Els feeds porten ara miniatures de las portades, i segueix havent-hi un feed dedicat només a allò acabat (el que avisa el bot de Discord).

## El pipeline actual

Amb tot això, el flux complet queda així:

```
Obsidian + hugo-mediatracker-plugin   ← creo i edito les notes
        │  (Syncthing sincronitza el vault al mini PC)
        ▼
scripts/migration.py                  ← converteix el vault a contingut d'Hugo
        │  (cron diari a les 9:00 → git push)
        ▼
hugo-mediatracker-theme               ← pinta el web a partir del contingut
        │
        ▼
GitHub Actions → GitHub Pages         ← compila i publica
```

La part d'automatització del [post anterior](../media-tracker-hugo) segueix igual: el cron del mini PC executa l'script cada matí, i si hi ha canvis fa `commit` i `push`. La diferència és que ara la meitat d'Obsidian és un plugin de veritat i la meitat d'Hugo és un tema que qualsevol pot fer servir.

## Treballar amb Claude

No vull passar de puntetes per això, perquè és la raó per la qual aquest post existeix. Ja vaig comptar al post anterior que "la majoria de canvis els ha fet la IA", però això ha estat un altre nivell. Bona part de la reescriptura, el plugin sencer, la divisió en mòduls, la generalització dels tipus, la ha fet pràcticament en Claude.

El que és interessant no és que escrigui codi, sinó com canvia la decisió de **què val la pena fer**. Coses que feia mesos que aparcava amb l'excusa de "no tinc temps i ningú ho farà servir" van passar a ser tardes soltes.

Moltes d'aquestes funcionalitats li deia a en Claude des del mòbil que les fes, que ho aixequés localment i ho provés. Tot fet i comprovat per en Claude, fins que ho aixecava i jo ho provava al mòbil, feia una Pull Request, ho revisava per sobre i li deia que la fes el merge. Un bucle en el qual jo no estava ni a casa meva, simplement ho tenia al meu ordinador amb accés als meus projectes.

## Estat actual i el que queda

Per ser honest, no està tot tancat:

- El web segueix tenint el **contingut només en espanyol**. La interfície ja es pot traduir (les cadenes estan en arxius d'i18n), però traduir cada entrada és una altra història. De moment es queda en espanyol.
- Encara tinc idees a la recambra: un calendari amb els elements per dia, elements relacionats més treballats, i seguir afinant la lògica de sèries i temporades.

Però el més important per a mi ja està: **qualsevol pot muntar això**. Si vols el teu propi Media Tracker, instal·la el [plugin](https://github.com/christt105/hugo-mediatracker-plugin) a Obsidian i clona la [plantilla](https://github.com/christt105/mediatracker-starter) de Hugo. I si t'animes, deixa'm una estrella als repositoris o explica'm què et sembla als comentaris d'aquí sota; aquesta vegada sí que servirà perquè més gent ho faci servir.

Espero que us hagi agradat aquest epíleg. Ara sí, ens veiem al següent post.

Fins la propera!
