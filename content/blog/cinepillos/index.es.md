---
title: Cinepillos
description: Retomo otro proyecto, una web para decidir qué película ver con amigos, de código abierto.
date: 2026-08-18
image: cover.png
keywords:
  - Cinepillos
  - Next.js
  - Prisma
  - Vercel
  - Neon
  - TMDB
  - Open Source
readingTime: true
comments: true
draft: false
categories:
  - Self-hosting
  - Programación
tags:
  - nextjs
  - typescript
  - prisma
  - postgresql
  - vercel
  - neon
  - docker
---
¡Hola de nuevo!

Sigo acabando los proyectos que tengo empezados, y hoy le toca a Cinepillos. Lo empecé hace ya unos meses, allá por enero, como "Club de Cine", una web para llevar un tablero de propuestas de películas con un grupo de amigos, programar una sesión y votar cuál de las propuestas se ve. Sinceramente, nunca he llegado a necesitarlo de verdad, difícilmente veo yo películas, como para verlas con otros, pero me hacía gracia tener un sitio para eso. Dudo que lo llegue a usar nunca en serio, pero bueno, a ver si le sirve a alguien.

## De dónde viene el nombre
Mi perro tiene un muñeco al que llamamos "zorropillo", y de juntar eso con "cine" salió Cinepillos. Así que el rebrand de "Club de Cine" no tiene mucha más ciencia que esa.

## De autoalojado a Vercel y Neon
Era la única web que tenía autoalojada en mi mini PC de todos mis proyectos, mediante túneles de Cloudflare, y esta vez quería probar alternativas en vez de meterla en mi servidor, que te empieza a ahogar. Así que decidí montarla sobre [Vercel](https://vercel.com) para el despliegue y [Neon](https://neon.tech) como Postgres gestionado. Nada en el mini PC, nada de discos que mantener, cada push a la rama principal se despliega solo. La verdad que ambas plataformas ofrecen unos límites gratuitos muy anchos, de sobra para este proyecto.

Eso sí, para quien prefiera tenerlo en su propio servidor, sigue siendo perfectamente autoalojable con Docker Compose, luego vamos a eso.

## Sobre monetizarla
Le he dado vueltas a intentar sacar algo de dinero con este proyecto, por aprovechar un poco el tiempo que le dedico a todo esto, tampoco espero hacerme turbomillonario. Pero al final lo descarté. Ni la idea de monetización que tenía en la cabeza era buena, ni me compensaba meterme en líos con las condiciones de uso de TMDB y TVDB, las dos bases de datos de las que tira la web, que no permiten un uso comercial así como así. Así que Cinepillos se queda gratis y de código abierto, como el resto de mis proyectos, y yo: pobre. Me falta mentalidad de tiburón. Viva el open source.

## Cómo funciona
La idea es simple. Un grupo lleva un tablero compartido de propuestas de películas, cualquier miembro puede añadir una buscándola directamente en la web. Cuando hay ganas de quedar, se programa una sesión con fecha y hora, se abre la votación entre las propuestas y cada uno vota la que quiere ver. Cuando se cierra la votación, gana la más votada y queda registrada como la sesión de ese día.

Una misma instancia puede tener varios clubs a la vez y cada uno es completamente privado, nadie de un club ve nada de otro. El login es con Google, y en `/settings` cada uno puede elegirse un avatar sacado de un póster de TMDB o de una foto de personaje de TVDB, así que hasta el avatar tira de las mismas bases de datos que el resto de la web.

![Página principal con la próxima sesión y las propuestas del club](home.png)
![Buscador de películas tirando de TMDB, con filtros por género](search.png)

## Trabajando con la IA
Con Claude he seguido el mismo flujo que en otros proyectos, pero esta vez con un añadido que me ha gustado bastante. Cada vez que abro una PR, Vercel despliega una preview y Neon le clona una copia de la base de datos de producción para esa preview. Así las tareas quedan bien contenidas: le pido a Claude una tarea concreta, la pushea a GitHub, y cuando termina ya tengo una preview funcionando con datos reales para probar el cambio, echarle un ojo al código y, si todo va bien, mergear. Sin tener que montar nada a mano ni preocuparme de romper producción mientras pruebo.

## Código abierto y gratis
Como siempre, todo el código está en GitHub para quien quiera usarlo, tocarlo o mejorarlo. Cinepillos es gratis y lo tenéis ya en [cinepillos.vercel.app](https://cinepillos.vercel.app), el login es solo con Google porque era lo más simple para mí, pero al ser de código abierto cualquiera puede levantar su propia instancia con Docker Compose y sus propias claves de TMDB y TVDB si le encaja mejor.

{{< github-repo-card owner="christt105" repo="cinepillos" >}}

Y hasta aquí el post de hoy. Si probáis Cinepillos o el código, ya sabéis dónde dejarme un comentario.

¡Hasta la próxima!
