---
title: "A la recerca del registre multimèdia definitiu: Hugo"
description: "Tercera i última part de la sèrie sobre el meu Media Tracker. Explico com fer servir Hugo per visualitzar notes d'Obsidian i com automatitzar tot el procés."
date: 2026-05-03
image: cover.png
keywords: ["Hugo", "Obsidian", "Media Tracker", "Python", "Automatització", "GitHub Actions", "Self-hosting"]
readingTime: true
comments: true
draft: false
categories:
  - Media Tracker
tags:
  - Hugo
  - Obsidian
  - Python
  - Automation
---

Hola de nou. Avui us porto la tercera i última part de la sèrie de "A la recerca del registre multimèdia definitiu". Avui us ensenyaré l'última peça necessària per complir tots els punts que requeria aquesta nova solució.

[Al primer post](../media-tracker-origins) vaig parlar de totes les eines que vaig provar per tenir un registre de pel·lícules, sèries i jocs vistos i completats. [Al segon post](../media-tracker-origins) us vaig explicar el cor del meu nou Media Tracker fent servir [Obsidian](https://obsidian.md) amb uns pocs connectors i scripts. En aquest últim post us explicaré com he fet la pàgina web fent servir les dades d'Obsidian. Aquesta és la pàgina web: https://christt105.github.io/MediaTracker/.

## Hugo
[Hugo](https://gohugo.io/) és una eina magnífica. És un generador de webs estàtiques enfocat en el format Markdown. Ja vaig parlar de l'Hugo al meu post "[Portant la meva web a Hugo](blog/porting-to-hugo/index.es.md)", on vaig estar creant la meva pàgina web i aquest mateix blog amb Hugo. Em sembla meravellosa i s'integra molt bé amb l'Obsidian, ja que el nucli de totes dues eines són els arxius Markdown, així que vaig decidir fer-lo servir per crear la pàgina web i que sigui l'aparador del meu Media Tracker.

### Tema
L'Hugo funciona a partir d'un tema. Òbviament no hi ha cap tema (o jo no l'he trobat) que tingui tot el que necessito. Igualment no pensava fer un tema des de zero; la meva idea era fer el mateix que vaig fer amb la pàgina web: buscar un tema i editar-lo al meu gust, ja que no tinc gaires coneixements de programació web. Vaig estar mirant i em vaig decantar finalment pel tema [hugo-blog-awesome](https://github.com/hugo-sid/hugo-blog-awesome). És un tema molt simple i minimalista, just el que buscava per començar.

Un cop triat el tema, vaig crear un [repositori a GitHub](https://github.com/christt105/MediaTracker) que contindrà el contingut de la pàgina web i les modificacions del tema. Podria haver separat el contingut de les modificacions del tema, però en ser un projecte relativament simple, vaig decidir posar-ho al mateix repositori. Realment seria l'ideal així més gent ho podria fer servir, però últimament vaig faltat de temps i vull treballar en diversos projectes sense perdre el temps en feina que després ningú farà servir. Igualment, si t'agradaria tenir una cosa així de forma més fàcil, fés-m'ho saber deixant el teu suport.

L'Hugo funciona de manera que, si crees un arxiu amb el mateix nom, farà servir aquest com a prioritat davant del del tema. Així, al repositori hi viu el contingut de la web, que simplement és un arxiu Markdown per cada element, i els arxius per sobreescriure el tema amb el que calgui.

També vaig configurar [GitHub Actions](https://docs.github.com/actions) perquè a cada commit generés els arxius de l'Hugo i els publiqués en una web. Tot allotjat a GitHub.

#### Canvis al tema
No entraré en gaires detalls perquè la majoria de canvis els ha fet la IA. Principalment he agafat l'estil del tema base, li he afegit estils nous i he canviat pràcticament tota l'estructura. He canviat la pàgina principal per mostrar una vista en galeria de cada element ordenat de més recent a més antic. Les pàgines de cada categoria són semblants a la principal. També he afegit un script que carrega una capçalera aleatòria cada cop que accedeixes a la web. Cada element té la seva pàgina, on es mostren tots els detalls: portada, nota, data de compleció i comentari personal.

![Imatge de la pàgina principal](Preview.png)

#### RSS
No acostumo a fer servir [RSS](https://wikipedia.org/wiki/RSS) encara que em sembla interessant per notificar contingut nou. He creat dos arxius, [un amb tots els elements](https://christt105.github.io/MediaTracker/index.xml) i un altre [només amb els elements acabats](https://christt105.github.io/MediaTracker/acabados.xml). Ho he afegit al servidor de Discord, encara que els meus amics encara no ho saben. Així que cada cop que vegi o acabi una pel·lícula, sèrie o videojoc, el bot enviarà un missatge amb l'enllaç a la web d'aquell element.

![Missatge RSS a Discord](RSS.png)

#### Generació de Collages
Hi havia una cosa per integrar: el generador de collages. És una ximpleria, però em feia il·lusió.

No estava gaire segur de si podria fer-ho sent una pàgina web estàtica, però sí que és possible. Gràcies a l'eina [html2canvas-pro](https://yorickshan.github.io/html2canvas-pro/), és possible generar una imatge d'un element de la web.

L'eina fa exactament el que diu el seu nom. Crea captures de pantalla a partir d'elements HTML de la pàgina. Té algunes limitacions però res que afecti aquesta web.

Després de diversos intents perquè em generava les imatges amb mala qualitat si hi havia bastants elements, vaig aconseguir que descarregués una imatge amb la qualitat original de cada portada. Si hi ha molts elements, la mida de la imatge és bastant gran. Vaig afegir diversos paràmetres per filtrar per data i tipus i modificar el nombre de columnes. Ara puc generar un collage de les portades des de qualsevol dispositiu i en qualsevol moment amb un clic, simplement anant a l'apartat [Collage](https://christt105.github.io/MediaTracker/collage/) de la meva web.

![Generador de Collages](CollageGenerator.png)

#### Comentaris
A l'Hugo és freqüent tenir un apartat de comentaris. No crec que sigui molt útil, però em feia gràcia posar-ho. Al blog estic fent servir [Giscus](https://giscus.app), un sistema de comentaris que fa servir les discussions de GitHub per emmagatzemar-los. El problema principal és que necessites un compte de GitHub per poder comentar, cosa que afegeix una barrera important perquè algú comenti. Per a un blog de tecnologia és més que acceptable i funciona molt bé, però per a un lloc de pel·lícules, sèries i videojocs, no és un sistema que encaixi. Vaig estar mirant [Disqus](https://disqus.com/), però afegeix anuncis a la capa gratuïta i no vull res d'això a les meves pàgines web. També vaig estar mirant [Cusdis](https://cusdis.com/), que és una alternativa de codi obert i allotjada per un mateix, però em fa força mandra allotjar-ho quan realment ningú ho farà servir. Així que al final he fet servir Giscus una altra vegada.

![Nota d'una pel·lícula a la web amb un comentari](ComentarioGiscus.jpg)

#### Capçalera aleatòria 
La web es veia bastant bé, però volia una mica de dinamisme. Se'm va acudir la idea de reutilitzar les capçaleres de cada element i que cada cop que entressis a la pàgina, mostri una capçalera aleatòria de tots els elements completats.

### Script
Encara que l'Hugo funciona amb Markdown, cal fer uns ajustos pel que fa a l'estructura perquè funcioni tot correctament, així que he creat un script en Python per convertir les notes d'Obsidian a Hugo. L'script el tinc al repositori de la pàgina web: [https://github.com/christt105/MediaTracker/scripts/migration.py](https://github.com/christt105/MediaTracker/blob/main/scripts/migration.py).

L'script l'executo cada cop que vull actualitzar la web. Primerament esborra el contingut generat per l'script anteriorment per començar sempre net i posteriorment va recorrent cada nota del meu vault personal, crea una carpeta al repositori amb el nom de la pel·lícula, sèrie o joc i enganxa la nota dins de la carpeta.

Cada nota és processada per fer alguns canvis. Primerament canvia tots els Wikilinks, els que fa servir l'Obsidian d'aquesta forma `[[Altra Nota]]`, per un enllaç en format Markdown si la nota referenciada és una altra pel·lícula, sèrie o videojoc, o per text simple si la referència està fora de la carpeta `Media Tracker/` del meu vault. Això ho faig perquè tant puc referenciar una nota del meu vault personal que no estarà a la web com referenciar una pel·lícula dins d'una altra. Seguidament modifico els enllaços a YouTube que hi hagués a la nota i els substitueixo pel [shortcode](https://gohugo.io/content-management/shortcodes/) de l'Hugo perquè es mostri correctament integrat a la web.

Hi ha diversos processos que envolten el tema de les imatges. Principalment tinc tres tipus d'imatges. 

Primerament tenim les imatges de les portades i les capçaleres que estan en un servei extern com TMDB o Steamgridb. En aquesta categoria entren totes les imatges que estiguin dins de les propietats `cover` i `banner` i tinguin una URL a TMDB, TVDB, Steamgridb o on sigui. Aquestes imatges són les úniques que es poden perdre en algun moment; el servei pot tancar o eliminar aquestes imatges. Aquestes imatges es copien al repositori; així evito que si una imatge deixa d'estar disponible a internet, jo la tingui guardada i a l'hora de carregar la web totes provinguin del mateix servidor. Cada URL d'imatge es codifica perquè tingui el seu nom identificatiu que sempre serà el mateix. L'script comprova si aquella imatge ja està al repositori i si és el cas la ignora; si no, la descarrega. En cas que la URL de la imatge canviï, la guardaria al repositori i al final de l'script elimina totes les imatges que no s'han fet servir.

D'altra banda tenim les imatges de las portades i capçaleres que es guarden localment al mateix vault. Aquestes imatges es copien sempre ja que poden canviar però tenir el mateix nom, i en ser un procés local no dura gaire. Totes les imatges es guarden en una carpeta de memòria cau i posteriorment es van copiant a cada carpeta de cada nota que la faci servir. Es separen en carpetes per a les portades i les capçaleres i es guarden amb un sufix per saber la procedència de l'arxiu.

Finalment tenim les imatges que estan dins de les notes. Aquestes imatges es copien directament del vault i es guarden dins de la carpeta de la nota.

D'aquesta manera, l'script genera una còpia immutable de les meves dades; les meves notes al vault principal sempre seran les que es modifiquin. Gràcies al fet que guardo les imatges com a memòria cau, l'script és molt ràpid i evito que la web deixi de funcionar correctament per factors externs.

## Actualitzador automàtic 
Ja tinc la web configurada i l'script per convertir les meves notes d'Obsidian a Hugo. Tanmateix, sorgeix un problema: no vull haver de passar les notes a l'ordinador y executar l'script manualment cada cop que vulgui actualitzar alguna cosa.

Gràcies al meu [servidor casolà](blog/six-months-with-my-first-home-server/index.es.md) i a [Syncthing](https://syncthing.net/), tinc el meu *vault* d'Obsidian sincronitzat entre tots els meus dispositius. D'aquesta manera, qualsevol canvi que faci a les meves notes des del mòbil es reflecteix automàticament al Mini PC. Amb la carpeta del Media Tracker sempre sincronitzada, només faltava automatitzar l'execució.

Per a fer-ho, he configurat una tasca al Mini PC fent servir [cron](https://wikipedia.org/wiki/Cron_\(Unix\)) que s'executa cada dia a les 9:00. Aquesta tasca llança l'script de Python sobre el repositori i, un cop finalitzat, si detecta canvis, realitza un git push. Així, cada matí, el sistema actualitza els arxius i els puja a GitHub, generant una nova versió de la web. Ja no m'haig de preocupar pel desplegament; tot el procés és completament automàtic. L'script podria estar molt millor però em funciona.

```sh
#! /bin/bash

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

LOGFILE="/home/christian/logs/cron_mediatracker_log.txt"

date=$(date +"%Y-%m-%d %T")
message="Auto-commit $(date --iso-8601=seconds)"

REPO="/home/christian/Projects/MediaTracker"

exec >> "$LOGFILE" 2>&1

echo "--- Starting backup: $date ---"

cd "$REPO" || { echo "Could not enter $REPO"; exit 1; }

source ./venv/bin/activate
python3 ./scripts/migration.py

git add ./content ./static

if ! git diff-index --quiet HEAD; then
    git commit -m "$message"
    echo "Changes committed."
else
    echo "Nothing new to commit."
fi

NEEDS_PUSH=$(git log origin/main..HEAD --oneline)

if [ -n "$NEEDS_PUSH" ]; then
    echo "Pending changes found. Attempting push..."
    
    if git push origin main; then
        echo "Push successful."
    else
        echo "ERROR: Push failed. Check SSH/Token permissions."
    fi
else
    echo "Repo is synchronized (Clean)."
fi

echo "---------------------------------"
```

## Flow Actual
El meu flow actual és:
### Pel·lícules 
Veig una pel·lícula. Si l'estic veient al meu compte de Jellyfin s'afegeix a Simkl automàticament. Si l'he vista en un altre compte de Jellyfin o fora, l'haig d'afegir jo a Simkl a mà. Quan l'acabo obro l'Obsidian al meu mòbil i afegeixo la nota, posant l'estat com a "Acabat" i la data d'aquell dia, una nota de l'1 al 7 i un comentari si em veig amb cor. Se sincronitza amb el meu servidor i l'endemà a les 9:00 es farà commit i es generarà la web. Al cap de mitja hora com a molt, el bot de Discord d'RSS rep la nova nota i publica un missatge amb l'enllaç i la caràtula.

### Sèries
Normalment les sèries les veig sempre al Jellyfin; d'aquesta manera puc saber sempre on m'he quedat i se sincronitza amb Simkl. En començar una sèrie la creo a l'Obsidian i li canvio l'estat a "En Curs"; d'aquesta manera apareixerà a la web a la secció de coses que estic veient o jugant actualment. Si la sèrie té només una temporada faig servir la nota principal; si en són vàries creo una nota per temporada i modifico les propietats de les notes de les temporades. Quan acabo una temporada canvio l'estat a "Completat" i poso la data actual. L'endemà s'enviarà un missatge per Discord amb la sèrie vista. Si és anime l'afegeixo a MyAnimeList en començar i en acabar-lo el poso com a completat i li poso una nota.

### Videojocs
Amb els videojocs és simple. En començar-lo l'afegeixo a l'Obsidian i en acabar-lo el poso com a completat i la data. Si no és la primera vegada que hi jugo faig servir l'apartat de rewatches; d'aquesta manera apareixerà a la web diverses vegades. En els videojocs acostumo a apuntar coses per no oblidar-me'n; com que no és important per a la web ho extraigo en una nota externa al meu vault personal perquè no aparegui a la web. En els videojocs acostumo a posar imatges, com captures de pantalla, que es posaran directament a la web.

## Propers passos
I amb això ja he explicat tot el que tinc; suficient. He hagut de fer una aturada d'aquest post per optimitzar la web perquè feia servir moltíssims recursos en descarregar les imatges.

Deixaré aquest projecte per un temps però tinc moltes idees per anar millorant. M'agradaria afegir gràfics per mostrar estadístiques del que veig i jugo. També m'agradaria afegir un sistema de filtres a la pantalla principal per poder filtrar per tipus i etiquetes, i així eliminar les seccions. M'agradaria afegir un motor de cerca per poder anar directament a la nota per nom. També m'agradaria afegir un calendari amb tots els elements a cada dia. Finalment, hauria de dedicar una mica de temps a optimitzar la web, afegir elements relacionats a cada nota i millorar la lògica de sèries i temporades.

Una altra cosa important a fer és separar el theme de la pàgina; d'aquesta manera qualsevol pot tenir la seva pàgina i modificar-la.

## Conclusions
No és l'eina més còmoda de configurar i fer servir, però té tot el que vull. Això no és cap tutorial, per la qual cosa hi ha molts arxius que no els he posat per no fer el post massa llarg. Si estàs interessat que publiqui un tutorial sobre com crear aquest Media Tracker, fés-m'ho saber als comentaris d'aquí sota.

La meva idea principal era dividir el theme de la pàgina web i explicar com configurar-ho tot perquè qualsevol pogués tenir la seva pàgina web de Media Tracker, però últimament he estat molt embolicat i no estic segur de si gaire gent l'aniria a fer servir. Així que de moment ho deixaré així; si algú vol fer-lo servir que faci un fork del repositori i el modifiqui al seu gust.

Espero que t'hagi agradat i ens veiem al següent post.