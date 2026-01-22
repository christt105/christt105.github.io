---
title: Creant el meu Media Tracker amb Obsidian i Hugo
description: Com he migrat el meu Media Tracker a una solució pròpia fent servir Obsidian i Hugo, mantenint el control de les meves dades.
date: 2026-01-03
image: cover.png
keywords:
  - obsidian
  - hugo
  - media tracker
  - notion
  - markdown
readingTime: true
comments: true
draft: true
categories:
  - Desenvolupament Web
  - Self-hosting
tags:
  - Obsidian
  - Hugo
  - Media Tracker
  - Notion
  - Python
---
Hola de nou. Aquest cop ha passat menys temps des de l'últim post, i espero que sigui una mica més curt que l'anterior.

En aquest post us explicaré el que he fet en referència al meu nou [media tracker](https://christt105.github.io/MediaTracker/).

## Antecedents
Sento la turra, però abans necessito fer recapitulació d'aquest tema. Si no t'interessa pots anar directament a [La nova solució](#la-nova-solució).

### Twitter i TvTime
Tot va començar el 2022 quan em vaig adonar que no havia jugat a res del que portava d'any ni estava acostumat a veure sèries ni pel·lícules. Volia portar un control del que veia i jugava, així que vaig començar a fer un fil de Twitter amb els jocs que m'anava passant, i vaig fer servir [TvTime](https://www.tvtime.com) per portar un registre de les pel·lícules i sèries. Em vaig passar diversos jocs seguits aquell mes, però ho vaig deixar de banda. Estava utilitzant TvTime per portar un control dels episodis però a vegades m'oblidava de marcar un episodi com a vist, sóc una mica desastre.

El 2023 vaig començar un altre fil per a tot el que jugava i veia aquell any. Ara sí que ho portava més seriós. Quan acabava un joc, una pel·lícula o una sèrie, escrivia un tuit amb un comentari i afegia imatges.

Vaig continuar el 2024 amb el mateix. TvTime el feia servir per portar el control del que veia per no oblidar-me de l'episodi pel qual anava i tenir perspectiva del que estava consumint.

### Stash i Backloggd
Per a les pel·lícules i sèries, TvTime estava bé, però per als videojocs tenia un problema. Vaig estar barallant diverses opcions.

Primerament vaig trobar [Stash](https://stash.games/), que és una aplicació per al mòbil per portar un tracking dels videojocs. Pots marcar els jocs com a completat amb la història principal, la principal més les secundàries o completat al 100%.

Posteriorment vaig veure [Backloggd](https://backloggd.com/) i vaig estar investigant. És molt semblant a Stash però en web. Tenien al roadmap alguna cosa que m'interessava molt i era la creació d'una API. Per la qual cosa podria llegir i modificar dades externament. Mai la van arribar a crear i la van treure del roadmap.

### Notion
Amb les eines prèviament esmentades podia portar un tracking de tot, però no era propietari de les meves dades, no tenia manera d'extreure les dades per ficar-les en una altra eina per si arribessin a descontinuar-la. Just el 2024 em va arribar la febre de [Notion](https://www.notion.com). Amb aquesta eina podia crear-me les meves pròpies bases de dades i se'm va acudir tenir el tracking allà. La idea era seguir utilitzant Twitter, com a aparador social, i TvTime com a tracker episòdic. El problema principal amb Twitter era que no podia modificar el tuit si hi havia algun error, és informació molt volàtil i buscar alguna cosa s'estava tornant molt complicat. TvTime simplement funcionava, li faltava alguna cosa com poder veure per on anaven els meus amics en cada sèrie, però per la resta simplement em funcionava.

D'altra banda, amb Notion podia generar una base de dades i que cada element fos una pel·lícula, sèrie o videojoc. Podia editar qualsevol nota en qualsevol moment i podia publicar-ho al web. Posteriorment van afegir possibilitat de fer gràfics per mostrar estadístiques. Tot era molt bonic, així que vaig crear una [plantilla](https://www.notion.com/templates/media-tracker-es) i vaig començar a migrar tot a Notion. Vaig publicar [la pàgina web](https://christt105.notion.site/media-tracker) amb Notion i vaig seguir utilitzant Twitter i TvTime com de costum, anava trackejant les sèries a TvTime i en acabar una sèrie, joc o pel·lícula, la publicava a twitter i l'afegia a Notion.

A Notion tenia diverses seccions on es mostraven els elements. Cada pel·lícula, sèrie o videojoc té diverses propietats. Les essencials són:
- Portada (Imatge): normalment la url directa de la imatge de [tmdb](https://www.themoviedb.org/) o [thetvdb](https://www.thetvdb.com/), o una imatge pujada.
- Tipus (Seleccionar): Pel·lícula, Sèrie o Videojoc.
- Estat (Estat): Sense Començar, En curs, Pausat, Abandonat o Acabat.
- Completat (Data): Data de completat.
- Llançament (Data): Data de llançament, amb possibilitat de notificació per avisar.
- Propietats (Selecció múltiple): Diferents propietats com la plataforma de joc, si ho he vist al cinema, si és anime o si ho he completat al 100%.

![Exemple Nota a Notion](NotionMarioGalaxy2.png)

Cada vegada que volia afegir un nou element, el que havia de fer era anar a [TMDB](https://www.themoviedb.org/), [TVDB](https://www.thetvdb.com/) o [SteamGridDB](https://www.steamgriddb.com/), buscar el nom, copiar-lo, tornar a Notion, crear una nova nota, enganxar el nom, tornar a la web, buscar pels cartells el que més m'agradés, copiar la url, tornar a Notion, enganxar-lo a la secció de cover com a url i finalment seleccionar el tipus d'element que és. No és excessiu treball, però res comparable al flux que he aconseguit ara.

Hi ha altres propietats com botons que canvien l'estat i la data o recomanat a gent, però no són interessants. Amb totes aquestes propietats es pot fer un tracker més que decent.

#### La web amb Notion
Notion et permet publicar les teves notes al web. Vaig publicar el Media Tracker amb Notion i em va generar aquesta url: https://christt105.notion.site/media-tracker. La web és bàsicament la interfície de Notion però sense la possibilitat d'interactuar. No es pot canviar l'estil, per la qual cosa les portades queden molt petites i el resultat deixa bastant a desitjar.

![Web amb Notion](NotionFullScreen.png)

#### Media Cover Recap
Abans d'acabar el 2024, em va agradar la idea de fer un collage amb totes les portades de tot el que havia consumit aquell any i em vaig posar a treballar-hi. Per solucionar això, Notion té una API que em permetia agafar informació de les meves bases de dades i així és com vaig fer el [Media Cover Recap](https://christt105.github.io/es/projects/mediacoverrecap/), un projecte web de [Godot](https://godotengine.org/es/) que generava collages de la base de dades de Notion. Òbviament Godot no és la millor eina per a això, però per aquell temps estava molt obsessionat amb Godot i vaig voler provar.

Funcionava decentment però el problema principal era el [CORS](https://developer.mozilla.org/es/docs/Web/HTTP/Guides/CORS), que no es permeten peticions http d'un servei a un altre. Per la qual cosa o creava un petit servidor que redirigís les peticions o ho feia aplicació d'escriptori i mòbil. I tampoc seria una bona solució perquè les imatges amb links poden deixar d'estar disponibles o l'API de Notion pot canviar i deixaria de funcionar. Així que tot el temps que li vaig dedicar a aquest projecte estava destinat a anar-se'n a les escombraries.

![Media Cover Recap a Godot](MediaCoverRecap.png)

## La nova solució
Un cop vist tot fins arribar just a la nova solució, toca explicar de què tracta.

Pel meu nou Media Tracker volia tenir diversos punts presents:
- Totes les meves dades m'han de pertànyer.
- Poder migrar les dades a una altra aplicació si fes falta.
- Accessible des de qualsevol dispositiu. Ser capaç d'afegir, eliminar i editar qualsevol dada principalment des del meu mòbil, però que també sigui accessible des de l'ordinador.
- Poder afegir comentaris, imatges i vídeos a cada element.
- Tenir una pàgina web que sigui fàcilment accessible des de qualsevol dispositiu i completament adaptable a les meves necessitats.
- Poder afegir pel·lícules, sèries i jocs a la mateixa base de dades i que sigui còmode de fer-ho.

Després d'investigar, vaig decidir decantar-me per la idea d'utilitzar [Obsidian](https://obsidian.md/) per a la creació i edició de cada element del tracker i [Hugo](https://gohugo.io/) com a generador de la pàgina web.

### Obsidian
Per als que sabeu com funciona Notion, haureu arquejat la cella abans al dir que amb Notion les meves dades em pertanyien i no és cert, a Notion les dades no són teves, et poden revocar accés a ells quan ells considerin perquè són de la seva propietat, així que tocava moure fitxa.

D'una febre a una altra, va arribar a la meva vida [Obsidian](https://obsidian.md/). Gràcies a la meva nova adquisició, un mini pc, podia sincronitzar les meves notes de manera molt eficaç, com ja vaig explicar al meu altre post [Seis meses con mi primer servidor casero](https://christt105.github.io/es/blog/six-months-with-my-first-home-server/), que era el punt que em tirava més enrere d'Obsidian. Ara explicaré com tinc configurat Obsidian pel Media Tracker, pot ser que en un futur faci un post explicant com tinc configurat tot el meu Obsidian, ja que em sembla una molt bona eina per integrar al teu dia a dia.

#### Organització
Vaig decidir tenir el Media Tracker dins del meu vault principal d'Obsidian. El Media Tracker viu únicament en una carpeta, així evito que es barregi amb les altres notes i són més fàcils de diferenciar. Dins de `Juegos/`, `Movies/`, `TVs/` i `Seasons/` viuen individualment cada instància de jocs, pel·lícules, sèries i temporades respectivament. Els noms són rars per com tinc organitzats els plugins. També tinc la carpeta `Portadas/` on poso les imatges de les portades i banners d'elements que no tenen a la web, sobretot de fangames.

![Carpetes del meu Media Tracker dins d'Obsidian](MediaTrackerFolders.png)

A `Media Tracker/` hi ha l'arxiu `Media Tracker Views.base` que és un arxiu base amb diverses vistes. Les bases és un afegit molt recent, just ho acabaven de posar quan vaig començar a utilitzar Obsidian. És un arxiu que et permet poder visualitzar les teves notes de diverses formes, semblant a les vistes de Notion. Té una API per la qual cosa la comunitat ja està començant a utilitzar-les per a coses més complexes. De moment únicament he creat vistes molt bàsiques, gairebé no les faig servir, ja que tinc la web.

![Media Tracker Base View All](MediaTrackerBaseAll.png)
![Media Tracker Base View Anime](MediaTrackerBaseAnime.png)
![Media Tracker Base View Table](MediaTrackerBaseTable.png)

#### Sèries i Temporades
Amb les sèries tenia un problema. No sabia què fer amb les sèries amb temporades. D'una banda, hi ha sèries que tenen diverses temporades i les veig en diferents moments, per la qual cosa hauria de separar cada sèrie per temporades, però d'altra banda, fer una nota de sèrie duplicada pot quedar estrany si únicament hi ha una temporada. També és veritat que hi ha sèries que organitzen molt malament les temporades, la qual cosa pot arribar a ser caòtic.

És per això que al final vaig decidir utilitzar una solució híbrida. Cada sèrie tindrà la seva pròpia nota amb les mateixes propietats que les pel·lícules. Si una sèrie té únicament una temporada, es fa servir la nota de la sèrie. Si una temporada té diverses temporades, es crea una nota per cada temporada i a la data de la nota de la sèrie se li posa la mateixa que l'última temporada vista.

L'únic dolent és que he de tenir en compte d'actualitzar dos estats i dues dates per a una mateixa sèrie amb la nota de la sèrie i de l'última temporada vista. Crec que és la solució més factible a aquest problema.

#### Plugins i Scripts
Una de les coses més increïbles que té Obsidian és la personalització amb els plugins creats per la comunitat. S'obre un camp gegant de possibilitats. Principalment he utilitzat tres plugins que han fet que l'experiència d'utilitzar el Media Tracker sigui molt millor que amb les solucions abans vistes.

##### Templater
El plugin [Templater](obsidian://show-plugin?id=templater-obsidian) va molt bé per utilitzar plantilles, executar accions i afegir informació en crear noves notes. Això ens ajudarà a importar informació de bases de dades de pel·lícules, sèries i jocs i organitzar les notes al moment de crear-les.

##### Movie Search
El plugin [Movie Search](obsidian://show-plugin?id=movie-search) és un plugin una mica antic però segueix funcionant molt bé. Té alguna cosa que canviaria, però de moment és més que suficient. El plugin afegeix un botó que obre un panell per introduir el nom de la pel·lícula o sèrie.

![Panell de Movie Search Plugin per buscar una pel·lícula o sèrie](MovieSearchPluginSearch.png)

En buscar farà una cerca utilitzant l'API de TMDB i et mostrarà tots els resultats.

![Resultats de la cerca amb Movie Search Plugin](MovieSearchPluginResults.png)

En seleccionar una opció, crearà una nova nota amb una plantilla que he configurat, reemplaçarà les variables pels valors de la pel·lícula o sèrie i executarà el codi de Templater que he posat. TMDB té dos tipus `movie` i `tv` que s'afegiran directament a la propietat de `type` per poder diferenciar-la. S'assignarà un pòster i un banner predeterminat per TMDB utilitzant el link a la imatge i s'emmagatzemarà l'id de TMDB per poder referenciar-la després. Es guardaran també els gèneres i la sinopsi formatejant-los de manera correcta, ja que el plugin té problemes si inclouen barres o cometes dobles. També comprova si és una sèrie i li afegeix la propietat de `temporadas` (temporades). Per últim, agafa l'any i modifica el nom de l'arxiu per incloure'l i evitar problemes en crear notes de dues pel·lícules diferents amb el mateix nom. La plantilla que estic utilitzant actualment és aquesta:

```
---
title: "{{title}}"
type: <% "{{media_type}}".toLowerCase() %>
date: 
rewatches: []
release_date: "{{release_date}}"
status: Sense Començar
cover: "{{poster_path}}"
banner: "{{backdrop_path}}"
rating: 
genres: <%=movie.genres.map(genre=>`\n  - ${genre}`).join('')%>
tmdb_id: <%=movie.id %>
tags: []
related: []
overview: "<%= movie.overview.replace(/[\r\n]+/g, ' ').replace(/"/g, '\\"') %>"
<%* if("{{media_type}}".toLowerCase() == "tv") { -%>
temporadas: []
<%* } -%>
---

<%*
const year = "{{release_date}}".split("-")[0];
if (year) {
        await tp.file.rename(`${tp.file.title} (${year})`);
    }
%>
```

I aquest seria el resultat final de la nota:
![Resultat d'una nota creada amb Movie Search Plugin](MovieSearchPluginResultNote.png)

Amb aquest plugin tenim coberta la creació de les pel·lícules i sèries amb molt pocs clics i sense sortir de l'aplicació. Vegem ara l'altre plugin que ens solucionarà els videojocs, temporades i ens farà la vida més fàcil amb algunes característiques.

##### QuickAdd
El plugin de [QuickAdd](obsidian://show-plugin?id=quickadd) et permet fer moltes coses, però principalment jo l'utilitzo per crear scripts i executar-los mitjançant accions. D'aquesta manera puc crear i editar les meves notes fàcilment i accedint a APIs externes des de la interfície d'Obsidian. Els scripts són en JavaScript, la majoria estan fets amb IA i posteriorment els edito, és ràpid i no s'equivoca gaire. Aquestes són algunes de les funcions que he creat:

###### Afegir Joc
Pels videojocs vaig decidir utilitzar la base de dades de [IGDB](https://www.igdb.com/). Per poder utilitzar l'API de IGDB has d'iniciar sessió amb Twitch, la qual cosa és una mica rara. La veritat que les bases de dades en àmbit de videojocs està bastant per darrere de les pel·lícules i sèries. Totes estan completament en anglès i la informació no és completa per a tots els jocs. Vaig decidir utilitzar IGDB a diferència de les altres perquè era l'única que tenien fangames que havia jugat.

Vaig fer servir aquest script de [Elaws/script_videogames_quickAdd](https://github.com/Elaws/script_videogames_quickAdd) i el vaig modificar per personalitzar-lo a la meva plantilla. Així seria una nota d'un videojoc vista des d'Obsidian:

![Exemple Nota Silksong](NoteSilksong.png)

###### Crear Temporada
Després de decidir l'estructura de Sèries/Temporades, necessitava que amb un botó pogués crear, a partir d'una nota tipus Sèrie, una nota de tipus Temporada amb tots els atributs i referència de la Sèrie. Vaig fer un script que en executar-lo, comprova que estàs en una nota de tipus sèrie, et demana un número de temporada i genera una nota amb el nom de la sèrie i afegint `" - Temporada X"` al final. La nova nota copia les imatges de la sèrie i les enllaça mitjançant la propietat `temporades` i `serie`. Així quedaria una nota de temporada.

![Exemple Nota Temporada Obsidian](MediaTrackerSeasonObsidian.png)

###### Actualitzar Imatges
Utilitzar únicament la primera imatge que proporcionaven TMDB i IGDB no és molt personalitzable i haver de buscar-les manualment a les diferents webs no era una opció. He creat un script que et mostra diferents imatges, selecciones la que t'agrada i la substitueix directament. L'script funciona tant per a portades com per a banners, en executar l'acció et pregunta quina vols canviar. L'script identifica quin tipus d'element és, si és pel·lícula o sèrie, busca a TMDB amb l'id guardat a la nota i et va ensenyant portades de 5 en 5, si és videojoc, uso l'api de [SteamGridDb](https://www.steamgriddb.com/), ja que les imatges d'IGDB són molt dolentes. A les notes de videojocs primerament busca si hi ha un id de SteamGridDb, si no el troba, et busca jocs a la seva base de dades amb un nom similar i en seleccionar-lo, guarda l'id per a futures cerques.
![ObsidianUpdateCover](ObsidianUpdateCover.png)
![ObsidianUpdateBanner](ObsidianUpdateBanner.png)

#### Plantilla
Escrivint aquest post m'he adonat que hi ha moltes coses configurades i pot ser una mica embolic. No he afegit els scripts ni la resta de plantilles per no fer el post més llarg i tediós. Si estàs interessat en que publiqui una plantilla d'aquest media tracker i un tutorial, no dubtis en deixar-ho als comentaris.

### Hugo
[Hugo](https://gohugo.io/) és una eina magnífica. És un generador de webs estàtiques enfocat en el format Markdown. Ja vaig parlar d'Hugo al meu post [Porteando mi web a hugo](blog/porting-to-hugo/index.es.md), on vaig estar creant la meva pàgina web i aquest mateix blog amb Hugo. Em sembla meravellosa i s'integra molt bé amb Obsidian, ja que el nucli d'ambdues eines són els arxius Markdown, així que vaig decidir utilitzar-lo per crear la pàgina web i que sigui l'aparador del meu Media Tracker.

#### Tema
Hugo funciona a partir d'un tema. Òbviament no hi ha cap tema (o jo no l'he trobat) que tingui tot el que necessito. Igualment no anava a fer un tema de zero, la meva idea era fer el mateix que vaig fer amb la pàgina web, buscar un tema i editar-lo al meu gust, ja que no tinc molts coneixements de programació web. Vaig estar mirant i em vaig decantar finalment pel tema [hugo-blog-awesome](https://github.com/hugo-sid/hugo-blog-awesome). És un tema molt simple i minimalista, just el que buscava per començar.

Un cop triat el tema, vaig crear un [repositori a GitHub](https://github.com/christt105/MediaTracker) que contindrà el contingut de la pàgina web i les modificacions del tema. Podria haver separat el contingut de les modificacions del tema, però al ser un projecte relativament simple, vaig decidir posar-lo al mateix repositori. Hugo funciona de manera que si crees un arxiu amb el mateix nom, utilitzarà aquell com a prioritat al del tema. Així, que al repositori viu el contingut de la web, que simplement és un arxiu Markdown per cada element, i els arxius per sobreescriure el tema amb el necessari.

També vaig configurar a [GitHub Actions](https://docs.github.com/actions), perquè cada commit, generés els arxius de la web i los publiqui en una web. Podeu veure el resultat final a [https://christt105.github.io/MediaTracker/](https://christt105.github.io/MediaTracker/).

##### Canvis en el tema
No entraré en molt detall perquè la majoria de canvis els ha fet la IA. Principalment he agafat l'estil del tema base i li he afegit estils nous i he canviat pràcticament tota l'estructura. He canviat la pàgina principal per mostrar una vista en galeria de cada element ordenat de més recent a més antic. Les pàgines de cada categoria és semblant a la principal. També he afegit un script que carrega un banner aleatori cada vegada que accedeixes a la web.

##### RSS
No acostumo a utilitzar [RSS](https://wikipedia.org/wiki/RSS) encara que em sembla interessant per notificar contingut nou. He creat dos arxius, [un amb tots els elements](https://christt105.github.io/MediaTracker/index.xml) i un altre [únicament amb els elements acabats](https://christt105.github.io/MediaTracker/acabados.xml). L'he afegit al servidor de Discord, encara que els meus amics encara no ho saben.

##### Script
Encara que Hugo funciona amb Markdown, cal fer uns ajustos pel que fa a estructura perquè funcioni tot correctament, així que he creat un script en Python per convertir les notes. L'script el tinc al repositori de la web: [https://github.com/christt105/MediaTracker/scripts/migration.py](https://github.com/christt105/MediaTracker/blob/main/scripts/migration.py).

L'script l'executo cada vegada que vull actualitzar la web. Primerament esborra el contingut generat per l'script anteriorment per començar sempre net i posteriorment va recorrent cada nota del meu vault personal, crea una carpeta al repositori amb el nom i enganxa la nota dins de la carpeta.

Cada nota és processada per fer alguns canvis. Primerament canvia tots els Wikilinks, els que utilitza obsidian d'aquesta forma `[[Una altra Nota]]`, per un link en format Markdown, si la nota referenciada és una altra pel·lícula, sèrie o videojoc, o per text simple. Això ho faig perquè el mateix referencio una nota del meu vault personal que no estarà a la web o referencio una pel·lícula dins d'una altra. Seguidament modifico els links a youtube que hi hagués a la nota i els modifico pel [shortcode](https://gohugo.io/content-management/shortcodes/) d'Hugo perquè es mostri correctament.

Hi ha diversos processos que envolten el tema de les imatges. Principalment tinc tres tipus d'imatges.

Primerament tenim les imatges de les portades i els banners que estan en un servei extern com TMDB o Steamgridb. En aquesta categoria entren totes les imatges que estiguin dins de les propietats `cover` i `banner` i tinguin una url a tmdb, tvdb, steamgriddb o on sigui. Aquestes imatges són les úniques que es poden perdre en algun moment, el servei pot tancar o eliminar aquestes imatges. Aquestes imatges es copien al repositori, així evito que si una imatge deixa d'estar disponible a internet, jo la tinc guardada i a l'hora de carregar la web totes provenen del mateix servidor. Cada url d'imatge es codifica perquè tingui el seu nom identificatiu que sempre serà el mateix. L'script comprova si aquesta imatge ja està al repositori i si és el cas la ignora i si no, la descarrega. En cas que la url de la imatge canviï, la guardaria al repositori i al final de l'script elimina totes les imatges que no s'han utilitzat.

D'altra banda tenim les imatges de les portades i banners que es guarden localment al propi vault. Aquestes imatges es copien sempre ja que poden canviar però tenir el mateix nom, i en ser un procés local no dura gaire. Totes les imatges es guarden en una carpeta de memòria cau i posteriorment es van copiant a cada carpeta de cada nota que la faci servir. Se separen en carpetes per a les portades i els banners i es guarden amb un sufix per saber la procedència de l'arxiu.

Finalment tenim les imatges que estan dins de les notes. Aquestes imatges es copien directament del vault i es guarden dins de la carpeta de la nota.

D'aquesta manera, l'script genera una còpia immutable de les meves dades, les meves notes al vault principal sempre seran les que es modifiquin. Gràcies a que guardo les imatges com a memòria cau, l'script és molt ràpid i evito que la web deixi de funcionar correctament per factors externs.

##### Generació de Collages
Encara falta una cosa per integrar, el generador de collages. És una ximpleria però em feia il·lusió.

No estava molt segur de si podria fer-ho sent una pàgina web estàtica, però sí que és possible. Gràcies a l'eina [html2canvas-pro](https://yorickshan.github.io/html2canvas-pro/), és possible generar una imatge d'un element de la web.

Després de diversos intents perquè em generava les imatges amb mala qualitat si hi havia força elements, vaig aconseguir que descarregués una imatge amb la qualitat original de cada portada. Si hi ha molts elements, la mida de la imatge és bastant gran. Vaig afegir diversos paràmetres per filtrar per data i tipus i modificar el nombre de columnes. Ara puc generar un collage de les portades des de qualsevol dispositiu i en qualsevol moment amb un clic.

![Generador de Collages](CollageGenerator.png)

##### Comentaris
A Hugo és freqüent tenir un apartat de comentaris. No crec que sigui molt útil, però em feia il·lusió posar-ho. Al blog estic utilitzant [Giscus](https://giscus.app), un sistema de comentaris que utilitza les discussions de Github per emmagatzemar-los. El problema principal és que necessites un compte de GitHub per poder comentar, la qual cosa afegeix una barrera important perquè algú comenti. Per a un blog de tecnologia és més que acceptable i funciona molt bé, però per a un lloc de pel·lícules, sèries i videojocs, no és un sistema que encaixi. Vaig estar mirant [Disqus](https://disqus.com/), però afegeix anuncis a la capa gratuïta i no vull res d'això a les meves pàgines web. També vaig estar mirant [Cusdis](https://cusdis.com/), que és una alternativa opensource i autoallotjada, però em fa bastant mandra hostejar-lo quan realment ningú l'utilitzarà. Així que al final he utilitzat Giscus.

![Comentari](ComentarioGiscus.jpg)

##### Actualitzador automàtic
Ja tinc el web configurat i l'script per convertir les meves notes d'Obsidian a Hugo. Tanmateix, sorgeix un problema: no vull haver de passar les notes a l'ordinador i executar l'script manualment cada vegada que vulgui actualitzar alguna cosa.

Gràcies al meu Mini PC i a [Syncthing](https://syncthing.net/), tinc el meu vault d'Obsidian sincronitzat entre tots els meus dispositius. D'aquesta manera, qualsevol canvi que faci a les notes des del mòbil es reflecteix automàticament al Mini PC. Amb la carpeta del Media Tracker sempre sincronitzada, només faltava automatitzar l'execució.

Per fer-ho, he configurat una tasca al Mini PC utilitzant [cron](https://wikipedia.org/wiki/Cron_/(Unix/)) que s'executa cada dia a les 9:00. Aquesta tasca llança l'script de Python sobre el repositori i, un cop finalitzat, si detecta canvis, fa un git push. Així, cada matí, el sistema actualitza els fitxers i els puja a GitHub, generant una nova versió del web. Ja no m'he de preocupar pel desplegament, tot el procés és completament automàtic.

## Pròxims passos
I amb això ja he explicat tot el que tinc, suficient. He hagut de fer una aturada d'aquest post per optimitzar la web perquè utilitzava moltíssims recursos en descarregar les imatges.

Deixaré aquest projecte per un temps però tinc moltes idees per anar millorant. M'agradaria afegir gràfics per mostrar estadístiques del que veig i jugo. També m'agradaria afegir un sistema de filtres a la pantalla principal, per poder filtrar per tipus i etiquetes, i així eliminar les seccions. Un altre punt important és donar-li ús a la propietat de `rewatches` i generar una entrada en cada data inclosa en aquesta propietat, de manera que si hi ha una pel·lícula que he vist dues vegades, que aparegui en ambdues dates. M'agradaria afegir un motor de cerca, per poder anar directament a la nota per nom. Finalment, hauria de dedicar-li una mica de temps a optimitzar la web, afegir elements relacionats en cada nota i millorar la lògica de sèries i temporades.

## Conclusions
No és l'eina més còmoda de configurar i utilitzar, però té tot el que vull. Això no és cap tutorial, per la qual cosa hi ha molts arxius que no els he posat per no fer el post molt llarg. Si estàs interessat en que publiqui un tutorial sobre com crear aquest Media Tracker, fes-m'ho saber als comentaris de sota.

Probablement podria haver creat un post per cada secció perquè m'ha quedat un post molt més llarg del que m'agradaria.

Espero que t'hagi agradat i ens veiem en el següent post.