---
title: Seis meses con mi primer servidor casero
description: Retrospectiva tras medio año utilizando un mini PC como Home Server. Experiencias con Debian, Docker y servicios self-hosted como Jellyfin, Tailscale y Home Assistant.
date: 2025-12-11
image: cover.png
keywords: home server, self-hosting, docker, debian, linux, jellyfin, tailscale
readingTime: true
comments: true
draft: true
categories:
  - Self-hosting
tags:
  - homeserver
  - linux
  - docker
---
Hola de nuevo. Hacía ya un tiempo que no escribía un nuevo post. Me he tenido que obligar a parar y hacer el post para poder dar paso a continuar otros proyectos que tengo pendientes. Y es en parte el tema del que voy a escribir hoy. Os pongo en situación.

> Importante
> 
> Esto es un post sobre mi experiencia como novato. No soy ningún experto en la materia, ni pretendo serlo. Simplemente quiero compartir las vivencias adentrándome en el mundo de los servidores caseros. Probablemente haga muchas cosas mal y me equivoque en algunos aspectos.

## El desencadenante
Hace algo más de seis meses, mi pareja me regaló un mini PC por mi cumpleaños (grave error por su parte). En concreto es el GMKtec g3. Cuenta con un procesador N100, 16 GB de RAM y 512 GB de almacenamiento interno. Escogí este simplemente porque tenía muchos USB 3, ya que mi idea era conectarle varios discos. Era relativamente barato (~100 €) y no necesitaba mucha potencia. Los mini PC hay de muchas gamas, depende del uso que le vayas a dar te puede interesar uno u otro. El uso que le quería dar era de tareas simples, que estuviera siempre encendido y pudiera con las tareas de servidor casero simple.

Realmente no estaba muy seguro de por qué quería un servidor. Siempre había alguna cosa que quería hacer y pensaba: "si tuviera un servidor casero, lo podría hacer", pero nada era tan relevante. 

Desde entonces, he trasteado mucho con él, le he instalado varias cosas, la he liado unas cuantas veces y sobre todo he aprendido bastante por el camino, me he entretenido bastante.

## El camino
Durante todos estos meses las cosas han ido cambiando hasta donde estamos ahora, pero cambiará mucho en el futuro. Me gusta la idea de hacer retrospectiva de todo lo que ha cambiado.

### Principios
Al llegar, lo enchufé a la TV y probé que todo iba decente. Lo que más me preocupaba era un comentario de Aliexpress que decía que los HDMI no transmitían audio, cosa que me extrañó. Obviamente todo iba bien, los HDMI reproducían audio perfectamente. Para un home server no importa el audio, pero por aquel entonces tenía una TV muy antigua con un Chromecast antiguo conectado y mi idea era usar el mini PC como centro multimedia.

#### Elección del Sistema Operativo
Venía con Windows 11 preinstalado, que duró muy poco. Le tengo muy poco respeto a ese sistema operativo, aunque no tan poco como se lo tiene Microsoft. Estuve bastante tiempo debatiendo conmigo mismo sobre qué distribución de Linux poner. Como ya he dicho, mi idea era usarlo como centro multimedia, por lo que necesitaba estabilidad y poder usarlo con un entorno gráfico. Por la parte de estabilidad, estaba bastante claro, necesitaba una distro basada en Debian o Ubuntu. Al final me acabé decantando por Debian 12. No soy ningún experto en el tema, por lo que me guié por mi instinto.

Otra posible elección era Proxmox, pero sinceramente, lo vi complicado para entrar y quería algo simple, sobre todo para empezar. No descarto instalarlo en un futuro, pero quería empezar fácil.

![Imagen donde se ve un mueble de televisión blanco con tres cajones, uno de ellos abierto donde se muestra una Steam Deck en un dock, el mini pc GMKtec g3 y la Nintendo Switch. Encima del mueble hay una televisión donde se muestra en pantalla el proceso de instalación de debian 12](gmktec-with-tv.png)

Después de eso, estuve trasteando varios días sueltos. No tuve mucho tiempo porque justo me había acabado de mudar, por lo que aun habían gestiones por hacer y tuve complicaciones con el trabajo, pero fui metiéndole cosas interesantes.

Cogí un disco duro de 1 TB abandonado que había en casa de mis padres y se lo conecté. El disco duro es bastante antiguo, usa alimentación externa y hace algo de ruido. Sinceramente, para empezar, me servía. Tuve que aprender a montar discos en Linux, pero bastante fácil.

#### Descuido
En un momento la lié escribiendo un comando que no debí haber ejecutado. Principalmente lo tengo todo con Docker, por lo que lo puedo tener todo funcionando sin tener que configurar gran cosa. El problema es que a veces se me cambia el dueño de los archivos y se me pone uno de un contenedor. Normalmente con hacer `sudo chown -R christian:christian /direccion/del/disco` me soluciona el problema en mi disco externo, a no ser, que pongas sin querer el root. En vez de poner `./`, puse `/`, lo que me cambió los permisos de muchos archivos del sistema operativo. Nada grave, ya que esos archivos eran de mi "propiedad" y seguía teniendo acceso a todos mis demás archivos, pero arreglarlo era más costoso que reinstalar. Así que hice copia de seguridad (me olvidé de hacer copia de un repositorio así que perdí algo de trabajo pero nada grave) e hice una instalación limpia.

#### Reinstalación
Al instalar vi que habían sacado Debian 13, así que aproveché la ocasión y lo instalé. Estuve a punto de instalar Proxmox, pero estaba bastante ocupado, así que decidí tenerlo todo como ya lo tenía antes.

Esta nueva instalación la iba a hacer diferente. Durante los meses que estuvo el servidor funcionando, nunca tuve la necesidad de usar el escritorio ni nada de vídeo. Así que esta vez lo instalé sin entorno gráfico. Modo hacker activado, le fijé una IP e instalé directamente SSH, y así ya estaba preparado para volver a tenerlo todo funcionando.

Otra cosa que hice, fue llevarme el mini PC al despacho. El pobre estuvo pasando un verano bastante caluroso dentro de un mueble. Ahora está en una estantería más fresco.

## Servicios corriendo en mi servidor local
Vamos a lo interesante, qué tengo funcionando dentro del servidor. La verdad que en todos estos meses he ido añadiendo y quitando cosas. Vamos a ir enumerando todo.

### SSH
No sé si debería de crear una sección para esto, pero es prácticamente indispensable, ya que te permite controlar el servidor desde cualquier dispositivo. Es una consola para ejecutar comandos remotamente. En los ordenadores tengo instalado VS Code con la extensión de SSH, por lo que tengo acceso a una consola del servidor y a los archivos, muy cómodamente. También puedo ejecutar lo que quiera desde mi móvil, uso JuiceSSH y es bastante cómodo si no tengo acceso a un ordenador cerca.

### Samba
Otro servicio indispensable es el Samba. Es un programa que te permite compartir archivos entre dispositivos. Es decir, mis archivos ahora los pongo en el servidor y desde cualquier dispositivo puedo acceder a esos archivos. Es una forma de centralizar los archivos, y te evitas el problema de tener cada archivo en un dispositivo diferente.

### Portainer
Entramos en materia con Docker y servicios. [Portainer](https://www.portainer.io/) es un servicio que lista todos los contenedores Docker que tienes y puedes controlarlos. Realmente no lo uso mucho. Únicamente lo uso si necesito ver visualmente lo que hay ejecutándose y los logs si algo falla.

![Captura de pantalla de Portainer](Portainer.png)

### Tailscale
Servicio indispensable. [Tailscale](https://tailscale.com/) es una VPN. Es bastante simple de instalar y te permite acceder a tu red local desde cualquier lugar del mundo. La tengo instalada en mi móvil y he dado acceso a mi familia. Así puedo acceder a todos mis servicios, aunque no esté en casa, de una forma muy segura.

### Glances
[Glances](https://nicolargo.github.io/glances/) es un servicio que muestra el estado del servidor, el uso de CPU y memoria, días activo, procesos y contenedores funcionando. Parece que lo puedes configurar con [Grafana](https://grafana.com/) para poder verlo mejor, pero no le he dedicado tiempo a eso.

![Captura de pantalla de Glances](Glances.png)

### TDL
[TDL](https://docs.iyear.me/tdl/) es un programa hecho en Go que permite hacer varias cosas con Telegram desde una consola de comandos. Prácticamente lo uso para subir archivos en carpetas a Telegram. También se pueden descargar archivos muy rápidamente. Tengo pendiente usarlo para automatizar backups y subidas y descargas de archivos.

### Immich
[Immich](https://immich.app/) es un programa de código abierto que te permite organizar tus fotos y vídeos. Básicamente es un Google Fotos almacenando todo en tu equipo. Lo tengo configurado para que se suban las fotos y vídeos de mi móvil al servidor y tengo acceso desde cualquier dispositivo. Tiene un sistema de usuarios que permite crear varias cuentas, crear álbumes y compartirlos entre usuarios. También tiene un sistema de reconocimiento de caras y gestión de ubicación. Todo en local.

Lo puse en su momento y desde entonces he ido subiendo las fotos que iba haciendo cada día. Me falta conseguir todas las fotos que tengo desperdigadas por los discos duros y unificarlo todo.

### mnamer
[mnamer](https://github.com/jkwill87/mnamer) es un programa de consola que intenta adivinar la película o serie del contenido de un archivo por el nombre, y lo renombra y mueve según lo configures. Falla más que una escopeta de feria, pero agiliza mucho el renombrado de archivos, sobre todo de series largas. Las películas las busca en [The Movie Database](https://www.themoviedb.org) y las series en [TheTVDB](https://www.thetvdb.com/), por lo que las fuentes de datos son diferentes. Lo tengo en un contenedor Docker y lo ejecuto directamente en la consola de comandos. Tengo varios alias para hacer un test y proveer directamente el id de TMDB o TVDB.

### mnamer-telegram
Tener mnamer para poder ejecutarlo en consola está muy bien, pero es algo molesto usar la consola de comandos. Así que creé un bot de Telegram simple que detecta los nuevos archivos en una carpeta, hace una prueba con mnamer y envía el resultado como mensaje por Telegram. El mensaje tiene un botón que ejecuta la acción de mover y renombrar el archivo.

Sorprendentemente mnamer funciona mejor dentro del bot que en el contenedor Docker. Lo tengo a medias, aun le faltan funcionalidades clave y arreglar algunos errores. Si mnamer lo encuentra a la primera es perfecto porque con un clic se mueve directamente y siempre siguiendo el mismo formato de nombre, pero si no lo encuentra o hay muchos archivos, toca hacerlo por comando directamente. Cuando esté decente lo haré de código abierto.

![Captura de pantalla de Telegram donde se muestra el bot en funcionamiento](mnaner-telegram-bot.jpg)

### Home Assistant
[Home Assistant](https://www.home-assistant.io/) es uno de los proyectos más famosos de domótica. Prácticamente es un programa que actúa como el cerebro de tu domótica. Todos los dispositivos los puedes conectar a Home Assistant y gestionarlos desde un único sitio unificado. Puedes crear automatizaciones con diferentes sensores y acciones.

Sinceramente no lo he usado mucho. No tengo muchos dispositivos domóticos y no me he puesto a indagar sobre automatizaciones que necesite.

![Captura de la interfaz de Home Assistant](HomeAssistant.png)

### Syncthing
[Syncthing](https://syncthing.net/) te permite sincronizar archivos entre varios dispositivos. Este es uno de los últimos servicios que he añadido al servidor. Básicamente tienes que instalar Syncthing en cada uno de los dispositivos que quieras y seleccionas una carpeta para compartir. Cada cambio que hagas, se sincronizará con los demás dispositivos. Como el servidor siempre está activo, los cambios siempre se sincronizarán independientemente de quien los modifique.

Lo estoy usando para sincronizar mis notas de [Obsidian](https://obsidian.md/), que lo he empezado a usar de forma seria desde hace poco, es mi nueva obsesión. Tengo dos carpetas sincronizadas, toda mi bóveda personal de Obsidian y los posts de mi blog. De esta forma puedo acceder a mis archivos y editarlos desde cualquier dispositivo. Puedo añadir y modificar notas de Obsidian o escribir este post desde el móvil, continuar desde el ordenador de torre y acabarlo de escribir en el portátil. Tengo pendiente escribir un post de cómo lo tengo montado.

![Captura de la interfaz de Syncthing](Syncthing.png)

### telegram-downloader
Estoy usando un bot de Telegram que, al enviarle archivos, los descarga en el mini PC. También descarga vídeos de YouTube, pero prefiero usar [yt-dlp](https://github.com/yt-dlp/yt-dlp) por consola.

Es un poco confuso porque estuve usando la imagen [jsavargas/telethon_downloader](https://hub.docker.com/r/jsavargas/telethon_downloader) que es de código libre y se puede encontrar en [este repositorio](https://github.com/jsavargas/telethon_downloader), al cabo de un tiempo la cambié por esta otra imagen [jsavargas/telegram-downloader](https://hub.docker.com/r/jsavargas/telegram-downloader) que es de la misma persona pero no parece estar el código públicamente accesible. Ya veré qué hago porque he visto que ha actualizado la imagen en GitHub, así que lo mismo vuelvo a esa, igualmente, de momento me funciona.

### Jellyfin
La joya de la corona. [Jellyfin](https://jellyfin.org/) es un servicio de código libre que convierte tu ordenador en un centro multimedia. Es capaz de leer tus archivos, descargar metadatos y transmitirlo a cualquier dispositivo de tu red. Es básicamente como un Netflix con tus archivos locales. Tienes que poseer todos los archivos. Con un sistema de usuarios, sin anuncios, sin tarifas abusivas y disponible desde todos tus dispositivos. Puedes ver un episodio en el móvil y luego cuando estés en la televisión te saldrá el siguiente para ver.

Se le pueden instalar plugins que hace la comunidad. Por ejemplo, tengo instalado el plugin de [Simkl](https://simkl.com) y al acabar un episodio o película, me lo pone como visto en mi cuenta automáticamente.

Se podría decir que es el servicio que más he usado. También se lo he instalado en la televisión de mi madre junto a Tailscale.

Es la contraparte open source a Plex. No he llegado a usar Plex, pero Jellyfin me sirve. El gran inconveniente es que no está en todas las tiendas de las televisiones. Lo de los sistemas operativos de las televisiones es un tema aparte. Cuando compré la televisión busqué únicamente las que tenían Google TV que son las más abiertas. Otra solución era comprar un Xiaomi TV Box, pero encarecía la compra. A mi madre le tuve que poner el Jellyfin y el Tailscale en un Fire TV.

![Captura de pantalla de la interfaz de Jellyfin](Jellyfin.png)

### Jellyseerr
Jellyseerr (ahora creo que se llama "Serr") es un servicio de peticiones de contenido. Lo puedes conectar a tu instancia de Jellyfin para que te aparezca el contenido que ya hay. Puedes crear usuarios o usar los de Jellyfin y cada usuario puede hacer peticiones de cualquier película o serie y me llega un mensaje a un bot de Telegram con la petición.

Es el único servicio que tengo abierto a internet mediante túneles de Cloudflare.

![Captura de Jellyseerr](Jellyseerr.png)

### MLDonkey
Sinceramente no me imaginaba que siguiera vivo, pero [eMule](https://www.emule-project.com) sigue dándolo todo en 2025. Este cliente P2P, aunque es bastante antiguo, sigue funcionando de una manera más que decente. Al ser tan antiguo, no se ha ido actualizando tanto como sí lo han hecho los clientes torrent. 

Funciona bastante bien en Windows, pero yo necesitaba una solución para ejecutarlo en Linux, y si podía ser con Docker, mejor que mejor. En Linux existe aMule, que es la versión multiplataforma de eMule, aunque su rendimiento es algo inferior. Existen algunas imágenes Docker populares como [ngosang/docker-amule](https://github.com/ngosang/docker-amule), pero al pasarla por la VPN con [gluetun](https://gluetun.com/), no me iba nada bien. Estuve investigando y encontré MLDonkey que es otro cliente P2P algo más completo. Puse a funcionar la imagen de [wibol/mldonkey-docker](https://github.com/Wibol/mldonkey-docker) y funcionaba decentemente, mucho mejor que aMule. Al cabo de un tiempo probé la imagen de [carlonluca](https://hub.docker.com/r/carlonluca/mldonkey), que parece que se actualiza más constantemente y tiene una nueva interfaz. No me fue bien porque no conseguía hacerla funcionar mediante la VPN. Eso añadido a que la nueva interfaz es menos usable, me quedé con la versión de Wibol.

### Media Stack
Configuré un gran Docker Compose con el típico media stack. Puse el [qBittorrent](https://www.qbittorrent.org/) como cliente torrent, [Prowlarr](https://prowlarr.com/) y [Jackett](https://github.com/Jackett/Jackett), como indexadores, [Sonarr](https://sonarr.tv/) y [Radarr](https://radarr.video/).

Sinceramente no lo tengo activo de normal ya que no lo suelo usar mucho. He probado torrent y no me da muy buenos resultados. Para consumir contenido en versión original creo que va mejor.

### JDownloader
Por último, puse una imagen Docker de [JDownloader](https://jdownloader.org) ya que alguna vez he necesitado descargar varios archivos por descarga directa. Igualmente lo suelo tener apagado porque está puesto con una interfaz gráfica que consume bastante. Quiero probar a instalarlo sin interfaz gráfica, a ver qué tal funciona.

## Servicios que tuve
Y hasta aquí todos los servicios que tengo por mi servidor. Aunque también me gustaría nombrar algunos servicios que he tenido en algún momento.

### Panabot (Hollow Knight)
Hice un pequeño bot de Discord que cada día enviaba un mensaje con la cuenta atrás de la salida de Hollow Knight Silksong.

![Captura de los mensajes del Panabot](Panabot.png)

### Calibre Web
No soy un gran lector, pero mi pareja sí, así que quise darle otro uso al servidor. Mi pareja tiene una gran colección de libros, tanto físicos como digitales, y posee un Kobo Libra 2. Ella organiza su biblioteca digital con Calibre y tiene una versión web. Conseguí sincronizarlo con el Kobo, pero a la hora de pasar y convertir los libros, no se veían bien en el dispositivo y acabé desistiendo antes de liarla.

### Dash
Antes de usar Glances, usaba [Dash](https://getdashdot.com/), un servicio de monitoreo del dispositivo. Como es algo más sencillo que Glances, lo acabé quitando.

### Homarr
Tener muchos servicios corriendo en tu servidor puede hacer difícil recordar todos los puertos de cada uno, [Homarr](https://homarr.dev/) te permite crear una pantalla principal con tus servicios y plugins para mostrar información de los servicios. El problema principal es que estaba usando casi 1 GB de RAM, por lo que lo he quitado y probaré alguna alternativa.

### AdGuard
Uno de los servicios que más ganas tenía de poner en mi servidor era [AdGuard](https://adguard.com), un bloqueador DNS. No lo debí configurar muy bien porque provocaba que algunas aplicaciones no funcionaran bien, así que lo quité hasta que tuviera tiempo para dedicarle. También estaba pensando en usar [Pi-hole](https://pi-hole.net/), que lo usé en un trabajo que tuve y funcionaba decente.

## Futuro
La verdad que haciendo repaso de todo, han pasado muchas cosas. La verdad que estoy contento con el estado actual y me gustaría no dedicarle tanto tiempo como le he dedicado todo este tiempo y seguir con otros proyectos.

Tener un servidor local en casa es una experiencia que me está gustando mucho. Tener la posibilidad de tener almacenamiento disponible desde cualquier dispositivo es muy cómodo. El hecho de poder ejecutar servicios creados por la comunidad y pequeños programas que creo para mejorar mi vida digital es algo que me gusta. Poder hacer mis propios bots y que estén siempre disponibles es algo que está también bien.

Para que esté perfecto aún me queda hacer algún sistema automático de copias de seguridad. Mi idea inicial era tener un NAS pero de momento me salva, que los discos duros siguen bastante caros. También me gustaría seguir desarrollando los bots que tengo a medias.

Es un buen resumen del tema del servidor local, espero de aquí un tiempo tener más actualizaciones sobre este tema. Tengo más cosas entre manos que me gustaría avanzar y hablar de ellas en el blog.

Lo dejo por aquí, que creo que ha quedado bastante largo, y nos vemos en el próximo post.