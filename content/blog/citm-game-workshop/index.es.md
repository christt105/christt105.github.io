---
title: Taller de Creación de Videojuegos
description: ""
date: 2026-07-10
draft: true
image: cover.png
---

Hola de nuevo!

Esta semana he estado liado con la impartición de un taller a adolescentes sobre desarrollo de videojuegos. Esta ha sido el segundo año que lo hago y ha salido mejor que el año pasado.

Enseñar siempre ha sido algo que me gusta. No soy el mejor enseñando, pero intento que siempre quede claro. Disfruto mucho de preparar estos materiales y explicarlos y también me encanta que me expliquen a mi.

Me surgió esta oportunidad en la universidad donde estudié, junto al ayuntamiento con un programa para fomentar la universidad.

El año pasado tuve estudiantes de primero a cuarto de la ESO y me pasé bastante con el material. En mi defensa diré que me dijeron que serían entre tercero y cuarto de la ESO y fue mi primera experiencia. El taller consiste en 4 días con tres horas cada día. 

Desde principios del año pasado estuve haciendo un taller de dos horas con alumnos de cuarto de la ESO y bachillerato. Al ser algo reducido de tiempo y la idea era que tuvieran un primer contacto con el desarrollo de videojuegos, me decanté por hacer un Flappy Bird en Unity. La idea era simple, daba un proyecto vacío de Unity con todos los sprites e íbamos haciendo entre todos. Como mucho llegábamos a tener el salto del pájaro y la instanciación de las tuberías. Para dos horas y como primera ronda de contacto creo que era más que suficiente. El material del taller lo tengo público en este repositorio: 

{{< github-repo-card owner="christt105" repo="FlappyBirdUnityWorkshop" >}}

Para el taller del año pasado, al ser una hora más al día y cuatro días seguidos, pensé en que daría el suficiente tiempo como para acabarlo suficientemente y necesitaba más proyectos para rellenar los demás días. Además también pensé que era buena idea un proyecto por día porque podría pasar que alguien no viniera un día y perdiera el hilo, así empezábamos todos de 0 cada día. 

Preparé para el primer día un Pong con Unity, el Flappy Bird en Unity que ya tenía por la mano, el tercer día un Asteroids con Godot y para acabar un juego de plataformas en 3D con Godot.

La verdad que los talleres del Flappy Bird fue porque me lo obligaron, ya que ya habían hecho todas las publicidad del taller con Unity. Insistí bastante en que Godot para talleres para adolescentes era mucho mejor idea. El hecho de que pese 100MB literalmente todo el motor y es descargar y abrir, a diferencia de los 15GB de Unity y la obligación de crear una cuenta, era mucho más ágil. Los niños en casa podían usarlo aunque su ordenador no fuera muy potente, el tiempo de compilación era horroroso, y la sintaxis de gdscript es mucho más limpia y fácil de entender para ellos. Si que para el taller di bastante por culo para convencerlos de añadir Godot alguno de los días, y creo que salió bien. Otra cosa no, pero convencer de productos de los cuales no me paga nadie, soy un genio.

Fue peor de lo que esperaba aunque los niños se lo pasaron muy bien. Prácticamente no dió tiempo a acabar ningún juego. Los más pequeños les costaba la vida seguir el ritmo y tenía que ir uno por uno arreglando lo que tocaban. Eso hacía que los más mayores se sabían esperando. 

El mejor día fue el último, con el plataformas 3D. Preparé una modificación del excelentísimo Starter-Kit de Kenney. La idea era borrar pocas líneas de código para que al empezar el personaje no se moviera ni hiciera nada, y al escribir es poca línea entre todos al principio muy rápidamente, empezarán a crear un nivel cada uno por su cuenta, con saltos, plataformas que caían y recogiendo monedas. Sin duda el día que noté que mejor se lo pasaron. Algunos sacaron papel y boli para diseñar sus niveles y al final los jugaban entre ellos. Los que iban más rápido podían avanzar haciendo sus niveles y los que necesitaban más ayuda yo podía estar con ellos. 

https://github.com/KenneyNL/Starter-Kit-3D-Platformer

En resumen, la experiencia estuvo bien, salí bastante satisfecho, aunque les comenté a los organizadores el tema de la diferencia de edad. 

---

Para este año quería mejorarlo. No tuve mucha más información así que asumí las mismas condiciones.

Lo más importante, recortar contenido. Aunque se lo pasaron bien, cuatro juegos eran demasiados. Decidí dejar dos, los más visuales. Primeramente el Flappy Bird y el plataformas 3D. De esta forma son dos días con Unity y dos días con Godot. Puede que dos motores los confundan pero es para que vean que hay varias herramientas, cada una con sus pros y sus contras, y porque en dirección del taller quieren seguir usando Unity y yo Godot.

Más adelante me decanté por hacer el primer día como tenía ya pensado el Flappy Bird, empezar con un proyecto vacío, solo sprites y hacer todos juntos. El segundo día usar el juego final, eliminar poco código, rellenarlo entre todos y al final que lo modifiquen creando mecánicas, modificando valores y sprites.

Para los últimos dos días lo tenía muy claro. Primero el día rellenando el código con las mecánicas y poder crear mecánicas que pidan conjuntamente y el segundo que creen su propio nivel y vaya ayudándoles creando mecánicas para hacer lo que se les ocurra.

### Uso de IA para mejorar materiales del taller

Cuando lo preparé, aún tenía la suscripción a Claude, así que la quería aprovechar para hacer cosas que yo no habría hecho sin la IA.

El año pasado algunos iban un poco perdidos y los más autónomos se aburrían esperando. Así que decidí crear unas guías para que los que iban perdidos puedan repasar como se hacen las cosas y los más avanzados puedan seguir autónomamente, además de añadir mecánicas extra para ambos juegos. Le pedí que generase unos documentos con todo esto.

Las guías estaban bien, pero el problema principal era que les iba a costar encontrar, abrir y leer esos archivos. Así que gracias a lo fácil que lo tiene GitHub a publicar webs por repositorio, pedí que generase una página web con toda la información de las guías. Me generó una pagina web muy simple con las guías. Era tal lo que quería, una web muy simple con la información muy accesible y visual. Me dió la idea de integrar los power points de cada día y me enseñó una forma de hacer power points con Markdown que me encantó. Le pedí que añadiera link a descargar ambos motores y a cada una de las plantillas. Convertí el power point del año pasado a este nuevo formato y lo subí. De esta forma había un punto único donde ellos podían entrar y consultar varias cosas. En casa podían seguir si a alguien le apetecía y tenían toda la información de lo que habíamos hecho. La página web: https://christt105.github.io/CITMGameWorkshop

Finalmente, el código eliminado era algo caótico de trackear. La IA me dió una idea, integrar unos comentarios específicos donde estaba el código a eliminar y crear un CI en GitHub Actions que elimine ese trozo y actualice la release. De esta forma podía tener el código perfecto en el repositorio y al hacer commit se eliminan unas secciones específicas, se limpian los proyectos y se actualiza la release con la plantilla para cada día.

Son cosas que no me habría dado tiempo a hacer porque están algo fuera de mi scope tecnológico, pero gracias a la IA, he podido mejorar mucho la experiencia de los estudiantes.

### Desarrollo del taller

El taller ha ido muy bien. Para mi sorpresa todos los estudiantes eran de tercero y cuarto de la ESO, así que todo fue más suave y unificado. Para ser jóvenes adolescentes no se alborotaron mucho, estuvieron haciendo el taller, sin yo tener que insistir en que hicieran las cosas. Preguntaron mucho y estaban interesados en hacer cosas fuera de lo que estábamos haciendo.

Mi objetivo principal era despertar su creatividad. El último día fue su favorito sin lugar a duda. Había alguno que quería añadir mecánicas bastante ambiciosas. Otros con lo poco que expliqué, supieron crear sus propias mecánicas que a mi no se me había ocurrido. Uno aprovechó que podía meter objetos dentro de otros objetos y se movían con ellos, puso muchas plataformas que si las tocabas perdías como hijas de una plataforma que si las tocabas caían, por lo que al pasar por una plataforma las otras caen y las has de esquivar. Otro alumno hizo unos diálogos habiendo yo enseñado como ejecutar código al entrar y salir en una área y instanciar escenas. Se les veía muy motivados haciendo el nivel y todos hicieron el suyo.

Pregunté que motor les gustó más y la mayoría dijo que Godot. Para un taller creo que es lo mejor, en 10 minutos ya los tenía a todos preparados, habiendo tenido que descargar el motor y la plantilla. Con Unity tardé más, incluso cuando ya estaba instalado y configurado en los portátiles, pero si a uno ya no se le iniciaba sesión bien, ya se retrasaba todo bastante.

Aunque este año ha ido mejor, aún hay varios puntos de mejora. Creo que esta es la última vez que hago el taller, mi Last Dance. Me he cambiado de trabajo y el horario es más estricto, esta vez me he cogido vacaciones estos cuatro días. Estos talleres me gustan mucho pero no se si merece la pena perder estos días de vacaciones.

Igualmente si tuviera que sacar conclusiones diría lo siguiente. Creo que estaría bien hacerlo todo con Godot, con dos proyectos igual pero que sepan donde está cada cosa durante los cuatro días. Creo que haría el mismo Flappy Bird pero en Godot. En cuanto al plataformas creo que el último día daría un proyecto con muchas más mecánicas y que no se agobien con la programación, que ellos solo tengan que arrastrar objetos y hacer el nivel, así daría tiempo a que jueguen entre ellos la última hora.

Estoy muy contento como han pasado estos cuatro días y me lo he pasado. Parece que la organización también estan contentos cuando vieron el último día lo que habían hecho. Yo me he llevado un poco más de aprendizaje sobre enseñar y tratar con jóvenes adolescentes. Creo que lo más importante en estas edades es inculcar el esfuerzo, creatividad y poder crear cosas de las que estén orgullosos, sean videojuegos, dibujos, música, lo que sea.

Lo dejo por aquí, ha sido algo extenso, pero quería comentar un poco como lo había organizado. Nos vemos en el próximo post!

Pon esto donde mejor cuadre con el shortcode: https://github.com/christt105/CITMGameWorkshop