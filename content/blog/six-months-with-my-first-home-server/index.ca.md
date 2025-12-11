---
title: Sis mesos amb el meu primer servidor casolà
description: Retrospectiva després de mig any utilitzant un mini PC com a Home Server. Experiències amb Debian, Docker i serveis self-hosted com Jellyfin, Tailscale i Home Assistant.
date: 2025-12-11
image: cover.png
keywords: home server, self-hosting, docker, debian, linux, jellyfin, tailscale
readingTime: true
comments: true
draft: false
categories:
  - Self-hosting
tags:
  - homeserver
  - linux
  - docker
---
Hola de nou. Feia ja un temps que no escrivia un nou post. M'he hagut d'obligar a parar i fer el post per poder donar pas a continuar altres projectes que tinc pendents. I és en part el tema del qual escriuré avui. Us poso en situació.

> Important
> 
> Això és un post sobre la meva experiència com a novell. No soc cap expert en la matèria, ni pretenc ser-ho. Simplement vull compartir les vivències endinsant-me en el món dels servidors casolans. Probablement faci moltes coses malament i m'equivoqui en alguns aspectes.

## El desencadenant
Fa una mica més de sis mesos, la meva parella em va regalar un mini PC pel meu aniversari (greu error per part seva). En concret és el GMKtec g3. Compta amb un processador N100, 16 GB de RAM i 512 GB d'emmagatzematge intern. Vaig escollir aquest simplement perquè tenia molts USB 3, ja que la meva idea era connectar-li diversos discos. Era relativament barat (~100 €) i no necessitava molta potència. De mini PC n'hi ha de moltes gammes, depèn de l'ús que li hagis de donar te'n pot interessar un o un altre. L'ús que li volia donar era de tasques simples, que estigués sempre encès i pogués amb les tasques de servidor casolà simple.

Realment no estava gaire segur de per què volia un servidor. Sempre hi havia alguna cosa que volia fer i pensava: "si tingués un servidor a casa, ho podria fer", però res era tan rellevant.

Des d'aleshores, he trastejat molt amb ell, li he instal·lat diverses coses, l'he espifiat unes quantes vegades i sobretot he après bastant pel camí, m'he entretingut bastant.

## El camí
Durant tots aquests mesos les coses han anat canviant fins on estem ara, però canviarà molt en el futur. M'agrada la idea de fer retrospectiva de tot el que ha canviat.

### Principis
En arribar, el vaig endollar a la TV i vaig provar que tot anés decent. El que més em preocupava era un comentari d'Aliexpress que deia que els HDMI no transmetien àudio, cosa que em va estranyar. Òbviament tot anava bé, els HDMI reproduïen àudio perfectament. Per a un home server no importa l'àudio, però per aquell temps tenia una TV molt antiga amb un Chromecast antic connectat i la meva idea era fer servir el mini PC com a centre multimèdia.

#### Elecció del Sistema Operatiu
Venia amb Windows 11 preinstal·lat, que va durar molt poc. Li tinc molt poc respecte a aquest sistema operatiu, encara que no tan poc com li té Microsoft. Vaig estar bastant temps debatent amb mi mateix sobre quina distribució de Linux posar. Com ja he dit, la meva idea era utilitzar-lo com a centre multimèdia, per la qual cosa necessitava estabilitat i poder utilitzar-lo amb un entorn gràfic. Per la part d'estabilitat, estava bastant clar, necessitava una distro basada en Debian o Ubuntu. Al final em vaig acabar decantant per Debian 12. No soc cap expert en el tema, així que em vaig guiar pel meu instint.

Una altra possible elecció era Proxmox, però sincerament, ho vaig veure complicat per entrar-hi i volia alguna cosa simple, sobretot per començar. No descarto instal·lar-lo en un futur, però volia començar fàcil.

![Imatge on es veu un moble de televisió blanc amb tres calaixos, un d'ells obert on es mostra una Steam Deck en un dock, el mini pc GMKtec g3 i la Nintendo Switch. A sobre del moble hi ha una televisió on es mostra en pantalla el procés d'instal·lació de debian 12](gmktec-with-tv.png)

Després d'això, vaig estar trastejant diversos dies solts. No vaig tenir gaire temps perquè just m'havia acabat de mudar, per la qual cosa encara hi havia gestions per fer i vaig tenir complicacions amb la feina, però vaig anar ficant-li coses interessants.

Vaig agafar un disc dur d'1 TB abandonat que hi havia a casa dels meus pares i l'hi vaig connectar. El disc dur és bastant antic, utilitza alimentació externa i fa una mica de soroll. Sincerament, per començar, em servia. Vaig haver d'aprendre a muntar discos a Linux, però bastant fàcil.

#### Distracció
En un moment la vaig liar escrivint una comanda que no hauria d'haver executat. Principalment ho tinc tot amb Docker, per la qual cosa ho puc tenir tot funcionant sense haver de configurar gran cosa. El problema és que a vegades se'm canvia el propietari dels fitxers i se'm posa un d'un contenidor. Normalment amb fer `sudo chown -R christian:christian /adreca/del/disc` em soluciona el problema al meu disc extern, llevat que posis sense voler el root. En comptes de posar `./`, vaig posar `/`, fet que em va canviar els permisos de molts fitxers del sistema operatiu. Res greu, ja que aquests fitxers eren de la meva "propietat" i continuava tenint accés a tots els meus altres fitxers, però arreglar-ho era més costós que reinstal·lar. Així que vaig fer còpia de seguretat (em vaig oblidar de fer còpia d'un repositori així que vaig perdre una mica de feina però res greu) i vaig fer una instal·lació neta.

#### Reinstal·lació
En instal·lar vaig veure que havien tret Debian 13, així que vaig aprofitar l'ocasió i el vaig instal·lar. Vaig estar a punt d'instal·lar Proxmox, però estava bastant ocupat, així que vaig decidir tenir-ho tot com ja ho tenia abans.

Aquesta nova instal·lació l'anava a fer diferent. Durant els mesos que va estar el servidor funcionant, mai vaig tenir la necessitat de fer servir l'escriptori ni res de vídeo. Així que aquesta vegada el vaig instal·lar sense entorn gràfic. "Mode hacker" activat, li vaig fixar una IP i vaig instal·lar directament SSH, i així ja estava preparat per tornar a tenir-ho tot funcionant.

Una altra cosa que vaig fer, va ser emportar-me el mini PC al despatx. El pobre va estar passant un estiu bastant calorós dins d'un moble. Ara està en una prestatgeria més fresc.

## Serveis corrent al meu servidor local
Anem al que és interessant, què tinc funcionant dins del servidor. La veritat que en tots aquests mesos he anat afegint i traient coses. Anem a anar enumerant tot.

### SSH
No sé si hauria de crear una secció per a això, però és pràcticament indispensable, ja que et permet controlar el servidor des de qualsevol dispositiu. És una consola per executar comandes remotament. Als ordinadors tinc instal·lat VS Code amb l'extensió de SSH, per la qual cosa tinc accés a una consola del servidor i als fitxers, molt còmodament. També puc executar el que vulgui des del meu mòbil, faig servir JuiceSSH i és bastant còmode si no tinc accés a un ordinador a prop.

### Samba
Un altre servei indispensable és el Samba. És un programa que et permet compartir fitxers entre dispositius. És a dir, els meus fitxers ara els poso al servidor i des de qualsevol dispositiu puc accedir a aquests fitxers. És una manera de centralitzar els fitxers, i t'evites el problema de tenir cada fitxer en un dispositiu diferent.

### Portainer
Entrem en matèria amb Docker i serveis. [Portainer](https://www.portainer.io/) és un servei que llista tots els contenidors Docker que tens i pots controlar-los. Realment no el faig servir gaire. Únicament el faig servir si necessito veure visualment el que hi ha executant-se i els logs si alguna cosa falla.

![Captura de pantalla de Portainer](Portainer.png)

### Tailscale
Servei indispensable. [Tailscale](https://tailscale.com/) és una VPN. És bastant simple d'instal·lar i et permet accedir a la teva xarxa local des de qualsevol lloc del món. La tinc instal·lada al meu mòbil i he donat accés a la meva família. Així puc accedir a tots els meus serveis, encara que no sigui a casa, d'una manera molt segura.

### Glances
[Glances](https://nicolargo.github.io/glances/) és un servei que mostra l'estat del servidor, l'ús de CPU i memòria, dies actiu, processos i contenidors funcionant. Sembla que el pots configurar amb [Grafana](https://grafana.com/) per poder veure-ho millor, però no li he dedicat temps a això.

![Captura de pantalla de Glances](Glances.png)

### TDL
[TDL](https://docs.iyear.me/tdl/) és un programa fet en Go que permet fer diverses coses amb Telegram des d'una consola de comandes. Pràcticament el faig servir per pujar fitxers en carpetes a Telegram. També es poden descarregar fitxers molt ràpidament. Tinc pendent utilitzar-lo per automatitzar còpies de seguretat i pujades i baixades de fitxers.

### Immich
[Immich](https://immich.app/) és un programa de codi obert que et permet organitzar les teves fotos i vídeos. Bàsicament és un Google Fotos emmagatzemant tot al teu equip. Ho tinc configurat perquè es pugin les fotos i vídeos del meu mòbil al servidor i tinc accés des de qualsevol dispositiu. Té un sistema d'usuaris que permet crear diversos comptes, crear àlbums i compartir-los entre usuaris. També té un sistema de reconeixement de cares i gestió d'ubicació. Tot en local.

El vaig posar en el seu moment i des de llavors he anat pujant les fotos que anava fent cada dia. Em falta aconseguir totes les fotos que tinc escampades pels discos durs i unificar-ho tot.

### mnamer
[mnamer](https://github.com/jkwill87/mnamer) és un programa de consola que intenta endevinar la pel·lícula o sèrie del contingut d'un fitxer pel nom, i el reanomena i mou segons el configuris. Falla més que una escopeta de fira, però agilitza molt el reanomenament de fitxers, sobretot de sèries llargues. Les pel·lícules les busca a [The Movie Database](https://www.themoviedb.org) i les sèries a [TheTVDB](https://www.thetvdb.com/), per la qual cosa les fonts de dades són diferents. El tinc en un contenidor Docker i l'executo directament a la consola de comandes. Tinc diversos àlies per fer un test i proveir directament la id de tmdb o tvdb.

### mnamer-telegram
Tenir mnamer per poder executar-lo en consola està molt bé, però és una mica molest fer servir la consola de comandes. Així que vaig crear un bot de Telegram simple que detecta els nous fitxers en una carpeta, fa una prova amb mnamer i envia el resultat com a missatge per Telegram. El missatge té un botó que executa l'acció de moure i reanomenar el fitxer.

Sorprenentment mnamer funciona millor dins del bot que al contenidor Docker. Ho tinc a mitges, encara li falten funcionalitats clau i arreglar alguns errors. Si mnamer ho troba a la primera és perfecte perquè amb un clic es mou directament i sempre seguint el mateix format de nom, però si no ho troba o hi ha molts fitxers, toca fer-ho per comanda directament. Quan estigui decent el faré de codi obert.

![Captura de pantalla de Telegram on es mostra el bot en funcionament](mnaner-telegram-bot.jpg)

### Home Assistant
[Home Assistant](https://www.home-assistant.io/) és un dels projectes més famosos de domòtica. Pràcticament és un programa que actua com el cervell de la teva domòtica. Tots els dispositius els pots connectar a Home Assistant i gestionar-los des d'un únic lloc unificat. Pots crear automatitzacions amb diferents sensors i accions.

Sincerament no l'he fet servir gaire. No tinc molts dispositius domòtics i no m'he posat a indagar sobre automatitzacions que necessiti.

![Captura de la interfície de Home Assistant](HomeAssistant.png)

### Syncthing
[Syncthing](https://syncthing.net/) et permet sincronitzar fitxers entre diversos dispositius. Aquest és un dels últims serveis que he afegit al servidor. Bàsicament has d'instal·lar Syncthing a cadascun dels dispositius que vulguis i selecciones una carpeta per compartir. Cada canvi que facis, se sincronitzarà amb els altres dispositius. Com que el servidor sempre està actiu, els canvis sempre se sincronitzaran independentment de qui els modifiqui.

L'estic fent servir per sincronitzar les meves notes d'[Obsidian](https://obsidian.md/), que l'he començat a fer servir de manera seriosa des de fa poc, és la meva nova obsessió. Tinc dues carpetes sincronitzades, tota la meva volta personal d'Obsidian i els posts del meu blog. D'aquesta manera puc accedir als meus fitxers i editar-los des de qualsevol dispositiu. Puc afegir i modificar notes d'Obsidian o escriure aquest post des del mòbil, continuar des de l'ordinador de torre i acabar-lo d'escriure al portàtil. Tinc pendent escriure un post de com ho tinc muntat.

![Captura de la interfície de Syncthing](Syncthing.png)

### telegram-downloader
Estic fent servir un bot de Telegram que, en enviar-li fitxers, els descarrega al mini PC. També descarrega vídeos de YouTube, però prefereixo utilitzar [yt-dlp](https://github.com/yt-dlp/yt-dlp) per consola.

És una mica confús perquè vaig estar fent servir la imatge [jsavargas/telethon_downloader](https://hub.docker.com/r/jsavargas/telethon_downloader) que és de codi lliure i es pot trobar en [aquest repositori](https://github.com/jsavargas/telethon_downloader), al cap d'un temps la vaig canviar per aquesta altra imatge [jsavargas/telegram-downloader](https://hub.docker.com/r/jsavargas/telegram-downloader) que és de la mateixa persona però no sembla estar el codi públicament accessible. Ja veuré què faig perquè he vist que ha actualitzat la imatge a GitHub, així que igual torno a aquesta, igualment, de moment em funciona.

### Jellyfin
La joia de la corona. [Jellyfin](https://jellyfin.org/) és un servei de codi lliure que converteix el teu ordinador en un centre multimèdia. És capaç de llegir els teus fitxers, descarregar metadades i transmetre-ho a qualsevol dispositiu de la teva xarxa. És bàsicament com un Netflix amb els teus fitxers locals. Has de posseir tots els fitxers. Amb un sistema d'usuaris, sense anuncis, sense tarifes abusives i disponible des de tots els teus dispositius. Pots veure un episodi al mòbil i després quan siguis a la televisió et sortirà el següent per veure.

Se li poden instal·lar plugins que fa la comunitat. Per exemple, tinc instal·lat el plugin de [Simkl](https://simkl.com) i en acabar un episodi o pel·lícula, m'ho posa com a vist al meu compte automàticament.

Es podria dir que és el servei que més he fet servir. També l'hi he instal·lat a la televisió de la meva mare juntament amb Tailscale.

És la contrapart open source a Plex. No he arribat a fer servir Plex, però Jellyfin em serveix. El gran inconvenient és que no està a totes les botigues de les televisions. Això dels sistemes operatius de les televisions és un tema a part. Quan vaig comprar la televisió vaig buscar únicament les que tenien Google TV que són les més obertes. Una altra solució era comprar un Xiaomi TV Box, però encaria la compra. A la meva mare li vaig haver de posar el Jellyfin i el Tailscale en un Fire TV.

![Captura de pantalla de la interfície de Jellyfin](Jellyfin.png)

### Jellyseerr
Jellyseerr (ara crec que es diu "Serr") és un servei de peticions de contingut. El pots connectar a la teva instància de Jellyfin perquè t'aparegui el contingut que ja hi ha. Pots crear usuaris o utilitzar els de Jellyfin i cada usuari pot fer peticions de qualsevol pel·lícula o sèrie i m'arriba un missatge a un bot de Telegram amb la petició.

És l'únic servei que tinc obert a internet mitjançant túnels de Cloudflare.

![Captura de Jellyseerr](Jellyseerr.png)

### MLDonkey
Sincerament no m'imaginava que seguís viu, però [eMule](https://www.emule-project.com) segueix donant-ho tot el 2025. Aquest client P2P, tot i que és bastant antic, segueix funcionant d'una manera més que decent. En ser tan antic, no s'ha anat actualitzant tant com sí que ho han fet els clients torrent.

Funciona bastant bé a Windows, però jo necessitava una solució per executar-lo a Linux, i si podia ser amb Docker, millor que millor. A Linux existeix aMule, que és la versió multi-plataforma d'eMule, encara que el seu rendiment és una mica inferior. Existeixen algunes imatges Docker populars com [ngosang/docker-amule](https://github.com/ngosang/docker-amule), però en passar-la per la VPN amb [gluetun](https://gluetun.com/), no m'anava gens bé. Vaig estar investigant i vaig trobar MLDonkey que és un altre client P2P una mica més complet. Vaig posar a funcionar la imatge de [wibol/mldonkey-docker](https://github.com/Wibol/mldonkey-docker) i funcionava decentment, molt millor que aMule. Al cap d'un temps vaig provar la imatge de [carlonluca](https://hub.docker.com/r/carlonluca/mldonkey), que sembla que s'actualitza més constantment i té una nova interfície. No em va anar bé perquè no aconseguia fer-la funcionar mitjançant la VPN. Això afegit al fet que la nova interfície és menys usable, em vaig quedar amb la versió de Wibol.

### Media Stack
Vaig configurar un gran Docker Compose amb el típic media stack. Vaig posar el [qBittorrent](https://www.qbittorrent.org/) com a client torrent, [Prowlarr](https://prowlarr.com/) i [Jackett](https://github.com/Jackett/Jackett), com a indexadors, [Sonarr](https://sonarr.tv/) i [Radarr](https://radarr.video/).

Sincerament no ho tinc actiu de normal ja que no ho solo utilitzar gaire. He provat torrent i no em dona gaire bons resultats. Per consumir contingut en versió original crec que va millor.

### JDownloader
Per últim, vaig posar una imatge Docker de [JDownloader](https://jdownloader.org) ja que alguna vegada he necessitat descarregar diversos fitxers per descàrrega directa. Igualment ho solo tenir apagat perquè està posat amb una interfície gràfica que consumeix bastant. Vull provar a instal·lar-lo sense interfície gràfica, a veure què tal funciona.

## Serveis que vaig tenir
I fins aquí tots els serveis que tinc pel meu servidor. Encara que també m'agradaria anomenar alguns serveis que he tingut en algun moment.

### Panabot (Hollow Knight)
Vaig fer un petit bot de Discord que cada dia enviava un missatge amb el compte enrere de la sortida de Hollow Knight Silksong.

![Captura dels missatges del Panabot](Panabot.png)

### Calibre Web
No soc un gran lector, però la meva parella sí, així que vaig voler donar-li un altre ús al servidor. La meva parella té una gran col·lecció de llibres, tant físics com digitals, i posseeix un Kobo Libra 2. Ella organitza la seva biblioteca digital amb Calibre i té una versió web. Vaig aconseguir sincronitzar-ho amb el Kobo, però a l'hora de passar i convertir els llibres, no es veien bé al dispositiu i vaig acabar desistint abans de liar-la.

### Dash
Abans de fer servir Glances, feia servir [Dash](https://getdashdot.com/), un servei de monitoratge del dispositiu. Com que és una mica més senzill que Glances, el vaig acabar traient.

### Homarr
Tenir molts serveis corrent al teu servidor pot fer difícil recordar tots els ports de cadascun, [Homarr](https://homarr.dev/) et permet crear una pantalla principal amb els teus serveis i plugins per mostrar informació dels serveis. El problema principal és que estava utilitzant gairebé 1 GB de RAM, per la qual cosa l'he tret i provaré alguna alternativa.

### AdGuard
Un dels serveis que més ganes tenia de posar al meu servidor era [AdGuard](https://adguard.com), un bloquejador DNS. No l'hauria d'haver configurat gaire bé perquè provocava que algunes aplicacions no funcionessin bé, així que el vaig treure fins que tingués temps per dedicar-li. També estava pensant a utilitzar [Pi-hole](https://pi-hole.net/), que el vaig fer servir en una feina que vaig tenir i funcionava decent.

## Futur
La veritat que fent repàs de tot, han passat moltes coses. La veritat que estic content amb l'estat actual i m'agradaria no dedicar-li tant de temps com li he dedicat tot aquest temps i seguir amb altres projectes.

Tenir un servidor local a casa és una experiència que m'està agradant molt. Tenir la possibilitat de tenir emmagatzematge disponible des de qualsevol dispositiu és molt còmode. El fet de poder executar serveis creats per la comunitat i petits programes que creo per millorar la meva vida digital és una cosa que m'agrada. Poder fer els meus propis bots i que estiguin sempre disponibles és una cosa que està també bé.

Perquè estigui perfecte encara em queda fer algun sistema automàtic de còpies de seguretat. La meva idea inicial era tenir un NAS però de moment em salva, que els discos durs segueixen bastant cars. També m'agradaria seguir desenvolupant els bots que tinc a mitges.

És un bon resum del tema del servidor local, espero d'aquí un temps tenir més actualitzacions sobre aquest tema. Tinc més coses entre mans que m'agradaria avançar i parlar-ne al blog.

Ho deixo per aquí, que crec que ha quedat bastant llarg, i ens veiem en el pròxim post.