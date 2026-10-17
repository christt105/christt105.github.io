---
title: Mi relación con las llagas y el vibecoding
description: Cómo en cinco minutos y con una IA me hice una web para llevar el registro de mis llagas en la boca, con fotos de Immich y un mapa de la boca, sin revisar una sola línea de código, y por qué eso me parece perfectamente bien.
date: 2026-10-16
image: cover.png
keywords:
  - vibecoding
  - ia
  - claude
  - llagas
  - immich
  - self-hosting
  - pwa
  - proyectos personales
  - salud
readingTime: true
comments: true
categories:
  - Programación
tags:
  - vibecoding
  - ia
  - claude
  - immich
  - self-hosting
  - open source
---

Hola de nuevo. Hoy toca un post un poco distinto. No voy a hablar de uno de esos proyectos a los que les tengo cariño y que cuido línea a línea, sino de todo lo contrario: una web que hice en cinco minutos, que no he revisado absolutamente nada, y que me parece perfecto que sea así.

Se llama **Llagas**, sirve para llevar el registro de las llagas que me salen en la boca, y es mi excusa para hablar de cómo convivo con el *vibecoding*.

{{< github-repo-card owner="christt105" repo="llagas" >}}

![La pantalla de inicio y las estadísticas de Llagas, con datos de demostración](cover.webp)

## El problema

Soy de los que tienen llagas en la boca con bastante frecuencia. Nada grave, pero lo suficiente como para querer saber cuándo me salen, cuánto duran, dónde, si fue por morderme o por estrés, y qué me fue bien para curarlas. Momento frikada para que un médico te mire con algo de miedo.

## Lo que ya tenía en Obsidian

No partía de cero. Llevaba tiempo apuntándolas en Notion. Luego pasaron a mi vault de Obsidian, una nota por llaga con unas cuantas propiedades:

```yaml
---
type: llaga
fecha_aparicion: 2026-06-19
fecha_desaparicion: 2026-07-03
ubicacion: Paladar
dolor:
causa_sospechada:
tratamiento:
---
```

Y funcionaba. Con una vista de Bases tenía una tabla de todas ellas, y poco más. Pero se me quedaba corto en cosas muy concretas:

- Apuntar una llaga nueva desde el móvil era más fricción de la que quería. Si tengo que abrir Obsidian, crear la nota, rellenar las propiedades... acabo dejándolo para luego, y luego es nunca.
- La ubicación era un texto libre. "Labio inferior", "labio de abajo", "lbio inf". Imposible sacar estadísticas decentes.
- Las fotos. Hacerle una foto a una llaga para ver cómo evoluciona es útil, pero las fotos ya viven en mi [Immich](https://immich.app/), y no quería duplicarlas dentro del vault.
- Quería **ver dónde** me salen. No una lista de nombres, sino un dibujo de la boca con los puntos marcados.

Podía haber hecho un plugin de Obsidian o haberme currado más las plantillas, pero para lo que quería, que era algo exclusivo para este tema con exactamente las herramientas que se me ocurrían, me pedía algo propio.

## La solución: pedírselo a Claude

Así que me senté con Claude, le conté lo que quería y le fui pidiendo cosas. Y en unos cinco minutos tenía una primera versión funcionando. Directamente desde el móvil le pedí todo y como vive en mi servidor casero, me lo hizo en nada. Lo he ido puliendo después, pero lo importante estaba ahí desde el principio:

- **Alta rápida desde el móvil**, como PWA instalable. Un botón y listo.
- **Un mapa de la boca**. Dibujo de una boca abierta y la ubicación se elige tocando donde está la llaga. El texto de la ubicación se rellena solo.
- **Fotos de Immich**. La web solo guarda los identificadores de las fotos, no las copia. Al editar una llaga me enseña las fotos que hice los días que duró, las selecciono y se añaden a un álbum de Immich. También puedo hacer una foto desde la propia web.
- **Estadísticas**: cuántas llevo al año, duración media, la más larga, cada cuánto me salen, en qué zonas, y un mapa con todas ellas.

![Elegir la ubicación tocando el dibujo de la boca, y el mapa con todas las llagas del historial](mapa.webp)

Todas las imágenes están hechas con datos de demostración generados, estoy mal pero puedo vivir bien.

Las fotos de Immich funcionan igual: elijo el rango de días y la web me enseña las fotos de ese periodo para enlazarlas.

![Selector de fotos de Immich y el historial agrupado por meses (las fotos de la captura son de relleno)](immich.webp)

Después migré todas las llagas que tenía en Obsidian a la nueva base de datos con un script de importación, y de paso busca las fotos que ya tenía enlazadas en las notas y las vincula.

## No he revisado nada de código

Y aquí viene lo que me interesa contar de verdad: **no he mirado el código**. Ni una línea. No sé cómo está estructurado, no sé si hay algo raro, y no me importa.

Esto, que en cualquiera de mis otros proyectos sería una herejía, aquí tiene todo el sentido por varias razones:

- **Es un proyecto simple.** Una web para mí, en mi red local, sin cuentas ni usuarios que no sea yo. Si se rompe, lo peor que pasa es que no puedo apuntar una llaga durante un rato.
- **El riesgo es mínimo.** No toca nada importante. Solo guarda unas fechas y unos identificadores de fotos.
- **Se prueba solo con usarlo.** Si funciona cuando la uso, funciona. Si algo falla, lo noto en el momento y se lo cuento a Claude.
- **Su objetivo es hacerme la vida más fácil**, no ser perfecto. No todos los proyectos tienen que serlo.

Y hay un punto que me parece todavía más importante: **sin la IA ni me lo habría planteado**. Habría tardado muchísimo más, habría tenido que aprender cosas que no me interesan para algo tan pequeño, y lo más probable es que hubiera seguido con la nota de Obsidian. El vibecoding aquí no ha sustituido a un proyecto que habría hecho yo, ha hecho posible uno que no habría existido.

## El otro lado: los proyectos que sí me importan

No quiero que esto se lea como un "dejadlo todo en manos de la IA", porque mi relación con ella es **completamente distinta según el proyecto**.

Tengo otros proyectos que son más importantes y a los que les tengo muchísimo cariño como [Elit3D](/es/projects/elit3d/) o [Godosters](/es/projects/godosters/). Con esos voy muchísimo más lento. También me ayudo de la IA, pero reviso cada línea, no dejo que se vaya de madre, decido yo cómo se organiza el código y qué se acepta y qué no. Si tengo que elegir entre ir rápido o entenderlo todo, ahí elijo entenderlo todo.

Creo que parte de "convivir con el vibecoding" es eso: saber cuándo dejarte llevar y cuándo no. Lo que me parecería un error es aplicar el mismo criterio a todo, en cualquiera de los dos sentidos. Revisar cada línea de Llagas sería perder el tiempo, y no revisar nada de Elit3D sería una irresponsabilidad.

## Cómo está desplegado

Ya que es un proyecto tan cómodo de tocar, lo he publicado también como imagen de Docker en GitHub, y lo tengo en mi home server junto al resto de servicios. La configuración básica es un `docker-compose` con la dirección de mi Immich y una clave de API:

```yaml
services:
  llagas:
    image: ghcr.io/christt105/llagas:${LLAGAS_TAG:-latest}
    restart: unless-stopped
    ports:
      - "8097:8080"
    environment:
      TZ: Europe/Madrid
      IMMICH_URL: http://immich.lan:2283
    env_file: .env
    volumes:
      - ./data:/data
```

No tiene autenticación, porque está pensada para mi red local (y para Tailscale cuando estoy fuera de casa). Es justo el tipo de decisión que se puede tomar a la ligera en un proyecto así y que jamás tomaría en uno que sirva datos de otras personas.

## Conclusión

Llagas no es un proyecto que vaya a enseñar en una entrevista, ni quiero. Es una herramienta pequeña que me resuelve un problema pequeño y la he hecho en cinco minutos.

Si algo me llevo de esto es que el vibecoding no tiene por qué ser una etiqueta para decir "mi código es malo" ni una bandera para decir "ya no hace falta saber programar". Es una herramienta más, y lo importante es elegir bien dónde usarla. Para las cosas que me importan, sigo yendo despacio y mirándolo todo. Para las que simplemente quiero que existan, me dejo llevar.

La IA ha llegado para quedarse, nos gusta o no, ahora cada uno que la use como más le apetezca.

Si te pasa lo mismo que a mí y quieres tenerlo en tu servidor, el código está en [GitHub](https://github.com/christt105/llagas) con instrucciones. Eso sí, bajo tu propio riesgo, que yo tampoco lo he leído jeje.

¡Hasta el siguiente post!
