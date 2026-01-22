---
title: "En busca del registro multimedia definitivo: Los orígenes"
description: Primera parte de una serie sobre mi experiencia llevando un registro de películas, series y juegos. Un repaso a las herramientas y aprendizajes que me llevaron a mi sistema actual.
date: 2026-01-22
image: cover.jpg
keywords:
  - media tracker
  - evolución
  - herramientas
  - películas
  - videojuegos
  - series
  - organización
  - notion
readingTime: true
comments: true
draft: false
categories:
  - Media Tracker
tags:
  - Tracking
  - Organización
  - Retrospectiva
  - Notion
---
Hola de nuevo. Esta vez ha pasado menos tiempo desde el último post, y espero que sea algo más corto que el anterior. 

Hice un post sobre este tema pero me quedó excesivamente largo, así que lo he dividido en tres. Este va a ser el primer post de los tres, en el que voy a explicar mi experiencia llevando un registro de películas, series y juegos que he visto y jugado. En los siguientes dos posts, explicaré las dos nuevas herramientas para llevar mi registro multimedia.

## Antecedentes
Soy una persona a la que le gusta saber lo que hizo y cuándo lo hizo pero a la vez tengo mala memoria. Por otro lado, nunca he tenido mucha cultura cinéfila. Veía películas dentro de la normalidad, pero lo que echaban por la televisión y de vez en cuando lo que había en el cine. De series prácticamente no veía nada, recuerdo ver The Walking Dead y Breaking Bad pero no acabé ninguna. En cuanto a juegos, la cosa cambia. De pequeño me encantaban y jugué a bastantes de ellos. Hubo una época que dejé de jugarlos, luego volví a ellos con bastante más moderación y me puse a estudiar desarrollo de videojuegos y ahora los hago. Cuando me hice mayor, le acabé cogiendo el gusto a las películas y series, empecé a verlas de otra forma. También ayudó que ahora es mucho más fácil tener acceso a cualquier película.

Tener un control de lo que ves y juegas es bastante satisfactorio. Es información sobre ti plasmada en un medio que te permite ver tus gustos y evolución cultural. Es por ello que me apeteció tener un registro multimedia, el problema es que no hay ninguna solución disponible que cumpla todas mis necesidades. Así que en este post haré retrospectiva de mi evolución usando diferentes herramientas para tener un registro multimedia.

## Twitter y TvTime
Todo empezó en 2022 cuando me di cuenta de que no había jugado a nada de lo que llevaba de año ni estaba acostumbrado a ver series ni películas. Quería llevar un control de lo que veía y jugaba, así que empecé a hacer un hilo de Twitter con los juegos que me iba pasando, y usé [TvTime](https://www.tvtime.com) para llevar un registro de las películas y series. Me pasé varios juegos seguidos ese mes, pero lo dejé de lado. Estuve usando TvTime para llevar un control de los episodios pero a veces me olvidaba de seleccionar un episodio como visto, soy un poco desastre.

En 2023 empecé otro hilo para todo lo que jugaba y veía ese año. Ahora sí que lo llevaba más serio. Cuando acababa un juego, una película o una serie, escribía un tuit con un comentario y añadía imágenes.

Continué en 2024 con lo mismo. TvTime lo usaba para llevar el control de lo que veía para no olvidarme del episodio por el que iba y tener perspectiva de lo que estaba consumiendo.

## Stash y Backloggd
Para las películas y series, TvTime estaba bien, pero para los videojuegos tenía un problema. Estuve barajando varias opciones. 

Primeramente encontré [Stash](https://stash.games/), que es una aplicación para el móvil para llevar un tracking de los videojuegos. Puedes marcar los juegos como completado con la historia principal, la principal más las secundarias o completado al 100%.

Posteriormente vi [Backloggd](https://backloggd.com/) y estuve investigando. Es muy parecido a Stash pero en web. Tenían en el roadmap algo que me interesaba mucho y era la creación de una API. Por lo que podría leer y modificar datos externamente. Nunca la llegaron a crear y la quitaron del roadmap.

## Notion
Con las herramientas previamente mencionadas podía llevar un tracking de todo, pero no era propietario de mis datos, no tenía forma de extraer los datos para meterlos en otra herramienta por si llegaran a descontinuarla. Justo en 2024 me llegó la fiebre de [Notion](https://www.notion.com).  Con esta herramienta podía crearme mis propias bases de datos y se me ocurrió tener el tracking ahí. La idea era seguir usando Twitter, como escaparate social, y TvTime como tracker episódico. El problema principal con Twitter era que no podía modificar el tuit si había algún error, es información muy volátil y buscar algo se estaba volviendo muy complicado. TvTime simplemente funcionaba, le faltaba alguna cosa como poder ver por donde iban mis amigos en cada serie, pero por lo demás simplemente me funcionaba.

Por otro lado, con Notion podía generar una base de datos y que cada elemento fuera una película, serie o videojuego. Podía editar cualquier nota en cualquier momento y podía publicarlo en la web. Posteriormente añadieron posibilidad de hacer gráficos para mostrar estadísticas. Todo era muy bonito, así que creé una [plantilla](https://www.notion.com/templates/media-tracker-es) y empecé a migrar todo a Notion. Publiqué [la página web](https://christt105.notion.site/media-tracker) con Notion y seguí usando Twitter y TvTime como de costumbre, iba trackeando las series en TvTime y al acabar una serie, juego o película, la publicaba en twitter y la añadía a Notion.

En Notion tenía varias secciones donde se mostraban los elementos. Cada película, serie o videojuego tiene varias propiedades. Las esenciales son:
- Portada (Imagen): normalmente la url directa de la imagen de [tmdb](https://www.themoviedb.org/) o [thetvdb](https://www.thetvdb.com/), o una imagen subida.
- Tipo (Seleccionar): Película, Serie o Videojuego.
- Estado (Estado): Sin Empezar, En curso, Pausado, Abandonado o Acabado.
- Completado (Fecha): Fecha de completado.
- Lanzamiento (Fecha): Fecha de lanzamiento, con posibilidad de notificación para avisar.
- Propiedades (Selección múltiple): Diferentes propiedades como la plataforma de juego, si lo he visto en el cine, si es anime o si lo he completado al 100%.

![Ejemplo Nota en Notion](NotionMarioGalaxy2.png)

Cada vez que quería añadir un nuevo elemento, lo que debía hacer era ir a [TMDB](https://www.themoviedb.org/), [TVDB](https://www.thetvdb.com/) o [SteamGridDB](https://www.steamgriddb.com/), buscar el nombre, copiarlo, volver a Notion, crear una nueva nota, pegar el nombre, volver a la web, buscar por los carteles el que más me gustara, copiar la url, volver a Notion, pegarlo en la sección de cover como url y finalmente seleccionar el tipo de elemento que es. No es excesivo trabajo, pero nada comparable al flujo que he conseguido ahora.

Hay otras propiedades como botones que cambian el estado y la fecha o recomendado a gente, pero no son interesantes. Con todas estas propiedades se puede hacer un tracker más que decente.

### La web con Notion
Notion te permite publicar tus notas a la web. Publiqué el Media Tracker con Notion y me generó esta url: https://christt105.notion.site/media-tracker. La web es básicamente la interfaz de Notion pero sin la posibilidad de interactuar. No se puede cambiar el estilo, por lo que las portadas quedan muy pequeñas y el resultado deja bastante que desear.

![Web con Notion](NotionFullScreen.png)

### Media Cover Recap
Antes de acabar 2024, me gustó la idea de hacer un collage con todas las portadas de todo lo que había consumido ese año y me puse a trabajar en ello. Para solucionar eso, Notion tiene una API que me permitía coger información de mis bases de datos y así es como hice el [Media Cover Recap](/es/projects/mediacoverrecap/), un proyecto web de [Godot](https://godotengine.org/es/) que generaba collages de la base de datos de Notion. Obviamente Godot no es la mejor herramienta para eso, pero por aquel entonces estaba muy obsesionado con Godot y quise probar. 

Funcionaba decentemente pero el problema principal era el [CORS](https://developer.mozilla.org/es/docs/Web/HTTP/Guides/CORS), que no se permiten peticiones http de un servicio a otro. Por lo que o creaba un pequeño servidor que redireccionara las peticiones o lo hacía aplicación de escritorio y móvil. Y tampoco sería una buena solución porque las imágenes con links pueden dejar de estar disponibles o la API de Notion puede cambiar y dejaría de funcionar. Así que todo el tiempo que le dediqué a este proyecto estaba destinado a irse a la basura.

![Media Cover Recap en Godot](MediaCoverRecap.png)

## Conclusión
Visto todo esto, quería algo más, darle un pequeño empujón para que fuera perfecto y me sintiera cómodo con lo que estaba usando. La solución de Notion era más que decente, pero tenía grandes inconvenientes. El añadir un nuevo elemento era algo incómodo, únicamente podría usarlo con conexión a internet, navegar entre los elementos era tedioso y no permitía una estructura perfecta, la web era bastante fea e inmutable y el media cover recap estaba destinado a la desaparición. Aunque fuera muy poco probable, Notion podía eliminar todo mi contenido si quisiera.

Es por eso, y porque empecé a usar [Obsidian](https://Obsidian.md), que decidí crear una nueva solución a mi Media Tracker, esta vez algo más complejo de configurar pero mucho más cómodo de usar. He conseguido una herramienta que se adapta perfectamente a mi. Es cómoda y tiene todo lo que necesito. Pero eso lo explicaré en el siguiente post.

Hasta luego!