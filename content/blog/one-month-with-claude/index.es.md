---
title: He pagado un mes de Claude y tengo opiniones
description: "Reflexión sobre un mes usando Claude: de Elit3D a TeleDonkey y el Media Tracker, y lo que me genera pensar en todo esto."
date: 2026-06-07
image: cover.webp
keywords:
  - Claude
  - IA
  - Inteligencia Artificial
  - programación
  - proyectos
readingTime: true
comments: true
draft: true
categories:
  - Programación
tags:
  - ia
  - claude
  - proyectos
  - reflexión
---

Hola de nuevo. Hoy voy a salirme un poco del formato habitual. Voy a hablar de algo que lleva tiempo siendo el tema de conversación del mundillo de la tecnología: la inteligencia artificial. Pero desde mi perspectiva personal, sin grandes proclamas, solo contando lo que ha pasado este último mes.

## El año con Gemini

En diciembre conseguí un año gratuito de Gemini Pro y la verdad que bastante contento. No solo para cosillas de programación personal; en el trabajo llegué a rehacer un proyecto completo en otra tecnología con su ayuda, y funcionó muy bien, en relativamente poco tiempo. La IA como segunda opinión informada y rápida es algo que se agradece mucho cuando estás metido en algo y necesitas salir del atasco.

El problema con Gemini fue que con el tiempo fueron capando funcionalidades y recortando los tokens disponibles. Para el uso que le doy sigue funcionando bien, pero se nota que han ido apretando las tuercas.

Soy programador, así que la IA está muy presente en mi día a día. Ya no concibo trabajar sin tener alguna cerca. Eso sí, es importante matizar que la IA no me programa por mí; es más como una segunda opinión muy bien informada. Cuando me enfrento a un problema ya sé por dónde atacarlo, la IA simplemente hace que el proceso sea mucho más rápido.

## El salto a Claude

Llevo un tiempo trabajando en [Elit3D](https://christt105.github.io/es/projects/elit3d/), un editor de mapas de tiles en 3D que empecé en la universidad. El proyecto ha tenido bastantes vidas: en la universidad lo hice completamente en C++, a los años lo empecé a rehacer en Godot con GDScript, luego decidí pasarlo a C# y, finalmente, quise hacerlo mucho más profesional separando por proyectos, de forma que Godot fuera únicamente la interfaz y toda la lógica corriera en proyectos de C# estándar.

Un amigo me comentó por Discord que llevaba un tiempo usando Claude y que estaba bastante contento. Son 20€ por un mes (espero que este comentario no envejezca muy mal) y pensé que por probar no se pierde nada. Mi intención era aprender de la IA a la vez que avanzaba en los proyectos a mucha más velocidad de lo habitual.

Y la verdad es que funcionó. En cosa de una semana Elit3D mejoró bastante y estoy muy cerca de tener una alfa bastante estable para lanzar.

La diferencia real entre Gemini y Claude tampoco es tan grande. Lo que cambió fue que por fin tenía tiempo para ponerme con los proyectos, las ganas de aprender y, sobre todo, una forma de trabajar que antes no había explorado.

## El viernes que no quería desperdiciar

Pasaron los días y por cosas de la vida estuve sin poder programar en mi tiempo libre durante una semana. Llegó el viernes por la tarde y me entró el cargo de conciencia de estar pagando la suscripción sin aprovecharla. Así que abrí Claude con la intención de hacer alguno de esos proyectos que siempre tengo aparcados en la lista de pendientes, esos que nunca llegan porque me falta tiempo o porque están fuera de mi campo.

Lo primero fue [TeleDonkey](https://christt105.github.io/projects/teledonkey/). La idea era sencilla: un bot de Telegram que se conectara a mi instancia de MLDonkey y que al enviarle un enlace lo añadiera a la cola de descargas, además de tener algunos comandos útiles para gestionar las descargas. Mientras se lo comentaba a mi amigo por Discord y creaba el bot en la plataforma, Claude ya lo estaba construyendo. En 20 minutos lo tenía funcionando.

Pero la parte que más me sorprendió no fue esa. Le dije que lo subiera a GitHub. Lo hizo. Luego le pedí que entrara por SSH a mi servidor local en el mini PC. Y simplemente lo hizo. Le puse el logo del proyecto, le pedí que configurara GitHub Actions y que publicara la imagen en Docker Hub, que añadiera el proyecto a mi página web y que lo commiteara todo, y en un rato ya estaba funcionando. Sin que yo mirara absolutamente nada de código; no me había dado ni tiempo y ya estaba bien.

A mí solo hacerlo me hubiera costado bastante. Con un poco de idea de lo que había que hacer, en menos de media hora ya estaba desplegado, en GitHub, en mi web y funcionando en mi servidor. Es un proyecto que tenía aparcado sin saber muy bien cuándo me pondría con él.

![Claude desplegando TeleDonkey en el servidor desde el móvil](teledonkey_deploy.jpg)

## El perro y el Media Tracker

Al rato me puse con otro proyecto pendiente: el [Media Tracker](https://christt105.github.io/MediaTracker/). Es una web hecha con Hugo que llevaba tiempo queriendo mejorar, pero que estaba bastante hecha de aquella manera porque tampoco sé mucho de programación web.

Ese mismo amigo me había comentado lo del remote control: dejas el ordenador encendido y desde el móvil vas hablando con Claude directamente. Así que eso hice. Abrí el proyecto en el PC, di las instrucciones y me fui a sacar al perro.

Hicimos la planificación de todo lo que había que hacer y lo dividimos en fases. Cada fase terminaba subiendo un commit, y yo mientras tanto iba mirando la web desde el móvil para comprobar que todo estuviera bien, todo esto mientras estaba por la calle con el perro mirando el móvil de vez en cuando. Corrigió problemas de estilo, arregló varios bugs, añadió una barra de búsqueda y filtros, separó el proyecto en contenido y tema, creó un proyecto template para que cualquiera pudiera usarlo como punto de partida... y más cosas. En una tarde hice lo que me hubiera llevado semanas. Y lo hizo él solo, creación, comprobación, commits y deploy.

Por la noche le dije que siguiera con unas cosas más y que cuando acabara apagara el ordenador. Casi al terminar me quedé sin tokens y se pausó, así que el ordenador se quedó encendido toda la noche. Por la mañana le dije que continuara, acabó más o menos lo que le quedaba y apagó el ordenador.

![A las 7:28, cuando me desperté y le dije que continuara](out_of_tokens.jpg)

## Al día siguiente

Por la mañana instalé Claude en el mini PC. Ahora puedo iniciar una sesión SSH, activar el remote control y desde el móvil tengo acceso a prácticamente todos mis archivos y proyectos. Da algo de miedo, la verdad, pero es una pasada.

![Claude Code en el mini PC, controlado desde el móvil](claude_in_home_server.jpg)

Estuve afinando el Media Tracker mientras hacía tareas del hogar, todo desde el móvil. Al mediodía se reiniciaron los tokens aunque me quedaban bastantes.

Me puse con otro proyecto relacionado con el Media Tracker. Todo mi seguimiento de películas, series y juegos vive en mi vault de Obsidian y con una amalgama de plugins y scripts puedo hacer muchas cosas, pero siempre me ha parecido incómodo tenerlo tan separado. Nunca lo habría hecho yo solo, así que le dije a la IA que cogiera mis scripts y generara un plugin de Obsidian que hiciera lo mismo de forma integrada. En nada ya lo tenía funcionando y casi sin errores. La funcionalidad ya la tenía hecha, eso sí, pero pasarla a un plugin resultó ser mucho más cómodo para el día a día.

Me tuve que ir a comprar, así que iba mirando lo que hacía desde el móvil. Lo probé en la calle, fui afinando desde fuera de una tienda mientras esperaba con el perro. Decidí añadirle la API de TheTVDB mientras estaba ahí, y en nada lo hizo.

{{< github-repo-card owner="christt105" repo="hugo-mediatracker-plugin" >}}

Este tipo de procesos me impresionan. El flujo de desarrollo no es el que debería, porque al final estoy publicando versiones sin probar en local, le digo que suba una release, la actualizo en el móvil y pruebo directamente. Pero para este tipo de proyectos no hay ningún riesgo real, y la velocidad a la que avanza compensa con creces.

## La parte que acojona

Y aquí es donde me paro a pensar.

Lo que ha pasado con TeleDonkey o el Media Tracker tiene un matiz importante: son proyectos donde me importa mucho más el resultado que el proceso. Proyectos pendientes que quería tener funcionando y para los que no tenía ni tiempo ni suficiente experiencia en esas áreas. Para eso la IA es una herramienta increíble.

Pero Elit3D es otra historia. Ahí nunca voy a enviar prompts desde el móvil mientras saco al perro. Esos proyectos los voy a revisar yo, línea a línea, estando delante del ordenador y probando cada cambio. Son proyectos donde disfruto tanto del proceso como del resultado, y la IA la uso como apoyo, no como piloto.

El problema, o lo que realmente acojona, es otro. Cada vez está más cerca el punto en el que alguien sin ningún conocimiento técnico pueda hacer exactamente lo mismo que hice yo con TeleDonkey. Lo que antes requería años de estudio, ahora puede hacerse con la descripción correcta. Sé que hay muchas cosas que hago rápido con la IA precisamente porque ya me he enfrentado a esos problemas y sé por qué flanco atacarlos, pero hasta qué punto vamos a llegar.

Lo que más me da melancolía es que se ha perdido algo del trabajo artesanal de la programación. Ya no te pegas tanto contra una pared buscando durante horas en foros cómo solucionar algo, ya no tienes esa pequeña victoria personal de resolver algo difícil tú solo después de mucho esfuerzo. La IA ve tu código, tus carpetas, el contexto del proyecto, y actúa. Cada vez programaremos menos y revisaremos más, hasta que llegue un punto en que dejemos de hacer gran cosa, si es que no hemos llegado antes a algún tipo de colapso.

Pero tampoco quiero ser catastrofista. La IA ha llegado para quedarse y el problema, como casi siempre, estará en el uso que le demos.

## Este post también es un experimento

Incluso este post lo estoy probando con IA. Por la noche lo escribí desde el chat de Claude en el móvil, con las faltas de ortografía del cansancio y sin releer nada, y lo generó en el mini PC. Ahora, al día siguiente, estoy retocando y añadiendo cosas entre tarea y tarea.

Si estás leyendo esto, supongo que no ha quedado tan mal.

La tecnología y la programación son mi hobby y mi trabajo, y no veo la IA como algo negativo. Simplemente nos está cambiando la forma de hacer las cosas y hay que adaptarse. Seguiré haciendo proyectos, seguiré escribiendo posts, y si de vez en cuando la IA me echa una mano, bienvenida sea.

Nos vemos en el siguiente post.
