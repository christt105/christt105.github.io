---
showTranslations: false
title: "mnamer Telegram Bot"
image: cover.png
description: "Automatiza el renombrado con mnamer mediante un bot de Telegram para instalaciones de Jellyfin."
tags: ["herramienta", "c#", "telegram", "jellyfin", "docker"]
filters: ["tool"]
repo: "christt105/mnamer-telegram"
docker: "christt105/mnamer-telegram"
githubDownload: false
page: "https://hub.docker.com/r/christt105/mnamer-telegram"
weight: 160
---

`mnamer-telegram` es un bot de Telegram para self-hosting que automatiza el renombrado y el movimiento de contenido descargado a la biblioteca de Jellyfin usando `mnamer`.

Características principales:

- Detecta archivos nuevos con un watcher y calcula nombres propuestos con `mnamer`.
- Envía el resultado por Telegram con sugerencias de renombre y enlaces a TMDB / TheTVDB.
- Acepta o corrige la propuesta mediante respuestas/ID y mueve el archivo sólo tras confirmación.

La idea principal es transformar un flujo manual de línea de comandos en uno fluido y accesible desde móvil.

![Ejemplo](./example.png)
