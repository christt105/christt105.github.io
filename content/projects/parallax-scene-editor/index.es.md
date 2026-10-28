---
showTranslations: false
title: "Parallax Scene Editor"
image: cover.webp
banner: banner.webp
description: "Editor en el navegador para escenas parallax de pixel art en bucle perfecto. Sin servidor, no se sube nada."
tags: ["herramienta", "javascript", "pixel-art", "animation"]
filters: ["tool", "web"]
repo: "christt105/parallax-scene-editor"
githubDownload: false
page: "https://christt105.github.io/parallax-scene-editor/"
weight: 220
---

`Parallax Scene Editor` es un editor de escenas parallax de pixel art en bucle. Se abre en el navegador, lee una carpeta de tu propio disco llena de sprites y exporta GIF, WebM o una secuencia de PNG. No hay servidor, ni paso de build, ni se sube nada a ningún sitio. Es de código abierto con licencia MIT.

Un fondo parallax es fácil de dibujar y un incordio de montar: cada capa se mueve a su propia velocidad y todo tiene que caber en el mismo número de fotogramas para que el bucle no dé saltos. Aquí una escena es un único archivo JSON con cámara, capas, actores y keyframes, y el editor te avisa en rojo cuando algo no va a cerrar.

Características principales:

- **Trabaja sobre tu propia carpeta**: Lee los sprites de una carpeta de tu disco, y el archivo de la escena sigue al editor, guardándose solo un momento después de cada cambio.
- **Recarga en vivo de sprites**: Repinta un sprite en tu editor de pixel art, guarda, y se actualiza en el lienzo por sí solo.
- **Capas, actores y keyframes**: Las posiciones llevan keyframes y se interpolan, y editas mientras ves la escena reproducirse en bucle.
- **Comprobación del bucle**: El editor te avisa cuando el bucle no va a cerrar.
- **Exportación**: GIF, WebM o secuencia de PNG, además de una exportación en paquete para llevarte la escena a otro sitio.

Abrir carpetas con permiso de escritura necesita la File System Access API, que solo está en navegadores de escritorio basados en Chromium. En el resto se usa una copia de solo lectura.

{{< video src="bike-ride" alt="Un ciclista y un Mudkip corriendo en bucle sobre un fondo parallax de bosque, hecho con el editor" >}}

![El editor con la escena de demostración](./preview.webp)
