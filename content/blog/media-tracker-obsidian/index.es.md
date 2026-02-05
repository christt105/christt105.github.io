---
title: "En busca del registro multimedia definitivo: Obsidian"
description: Descripción pendiente...
date: 2026-01-23
image: cover.png
keywords:
readingTime: true
comments: true
draft: true
categories:
  - Media Tracker
tags:
  - Obsidian
  - Tracking
---
Bienvenidos a la segunda parte de la serie de "En busca del registro multimedia definitivo". En este post os mostraré la herramienta principal de mi nuevo media tracker.

[En el anterior post](../media-tracker-origins) expliqué todas las herramientas previas a esta. Este post probablemente va a ser el más extenso de los tres. Mi objetivo es explicar todo lo que tengo configurado, con todos los scripts y configuraciones por si alguien quiere replicar lo que he hecho. Mi nueva solución usa dos herramientas, pero esta es el corazón de mi media tracker. Vamos allá.

## La nueva solución

Para mi nuevo Media Tracker quería tener varios puntos presentes:
- Todos mis datos deben pertenecerme.
- Poder migrar los datos a otra aplicación si hiciera falta.
- Accesible desde cualquier dispositivo. Ser capaz de añadir, eliminar y editar cualquier dato, principalmente desde mi móvil, pero que también sea accesible desde el ordenador.
- Poder añadir comentarios, imágenes y vídeos a cada elemento.
- Tener una página web que sea fácilmente accesible desde cualquier dispositivo y completamente adaptable a mis necesidades.
- Poder añadir películas, series y juegos en la misma base de datos y que sea cómodo de hacerlo.

Después de investigar, decidí decantarme por la idea de usar [Obsidian](https://obsidian.md/) para la creación y edición de cada elemento del tracker. Por la naturaleza de Obsidian con Markdown, y con la experiencia de haber hecho mi página web y blog con [Hugo](https://gohugo.io/), decidí usarlo para generar la página web de mi media tracker. Aunque de eso hablaremos en el siguiente post.

## Obsidian
Para los que sabéis cómo funciona [Notion](https://www.notion.com/), habréis arqueado la ceja en el [post anterior](../media-tracker-origins) al decir que con Notion mis datos me pertenecían y no es cierto, en Notion los datos no son tuyos, te pueden revocar acceso a ellos cuando ellos consideren porque son de su propiedad, así que tocaba mover ficha.

De una fiebre a otra, llegó a mi vida [Obsidian](https://obsidian.md/). Esta herramienta es una aplicación para tomar notas en formato Markdown. Te permite crear relaciones entre tus notas para crear un grafo con todas tus notas y relaciones. Es muy parecido a la estructura de la [Wikipedia](https://www.wikipedia.org/), donde puedes ir recorriendo distintas páginas a través de los enlaces relacionales.

Gracias a mi nueva adquisición, un mini pc, podía sincronizar mis notas de manera muy eficaz con [Syncthing](https://syncthing.net/), como ya expliqué en mi otro post [Seis meses con mi primer servidor casero](https://christt105.github.io/es/blog/six-months-with-my-first-home-server/), que era el punto que me echaba más hacia atrás de Obsidian. Ahora voy a explicar cómo tengo configurado Obsidian para el Media Tracker, puede que en un futuro haga un post explicando como tengo configurado todo mi Obsidian, ya que me parece una muy buena herramienta para integrar en tu día a día.

### Plantilla
No tenía pensado hacerlo pero al final he creado una plantilla con todos los archivos necesarios para que funcione tal cuál lo tengo configurado yo. Configurarlo en un vault ya existente puede ser algo tedioso, debería de haber sido un plugin, pero lo he ido haciendo sobre la marcha y no creo que mucha gente lo vaya a usar, ya que está todo hecho para cubrir mis necesidades específicas. Puedes descargar el vault, abrirlo con Obsidian y comprobar como está todo configurado.

https://github.com/christt105/media-tracker-obsidian-template

En el caso de que tuviera mucho apoyo, podría considerar hacer un plugin específico para Obsidian.

### Organización
Decidí tener el Media Tracker dentro de mi _vault_ principal de Obsidian. El Media Tracker vive únicamente en una carpeta, así evito que se mezcle con las otras notas y son más fáciles de diferenciar. Dentro de `Juegos/`, `Movies/`, `TVs/` y `Seasons/` viven individualmente cada instancia de juegos, películas, series y temporadas respectivamente, cada elemento tiene una nota. También tengo la carpeta `Portadas/` donde pongo las imágenes de las portadas y banners de elementos que no tienen en la web, sobre todo de fangames.

![Carpetas de mi Media Tracker dentro de Obsidian](MediaTrackerFolders.png)

En `Media Tracker/` está el archivo `Media Tracker Views.base` que es un archivo tipo base con varias vistas. Las bases es un añadido muy reciente, justo lo acababan de poner cuando empecé a usar Obsidian. Es un archivo que te permite poder visualizar tus notas de varias formas, parecido a las vistas de Notion. Tiene una API por lo que la comunidad ya está empezando a usarlas para cosas más complejas. De momento únicamente he creado vistas muy básicas, casi no las uso, ya que tengo la web.

![Media Tracker Base View All](MediaTrackerBaseAll.png) 
![Media Tracker Base View Anime](MediaTrackerBaseAnime.png)
![Media Tracker Base View Table](MediaTrackerBaseTable.png)

### Series y Temporadas
Con las series tenía un problema. No sabía que hacer con las series con múltiples temporadas. Por un lado, hay series que tienen varias temporadas y las veo en diferentes momentos, por lo que debería separar cada serie por temporadas, pero por otro lado, hacer una nota de serie duplicado puede quedar raro si únicamente hay una temporada. También es verdad que hay series que organizan muy mal las temporadas, lo que puede llegar a ser caótico.

Es por eso que al final decidí usar una solución híbrida. Cada serie tendrá su propia nota con las mismas propiedades que las películas. Si una serie tiene únicamente una temporada, se usa la nota de la serie. Si una temporada tiene varias temporadas, se crea una nota por cada temporada y a la fecha de la nota de la serie se le pone la misma que la última temporada vista.

Lo único malo es que tengo que tener en cuenta de actualizar dos estados y dos fechas para una misma serie con la nota de la serie y de la última temporada vista. Creo que es la solución más factible a este problema.

### Plugins y Scripts
Una de las cosas más increíbles que tiene Obsidian es la personalización con los plugins creados por la comunidad. Se abre un campo gigante de posibilidades. Principalmente he usado tres plugins que han hecho que la experiencia de usar el Media Tracker sea mucho mejor que con las soluciones antes vistas.

Realmente podría haber creado un plugin que englobase todo lo que quería hacer, pero como fui poco a poco, y no tenía mucha experiencia con Obsidian, fui añadiendo plugins y scripts a medida que necesitaba más funcionalidades. Os voy a explicar como lo tengo todo funcionando.

#### Templater
El plugin [Templater](obsidian://show-plugin?id=templater-obsidian) va muy bien para usar plantillas, ejecutar acciones y añadir información al crear nuevas notas. Esto nos va a ayudar a importar información de bases de datos de películas, series y juegos y organizar las notas al momento de crearlas.

#### Movie Search
El plugin [Movie Search](obsidian://show-plugin?id=movie-search) es un plugin algo antiguo pero sigue funcionando muy bien. Tiene alguna cosa que cambiaría, pero de momento es más que suficiente. El plugin añade un botón que abre un panel para introducir el nombre de la película o serie. Al buscar hará una búsqueda usando la API de TMDB y te mostrará todos los resultados.


![Panel de Movie Search Plugin para buscar una película o serie](MovieSearchPluginSearch.png)

![Resultados de la búsqueda con Movie Search Plugin](MovieSearchPluginResults.png)

Al seleccionar una opción, creará una nueva nota con una plantilla que he configurado, reemplazará las variables por los valores de la película o serie y ejecutará el código de Templater que he puesto. TMDB tiene dos tipos `movie` y `tv` que se añadirán directamente a la propiedad de `type` para poder diferenciarla. Se asignará un poster y un banner predeterminado por TMDB usando el link a la imagen y se almacenará el id de TMDB para poder referenciarla después. Se guardarán también los géneros y la sinopsis formateándolos de manera correcta, ya que el plugin tiene problemas si incluyen barras o comillas dobles. También comprueba si es una serie y le añade la propiedad de `temporadas`. Por último, coge el año y modifica el nombre del archivo para incluirlo y evitar problemas al crear notas de dos películas diferentes con el mismo nombre. La plantilla que estoy usando actualmente es esta: [Movie.md](https://github.com/christt105/media-tracker-obsidian-template/blob/main/MediaTrackerTemplate%2FTemplates%2FMovie.md)

Y este sería el resultado final de la nota:
![Resultado de una nota creada con Movie Search Plugin](MovieSearchPluginResultNote.png)

Con este plugin tenemos cubierta la creación de las películas y series con muy pocos clics y sin salir de la aplicación. Veamos ahora el otro plugin que nos solucionará los videojuegos, temporadas y nos hará la vida más fácil con algunas características.

#### QuickAdd
El plugin de [QuickAdd](obsidian://show-plugin?id=quickadd) te permite hacer muchas cosas, pero principalmente yo lo uso para crear scripts y ejecutarlos mediante acciones. De esta forma puedo crear y editar mis notas fácilmente y accediendo a APIs externas desde la interfaz de Obsidian. Los scripts son en JavaScript, la mayoría están hechos con IA y posteriormente los edito, es rápido y no se equivoca mucho. Estas son algunas de las funciones que he creado:

##### Añadir Juego
Para los videojuegos decidí usar la base de datos de [IGDB](https://www.igdb.com/). Para poder usar la API de IGDB tienes que iniciar sesión con Twitch, lo cual es un poco raro. La verdad que las bases de datos en ámbito de videojuegos están bastante por detrás de las películas y series. Todas están completamente en inglés y la información no es completa para todos los juegos. Decidí usar IGDB a diferencia de las otras porque era la única que tenían fangames que había jugado.

Usé este script de [Elaws/script_videogames_quickAdd](https://github.com/Elaws/script_videogames_quickAdd) y lo modifiqué para personalizarlo a mi plantilla [IGDB.md](https://github.com/christt105/media-tracker-obsidian-template/blob/main/MediaTrackerTemplate%2FTemplates%2FIGDB.md), resultando en [este script](https://github.com/christt105/media-tracker-obsidian-template/blob/main/MediaTrackerTemplate%2FScripts%2FQuickAdd%2Figdb.js). El funcionamiento es similar al buscador de películas y series, introduces em nombre del juego y te salen varias opciones para seleccionar y crear la nora. Así sería una nota de un videojuego vista desde Obsidian:

![Ejemplo Nota Silksong](NoteSilksong.png)


##### Crear Temporada
Después de decidir la estructura de Series/Temporadas, necesitaba que con un botón pudiera crear, a partir de una nota tipo Serie, una nota de tipo Temporada con todos los atributos y referencia de la Serie. Hice [este script](https://github.com/christt105/media-tracker-obsidian-template/blob/main/MediaTrackerTemplate%2FScripts%2FQuickAdd%2FcreateSeason.js) que al ejecutarlo, comprueba que estás en una nota de tipo serie, te pide un número de temporada y genera una nota, c
usando [esta plantilla](https://github.com/christt105/media-tracker-obsidian-template/blob/main/MediaTrackerTemplate%2FTemplates%2FSeason.md), con el nombre de la serie y añadiendo `" - Temporada X"` al final. La nueva nota copia las imágenes de la serie y las enlaza mediante la propiedad `temporadas` y `serie`. Así quedaría una nota de temporada.

![Ejemplo Nota Temporada Obsidian](MediaTrackerSeasonObsidian.png)

##### Actualizar Imágenes
Usar únicamente la primera imagen que proporcionaban TMDB e IGDB no es muy personalizable y tener que buscarlas manualmente en las distintas webs no era una opción. He creado [este script](https://github.com/christt105/media-tracker-obsidian-template/blob/main/MediaTrackerTemplate%2FScripts%2FQuickAdd%2FupdateImages.js) que te muestra distintas imágenes, seleccionas la que te gusta y la sustituye directamente. El script funciona tanto para portadas como para banners, al ejecutar la acción te pregunta cuál quieres cambiar. El script identifica que tipo de elemento es, si es película o serie, busca en [TMDB](https://www.themoviedb.org/?language=es) con el id guardado en la nota y te va enseñando portadas de 5 en 5, si es videojuego, uso la api de [SteamGridDb](https://www.steamgriddb.com/), ya que las imágenes de IGDB son muy malas. En las notas de videojuegos primeramente busca si hay un id de SteamGridDb, si no lo encuentra, te busca juegos en su base de datos con un nombre similar y al seleccionarlo, guarda el id para futuras búsquedas. Si tiene el id de Steam, muestra primeramente el arte oficial de la tienda.
![ObsidianUpdateCover](ObsidianUpdateCover.png)
![ObsidianUpdateBanner](ObsidianUpdateBanner.png)

##### Steam Id
Después de portear todas mis notas de Notion a este nuevo sistema, para los juegos que estaban en la tienda de Steam, necesitaba guardarme el id de Steam para poder generar un link de la tienda y poder mostrar las imágenes oficiales del juego para seleccionar. Así que creé [este script](https://github.com/christt105/media-tracker-obsidian-template/blob/main/MediaTrackerTemplate/Scripts/QuickAdd/steam.js) que busca en la tienda y inserta el id de Steam en la nota.

##### Importar scripts
Si quieres importar todos estos scripts directamente, puedes hacerlo usando la herramienta de QuickAdd de importar scripts usando el archivo [quickadd-package.quickadd.jsob](https://github.com/christt105/media-tracker-obsidian-template/blob/main/MediaTrackerTemplate/QuickAdd%20Packages/quickadd-package.quickadd.json). Sigue las instrucciones del README para configurarlos.

#### Pretty Properties
[Pretty Properties](obsidian://show-plugin?id=pretty-properties) es un plugin visual. Es opcional y lo uso para ver las portadas y los banners en cada nota.

## Flujo actual
Mi flujo actual es el siguiente. Para las películas, si la veo en [Jellyfin](https://jellyfin.org/), tengo instalado el plugin que me añade la película como vista en [Simkl](https://simkl.com/) automáticamente, si la he visto en el cine u otra plataforma, la añado manualmente. Seguidamente entro en Obsidian y la añado. Le cambio la fecha a la actual, el estado a "Acabado", le pongo una nota del 1 al 7 y si me apetece escribo qué me ha parecido.

Para las series el flujo es el mismo. Cada episodio se va añadiendo automáticamente a Simkl, y al acabar, la añado a Obsidian. Si es una temporada nueva la creo desde la nota de la serie y si no, uso la nota de la serie directamente.

Para los videojuegos es lo mismo. Al acabarlos, los agrego y les pongo las imágenes que me gusten.

## Conclusiones
Con esta nueva herramientas puedo tener un gestor de mis películas, series y juegos que consumo muy cómodo. Gracias a Obsidian, con algunos plugins y scripts, puedo añadir y modificar elementos sin salir de la aplicación, usando bases de datos externas como TMDB o IGDB y compartido entre mis dispositivos. Los datos son simples archivos de texto que puedo manejar como quiera, ya que son de mi propiedad y solo yo tengo acceso a ellos. Cada nota es individual y puedo añadir el contenido que quiera en cada elemento. Al tener la carpeta viviendo en mi vault personal, se genera una copia de seguridad automáticamente dos veces al día. 

Para mi uso personal, esta nueva solución es perfecta para mi y no tiene nada que envidiar a las otras herramientas mencionadas en el anterior post. De la lista que hemos visto al inicio del post, falta un único punto por cumplir, y es la posibilidad de crear una página web. El aspecto social no es algo que vaya a usar pero es algo que me gustaría tener. El poder compartir con mis amigos lo que he visto y jugado es algo que me gustaría tener. Gracias a HUGO y la naturaleza de Obsidian, ha sido muy fácil crearla, pero eso lo veremos en el próximo post.

Espero que te haya gustado este post. Lo tenía escrito de hace algunas semanas pero decidí crear y subir la plantilla por si alguien lo quiere usar. Cada persona es diferente y puede que no esté perfectamente como uno quiere. Si te ha servido de algo, te agradecería que dejaras una reacción o comentario en el post y una estrella en [la plantilla](https://github.com/christt105/media-tracker-obsidian-template).

Me despido y nos vemos en el siguiente post, donde te enseñaré como he creado una página como esta https://christt105.github.io/MediaTracker/ con los datos de mi Media Tracker en Obsidian. 

Hasta la próxima!