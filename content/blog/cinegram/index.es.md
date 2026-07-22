---
title: cinegram
description: Descripción pendiente...
date: 2026-07-22
image: cover.jpg
keywords:
readingTime: true
comments: true
draft: true
categories:
  - 
tags:
  -
---
¡Hola otra vez!

Hoy post cortito (espero). Sigo acabando los proyectos que tengo a medias, por gastar los tokens de Claude sinceramente. He vuelto a paagar otro mes y quería avanzar en otros proyectos que no me requieran un análisis muy exagerado del código. Así que hoy publico Cinegram.
## Origen
Hará cosa de un año empecé a crear un bot de Telegram que te permitía enviarle archivos, los intentaba encontrar en la base de datos de TMDB y los referenciaba en una base de datos. Algo más tarde hice que te permitiera descargar archivos. Era un proyecto para aprender a hacer servicios con bases de datos y poderme conectar desde fuera creando un bakcend con fastApi. Y ahí me quedé, porque creo que se me fastidió algo del mini PC y perdí algo de trabajo y luego me dió pereza seguir.
## Ay la IA
Pues como he dicho, he vuelto a pagar un mes de Claude. Realmente quería darle una oportunidad a pagar tokens de algun modelo chino, he estado investigando, pero el poco tiempo libre que tengo y lo cómodo que es que tenga acceso a Claude desde cualquier sitio, lo he dejado para el mes que viene. Bueno, eso es tema para otro post.

La verdad que mi idea era seguir el bot y que todo lo hicieras desde Telegram, pero, ya que está la IA, por qué no hace una página web? Y ya que estamos, por que no lo linkeo a mi instancia de Jellyfin? Con la IA, el límite es la   imaginación, los tokens y la paciencia.

Así hice, a medida que se me ocurrían cosas que añadir, iba iterando. La idea era simple: que todas las películas sin copyright que tengo en mi jellyfin pueda guardarlas en un bot privado de Telegram y así preservar la cultura. Por otro lado si me encuentro películas libres de derechos de autor, poder pasárselas al bot y cuando quiera verlas descargarla cómodamente y se pongan automáticamente en Jellyfin. Creo que queda claro.

##  Por pedir que no falte
La verdad que le puse bastantes cosas, muchas más de las que iba a hacer en un principio. El proyecto se divide en 3 bloques.

### Backend
El encargado de guardar todos los datos y dotar a los demás servicios de ellos. Lo empecé en Python por simple curiosidad y aumentar conocimiento con FastAPI. La verdad que es muy fácil de empezar a usarlo y con poca cosa ya puedes tener una API decente y con documentación.

Cuando la hice yo a mano simplemente pensé la estructura de las películas. Cada película era única y podía tener una colección de colecciones y cada colección tiene un conjunto de archivos. De esta forma si una película estaba contenida en un único archivo, era una colección con un archivo, pero si por cuestiones de límite de tamaño de archivos es mayor, estará contenido en una colección con varios archivos. Luego con la IA añadí las series que es lo mismo pero con serie -> temporada -> episodio, y también se añadió para las tareas de subida y descarga.

Para acceder y manipular estos datos hay diferentes rutas. Antes estaba todo en un archivo porque yo lo empecé así al tener poca cosa pero luego se hizo monstruoso. Le pedí a Gemini que lo dividiera en archivos y la lió mucho, luego Claude lo arregló. No hay nada extraordinario, añadir, modificar y eliminar datos, búsqueda y mantenimiento si se queda alguna colección huérfana.

También añadí una librería para conectarme con TMDB y poder obtener información relevante de cada elemento.

### Bot
El bot lo hice con una librería de C# que me gustó mucho, [WTelegramBot](https://github.com/wiz0u/WTelegramBot). Es muy simple de configurar y revienta los límites de otras formas de crear bots de Telegram. Permite subida y descargas de archivos a muy buena velocidad y con los límites de un usuario normal. Creo que si hubiera usado WTelegramClient podría haber mejorado si se usa con una cuenta premium, pero para lo que es creo que es suficiente.

Era la primera vez que hacia un servicio así en .NET puro y la verdad que me gustó la experiencia y aprendí bastantes cosas. Hice un sistema que creabas un comando y automáticamente se registraba solo. La verdad que me gustó mucho. Realmente la idea era poder hacerlo todo con el bot y comandos, pero es más incómodo que tener una web específica para el proyecto y los comandos quedaron bastante inacabados. El propósito ahora del bot es recibir archivos, almacenarlos y devolverlos con una carátula bonita si se piden.

![Ejemplo de importar una película con archivos falsos de prueba](example_import.jpg)
![Ejemplo de una película identificada](example_film.jpg)
![Ejemplo de cómo devuelve los archivos el bot](example_files.jpg)
### Web
El orquestador de todo. Pieza que mejor muchísimo la experiencia. La verdad que el 95% del desarrollo fue yo desde el móvil. Está hecha con Vue3 porque es el framework que he usado, aunque casi no he mirado el código de la web. Al final del desarrollo quise probar [Stitch](https://stitch.withgoogle.com/), no el bicho azul de 4 brazos, sino una nueva herramienta de IA de Google para hacer diseños que no está mal. Exporté el proyecto y se lo di a Claude y fuimos iterando. Sinceramente el aspecto visual me da bastante igual para estas herramientas, pero he de reconocer que no se ve mal. Me he enfocado mucho en móvil ya que va a ser donde lo voy a usar la mayor parte del tiempo.

Tiene sección para películas y series que carga de Jellyfin, con su portada, indicador de si existe en la base de datos, nombre y año de publicación. Puedes filtrar y ordenar. Cada tarjeta tiene una pantalla individual para poder subirlo a Telegram.

![web_example_movies](web_example_movies.png)
![web_example_jellyfin](web_example_jellyfin.jpg)

Otra sección se pueden ver todos los elementos que hay en la base de datos de Telegram. Una visualización parecida, pero mostrando las colecciones que contiene. Cada una tiene también una página individual con información y controles para cambiar la portada, reidentificar el elemento, descargar a Jellyfin o enviar por el bot.

![web_example_telegram](web_example_telegram.jpg)
![web_example_telegram_film](web_example_telegram_film.jpg)

Por último he puesto una página para ver las descargas y subidas activas y una página con información de la instancia y corregir algún elemento que no se haya podido identificar.

![web_transfers](web_transfers.jpg)
![web_settings](web_settings.jpg)

## Proyecto de campo o proyecto de ciudad
Me gustó mucho la fabulosa del ratón de campo y el ratón de ciudad que usan en la película de [Chainsaw Man](https://christt105.github.io/MediaTracker/movies/chainsaw-man---la-pel%C3%ADcula-el-arco-de-reze-2025/), y creo que podemos hacer una analogía con los proyectos y la IA.

Veo dos tipos de proyectos. Los proyectos que quieres que todo esté bien estructurado y bonito, que te daría respeto si alguien mira el código y que tienes un vínculo cercano. Vas línea por línea revisando que todo tenga sentido y te pasas grandes sesiones comprobando que lo que estás haciendo es la mejor solución.

Por otro lado están los proyectos que simplemente quieres el resultado final y te da igual cómo está hecho por dentro. Simplemente quieres que funcione y te da igual. Esto antes de la IA era mucho más difícil de ver.

Cinegram empezó como un proyecto de campo. Era un interés personal por automatizar y hacer más cómodos mis procesos, pero quería aprender a usar bien FastAPI, profundizar más en el desarrollo de C# fuera de Unity y aprender más de bases de datos muy simples. Pero se ha convertido en un proyecto de ciudad, y no es malo.

Realmente sin la IA podría haberlo continuado, pero dudo que hubiera llegado a este punto, se hubiera quedado en un simple bot cutre y hubiera tardado mucho más en acabarlo si me hubieran vuelto las ganas y motivación de seguirlo.

Y aquí viene un poco la reflexión. Sin la IA seguramente este proyecto se habría quedado en el olvido, pero por una simple suscripción de 20€ y una semana, he sido capaz de retomar el proyecto, ampliar el servicio del backend para añadir las series y demás mejoras y añadirle una pagina web para gestionarlo todo. Y realmente, tampoco hubiera pasado nada si se hubiera quedado en el olvido.

![Panel de Chainsaw Man con la fábula del ratón de campo y ratón de ciudad](chainsaw_mouse.jpg)

## Compartir es vivir
Y como siempre, de código abierto para que lo pueda usar quien quiera. Si lo usáis dejadme por abajo vuestra opinión o si tenéis alguna duda. Esta vez he querido publicar la imagen de docker también en GitHub, la tenéis en también en Docker Hub, como siempre.

{{< github-repo-card owner="christt105" repo="cinegram" >}}

Y hasta aquí, espero que os haya gustado y nos vemos pronto con más.

Agur!