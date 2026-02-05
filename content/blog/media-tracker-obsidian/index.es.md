---
title: "En busca del registro multimedia definitivo: Obsidian"
description: "Exploro cómo he convertido Obsidian en el corazón de mi Media Tracker personal, utilizando scripts y plugins para gestionar series, películas y videojuegos de forma local y privada."
date: 2026-02-05
image: cover.png
keywords: [Obsidian, Media Tracker, Personal Knowledge Management, Automation, QuickAdd, Templater]
readingTime: true
comments: true
draft: false
categories:
  - Media Tracker
tags:
  - Obsidian
  - Tracking
  - Automation
  - Self-hosted
---
Bienvenidos a la segunda parte de la serie "En busca del registro multimedia definitivo". En este post os mostraré la herramienta principal de mi nuevo media tracker.

[En el anterior post](../media-tracker-origins) expliqué todas las herramientas previas a esta. Este post probablemente va a ser el más extenso de los tres. Mi objetivo es explicar todo lo que tengo configurado, con todos los scripts y configuraciones, por si alguien quiere replicar lo que he hecho. Mi nueva solución usa dos herramientas, pero esta es el corazón de mi media tracker. Vamos allá.

## La nueva solución

Para mi nuevo Media Tracker quería tener varios puntos presentes:
- Todos mis datos deben pertenecerme.
- Poder migrar los datos a otra aplicación si hiciera falta.
- Accesible desde cualquier dispositivo. Ser capaz de añadir, eliminar y editar cualquier dato, principalmente desde mi móvil, pero que también sea accesible desde el ordenador.
- Poder añadir comentarios, imágenes y vídeos a cada elemento.
- Tener una página web que sea fácilmente accesible desde cualquier dispositivo y completamente adaptable a mis necesidades.
- Poder añadir películas, series y juegos en la misma base de datos y que sea cómodo hacerlo.

Después de investigar, decidí decantarme por la idea de usar [Obsidian](https://obsidian.md/) para la creación y edición de cada elemento del tracker. Por la naturaleza de Obsidian con Markdown, y con la experiencia de haber hecho mi página web y blog con [Hugo](https://gohugo.io/), decidí usarlo para generar la página web de mi media tracker. Aunque de eso hablaremos en el siguiente post.

## Obsidian
Para los que sabéis cómo funciona [Notion](https://www.notion.com/), habréis arqueado la ceja en el [post anterior](../media-tracker-origins) al leer que con Notion mis datos me pertenecían; y no es cierto. En Notion los datos no son tuyos: pueden revocarte el acceso a ellos cuando consideren porque son de su propiedad, así que tocaba mover ficha.

De una fiebre a otra, llegó a mi vida [Obsidian](https://obsidian.md/). Esta herramienta es una aplicación para tomar notas en formato Markdown. Te permite crear relaciones entre tus notas para generar un grafo. Es muy parecido a la estructura de la [Wikipedia](https://www.wikipedia.org/), donde puedes ir recorriendo distintas páginas a través de los enlaces relacionales.

Gracias a mi nueva adquisición, un mini PC, podía sincronizar mis notas de manera muy eficaz con [Syncthing](https://syncthing.net/), como ya expliqué en mi otro post [Seis meses con mi primer servidor casero](https://christt105.github.io/es/blog/six-months-with-my-first-home-server/), que era el punto que me echaba más hacia atrás de Obsidian. Ahora voy a explicar cómo tengo configurado Obsidian para el Media Tracker. Puede que en un futuro haga un post explicando cómo tengo configurado todo mi Obsidian, ya que me parece una herramienta increíble para integrar en tu día a día.

### Plantilla
No tenía pensado hacerlo, pero al final he creado una plantilla con todos los archivos necesarios para que funcione tal cual lo tengo yo. Configurarlo en un vault ya existente puede ser algo tedioso; debería haber sido un plugin, pero lo he ido haciendo sobre la marcha y no creo que mucha gente lo vaya a usar, ya que está todo hecho para cubrir mis necesidades específicas. Puedes descargar el vault, abrirlo con Obsidian y comprobar cómo está todo configurado.

[![Repositorio de la plantilla: media-tracker-obsidian-template](https://opengraph.githubassets.com/1/christt105/media-tracker-obsidian-template)](https://github.com/christt105/media-tracker-obsidian-template)

En el caso de que tuviera mucho apoyo, podría considerar hacer un plugin específico para Obsidian.

### Organización
Decidí tener el Media Tracker dentro de mi _vault_ principal de Obsidian. El Media Tracker vive únicamente en una carpeta; así evito que se mezcle con las otras notas y es más fácil de diferenciar. Dentro de `Juegos/`, `Movies/`, `TVs/` y `Seasons/` viven individualmente cada instancia de juegos, películas, series y temporadas respectivamente; cada elemento tiene su nota. También tengo la carpeta `Portadas/` donde guardo las imágenes de las portadas y banners de elementos que no están en la web, sobre todo de fangames.

![Carpetas de mi Media Tracker dentro de Obsidian](MediaTrackerFolders.png)

En `Media Tracker/` está el archivo `Media Tracker Views.base`, que es un archivo tipo base con varias vistas. Las bases son un añadido muy reciente; justo lo acababan de implementar cuando empecé a usar Obsidian. Es un archivo que te permite visualizar tus notas de varias formas, parecido a las vistas de Notion. Tiene una API, por lo que la comunidad ya está empezando a usarlas para cosas más complejas. De momento únicamente he creado vistas muy básicas y casi no las uso, ya que tengo la web.

![Media Tracker Base View All](MediaTrackerBaseAll.png) 
![Media Tracker Base View Anime](MediaTrackerBaseAnime.png)
![Media Tracker Base View Table](MediaTrackerBaseTable.png)

### Series y Temporadas
Con las series tenía un problema. No sabía qué hacer con las series con múltiples temporadas. Por un lado, hay series con varias temporadas que veo en diferentes momentos, por lo que debería separar cada una, pero por otro lado, hacer una nota de serie duplicada puede quedar raro si únicamente hay una temporada. También es verdad que hay series que organizan muy mal las temporadas, lo que puede llegar a ser caótico.

Es por eso que al final decidí usar una solución híbrida. Cada serie tendrá su propia nota con las mismas propiedades que las películas. Si una serie tiene únicamente una temporada, se usa la nota de la serie. Si tiene varias temporadas, se crea una nota por cada temporada y a la fecha de la nota de la serie se le pone la misma que la de la última temporada vista.

Lo único malo es que tengo que actualizar dos estados y dos fechas para una misma serie (en la nota de la serie y en la de la última temporada). Creo que es la solución más factible a este problema.

### Plugins y Scripts
Una de las cosas más increíbles de Obsidian es la personalización con los plugins de la comunidad. Se abre un campo gigante de posibilidades. Principalmente he usado tres plugins que han hecho que la experiencia sea mucho mejor que con las soluciones anteriores.

Realmente podría haber creado un plugin que englobase todo, pero como fui poco a poco y no tenía mucha experiencia con Obsidian, fui añadiendo plugins y scripts a medida que necesitaba funcionalidades. Os voy a explicar cómo lo tengo funcionando.

#### Templater
El plugin [Templater](obsidian://show-plugin?id=templater-obsidian) va muy bien para usar plantillas, ejecutar acciones y añadir información al crear nuevas notas. Esto nos ayuda a importar información de bases de datos de películas, series y juegos y a organizar las notas al momento de crearlas.

#### Movie Search
El plugin [Movie Search](obsidian://show-plugin?id=movie-search) es algo antiguo pero sigue funcionando muy bien. Tiene alguna cosa que cambiaría, pero de momento es más que suficiente. Añade un botón que abre un panel para introducir el nombre de la película o serie. Al buscar, consulta la API de TMDB y te muestra los resultados.

![Panel de Movie Search Plugin para buscar una película o serie](MovieSearchPluginSearch.png)

![Resultados de la búsqueda con Movie Search Plugin](MovieSearchPluginResults.png)

Al seleccionar una opción, crea una nueva nota con una plantilla configurada, reemplaza las variables por los valores correspondientes y ejecuta el código de Templater. TMDB tiene dos tipos (`movie` y `tv`) que se añaden directamente a la propiedad `type`. Se asigna un póster y un banner predeterminado usando el enlace a la imagen y se almacena el ID de TMDB para futuras referencias. Se guardan también los géneros y la sinopsis formateándolos correctamente, ya que el plugin tiene problemas si incluyen barras o comillas dobles. También comprueba si es una serie y añade la propiedad de `temporadas`. Por último, coge el año y modifica el nombre del archivo para incluirlo y evitar duplicados. La plantilla que uso actualmente es esta: [Movie.md](https://github.com/christt105/media-tracker-obsidian-template/blob/main/MediaTrackerTemplate%2FTemplates%2FMovie.md)

Y este sería el resultado final de la nota:
![Resultado de una nota creada con Movie Search Plugin](MovieSearchPluginResultNote.png)

#### QuickAdd
El plugin [QuickAdd](obsidian://show-plugin?id=quickadd) permite crear scripts y ejecutarlos mediante acciones. De esta forma puedo editar mis notas fácilmente accediendo a APIs externas. Los scripts están en JavaScript; la mayoría están hechos con IA y posteriormente editados por mí. Estas son algunas de las funciones que he creado:

##### Añadir Juego
Para los videojuegos decidí usar la base de datos de [IGDB](https://www.igdb.com/). Para usar su API tienes que iniciar sesión con Twitch, lo cual es un poco raro. Las bases de datos de videojuegos están por detrás de las de cine: suelen estar en inglés y la información es incompleta. Elegí IGDB porque era la única que incluía los fangames que he jugado.

Usé este script de [Elaws/script_videogames_quickAdd](https://github.com/Elaws/script_videogames_quickAdd) y lo modifiqué para mi plantilla [IGDB.md](https://github.com/christt105/media-tracker-obsidian-template/blob/main/MediaTrackerTemplate%2FTemplates%2FIGDB.md), resultando en [este script](https://github.com/christt105/media-tracker-obsidian-template/blob/main/MediaTrackerTemplate%2FScripts%2FQuickAdd%2Figdb.js). El funcionamiento es similar al buscador de películas: introduces el nombre y seleccionas la opción para crear la nota.

![Ejemplo Nota Silksong](NoteSilksong.png)

##### Crear Temporada
Necesitaba que, con un botón, pudiera crear desde una nota de Serie una nota de Temporada con sus atributos y referencias. Hice [este script](https://github.com/christt105/media-tracker-obsidian-template/blob/main/MediaTrackerTemplate%2FScripts%2FQuickAdd%2FcreateSeason.js) que comprueba que estás en una nota de serie, pide el número de temporada y genera la nota usando [esta plantilla](https://github.com/christt105/media-tracker-obsidian-template/blob/main/MediaTrackerTemplate%2FTemplates%2FSeason.md), añadiendo `" - Temporada X"` al nombre. La nueva nota copia las imágenes de la serie y las enlaza mediante las propiedades `temporadas` y `serie`.

![Ejemplo Nota Temporada Obsidian](MediaTrackerSeasonObsidian.png)

##### Actualizar Imágenes
Usar solo la primera imagen de TMDB o IGDB no es muy personalizable. He creado [este script](https://github.com/christt105/media-tracker-obsidian-template/blob/main/MediaTrackerTemplate%2FScripts%2FQuickAdd%2FupdateImages.js) que muestra distintas imágenes para que elijas la que prefieras. Funciona para portadas y banners. Si es cine, busca en [TMDB](https://www.themoviedb.org/?language=es); si es videojuego, usa la API de [SteamGridDb](https://www.steamgriddb.com/), ya que las imágenes de IGDB suelen ser de baja calidad. El script busca primero el ID de SteamGridDb; si no lo encuentra, busca por nombre y guarda el ID para el futuro.

![ObsidianUpdateCover](ObsidianUpdateCover.png)
![ObsidianUpdateBanner](ObsidianUpdateBanner.png)

##### Steam ID
Para los juegos de mi antigua base de Notion, necesitaba guardar el ID de Steam para generar enlaces a la tienda y mostrar artes oficiales. Creé [este script](https://github.com/christt105/media-tracker-obsidian-template/blob/main/MediaTrackerTemplate/Scripts/QuickAdd/steam.js) que busca en la tienda e inserta el ID en la nota.

##### Importar scripts
Si quieres importar estos scripts directamente, puedes usar la herramienta de QuickAdd "import packages" con el archivo [quickadd-package.quickadd.json](https://github.com/christt105/media-tracker-obsidian-template/blob/main/MediaTrackerTemplate/QuickAdd%20Packages/quickadd-package.quickadd.json).

#### Pretty Properties
[Pretty Properties](obsidian://show-plugin?id=pretty-properties) es un plugin visual que uso para renderizar las portadas y los banners directamente en las propiedades de cada nota.

## Flujo actual
Mi flujo es el siguiente:
1. **Películas:** Si la veo en [Jellyfin](https://jellyfin.org/), un plugin la marca como vista en [Simkl](https://simkl.com/) automáticamente. Si es en el cine, la añado a Simkl a mano. Luego, en Obsidian, creo la nota, pongo el estado "Acabado", le asigno mi puntuación personal y escribo mi opinión.
2. **Series:** El flujo es el mismo episodio a episodio. Al terminar la temporada, la registro en Obsidian.
3. **Videojuegos:** Al acabarlos, los agrego y elijo las imágenes que más me gusten.

## Conclusiones
Con estas herramientas tengo un gestor multimedia comodísimo. Gracias a Obsidian y sus scripts, manejo todo sin salir de la app. Los datos son simples archivos de texto bajo mi control y con copia de seguridad automática dos veces al día al estar en mi vault personal.

Esta solución no tiene nada que envidiar a las herramientas comerciales. De la lista inicial, solo falta un punto: la página web para compartirlo con amigos. Gracias a Hugo y a que Obsidian usa Markdown, ha sido muy fácil, pero eso lo veremos en el próximo post.

Espero que te haya gustado. He tardado en publicarlo porque quería dejar lista la plantilla por si alguien quiere usarla. Si te sirve, te agradecería una reacción o una estrella en el repositorio.

¡Nos vemos en el siguiente post, donde enseñaré cómo crear una web como [esta](https://christt105.github.io/MediaTracker/) con estos datos!

¡Hasta la próxima!