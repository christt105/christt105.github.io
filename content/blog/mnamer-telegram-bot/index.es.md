---
title: "mnamer-telegram-bot"
description: "Descripción pendiente..."
date: 2026-03-27
image: cover.png
keywords:
readingTime: true
comments: true
draft: true
categories:
  - 
tags:
  - 
---
Hola de nuevo!

Esta vez os traigo un proyecto que llevaba meses parado. Estoy intentando completar mi lista de proyectos pausados para darme un poco de paz. Seguimos con el tema del self-hosting, esta vez con un bot de Telegram.

## Problema
La idea vino cuando empecé a usar en el mini pc el descargador p2p vulgarmente llamado "la mula". Cuando una descarga acababa no tenía forma de saber cuando y tenía que ir manualmente, crear la carpeta con el nombre correcto en mi librería de Jellyfin y pegar el archivo ahí cambiándole el nombre. Como principiante en esto de automatizar cosas era algo que no me podía permitir.

## Preludio
Al poco tiempo probé [tinyMediaManager](https://www.tinymediamanager.org/), en Docker pero era prácticamente inusable desde el teléfono móvil que es mi dispositivo habitual para manejar eso.

Poco después busqué otras opciones y encontré [mnamer](https://github.com/jkwill87/mnamer), un programa por consola que renombra películas y series. Era exactamente lo que buscaba. Usa TMDB para las películas y theTVDB para las series (que lo prefiero porque tiene mejores reglas para algunos animes). Con unos comandos puedes hacer que lea todos los archivos de video de una carpeta y los renombra y coloca en las carpetas pertinentes de tu biblioteca.

Estuve usando mnamer un tiempo, cuando algo acababa de descargar, abría la consola de comandos por ssh y ejecutaba un alias que me creé.

```bash
# Ruta al docker-compose de mnamer
export MNAMER_COMPOSE="/home/christian/Server/70-79_Media/74_gestion_media/mnamer/docker-compose.yml"

# Ejecutar mnamer genérico
alias mnamer="docker compose -f $MNAMER_COMPOSE run --rm mnamer"

# Ejecutar en modo prueba (no mueve nada, solo muestra)
alias mnamer-test="docker compose -f $MNAMER_COMPOSE run --rm mnamer --test -r /data/Descargas"

# Ejecutar en modo real (mueve de Descargas a destino)
alias mnamer-run='docker compose -f $MNAMER_COMPOSE run --rm mnamer -r /data/Descargas'

alias mnamer-tmdb='docker compose -f $MNAMER_COMPOSE run --rm mnamer -r /data/Descargas --id-tmdb'

alias mnamer-tvdb='docker compose -f $MNAMER_COMPOSE run --rm mnamer -r /data/Descargas --id-tvdb'
```

Tenía mnamer en un contenedor docker y creé algunos comandos para hacerlo funcionar sin tener que escribir gran cosa. con `mnamer-test` podía comprobar que todo se iba a renombrar correctamente. Si algo no lo pillaba bien, ejecutaba `mnamer-tmdb` o `mnamer-tvdb` y le pasaba el id que buscaba en el navegador. Si todo estaba bien simplemente ejecutaba `mnamer-run --batch` para que lo hiciera todo del tirón. Como podéis comprobar, seguía siendo bastante manual, había mucho margen de mejora.

Unos meses antes estuve trasteando con los bots de Telegram. Intenté crear uno con python pero me acabé agobiando y pasé a C# usando [WTelegramBot](https://github.com/wiz0u/WTelegramBot), una API exquisita para crear bots con muchísimas funcionalidades y en un lenguaje con el que me sentía más a gusto. Ese bot está en pausa, otro proyecto más en la lista interminable.

## La travesía del bot
Con las ideas claras, a finales del año pasado estuve trabajando unos días en el bot. La idea principal era que cada vez que hubiera un archivo en una carpeta, el bot enviara un mensaje con la propuesta de mnamer y un link a tmdb o thetvdb para poder comprobar que era correcto. Una vez hecha la comprobación, pulsar un botón y que se enviara a la biblioteca.

Hice algo muy básico para comprobar si había archivos y enviar un mensaje con la propuesta de mnamer y un botón para aceptar. Si mnamer estaba equivocado, debía ir manualmente al disco duro, cambiarle el nombre y volver a probar, cosa que no solia pasar pero era realmente molesto.

Estuve unos meses así hasta que en febrero decidí continuar. Añadí el File Watcher y que pudieras contestar con un id para rectificar. También intenté arreglar tema de permisos de los archivos y ahora el contenedor se ejecuta con el usuario 1000:1000 por defecto, aunque a mí me funciona, creo que no está del todo bien implementado.

Lo volví a dejar porque me iba bastante bien, hasta hace pocos días que me puse a arreglar un par de cosas y a crear toda la documentación para que otra gente lo pudiera probar. Configuré que GitHub Actions generara una imagen docker cada vez que creara una tag e hice el repositorio público.

Y así está el estado actual. Imagino que iré mejorándolo poco a poco si la gente lo usa, como acaba de pasar hace nada que un amigo me ha enviado una PR arreglando los Ids de los usuarios, es la parte más reconfortante de la programación. Creo que es algo complejo de configurar, pero hasta que más gente no lo intente no sé cómo hacerlo mejor.

![Ejemplo del bot renombrando](example.png)

Si te interesa el código fuente del proyecto o las instrucciones para instalarlo, lo puedes encontrar en mi cuenta de GitHub:

{{< github-repo-card owner="christt105" repo="mnamer-telegram" >}}
## Conclusión
Es la primera vez que hago un programa con C# directamente, mi experiencia con C# suele ser casi siempre dentro del entorno de Unity. Se que hay muchas cosas mal y mejorables, pero estoy disfrutando aprendiendo nuevas formas de programar.

Otro proyecto bastante reducido que puedo tachar de mi lista de pendientes y pasar a otra cosa. Si tienes un setup parecido y quieres probar el bot te animo a que lo hagas y dejar una estrella en [el repositorio.](https://github.com/christt105/mnamer-telegram) 

Nos vemos en el siguiente post!