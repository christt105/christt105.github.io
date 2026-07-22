---
showTranslations: false
title: "Cinegram"
image: cover.webp
description: "Plataforma self-hosted para conectar Jellyfin con Telegram: descarga, renombrado automático y copia de seguridad de medios."
tags: ["herramienta", "python", "c#", "telegram", "jellyfin", "docker", "vue"]
filters: ["tool", "docker", "python", "c#"]
repo: "christt105/cinegram"
docker: "christt105/cinegram-bot-net"
githubDownload: false
page: "https://hub.docker.com/r/christt105/cinegram-bot-net"
weight: 180
---

`Cinegram` es una plataforma self-hosted que actúa de puente entre una biblioteca multimedia de [Jellyfin](https://jellyfin.org/) y [Telegram](https://telegram.org/). Automatiza la descarga de películas y series desde Telegram a Jellyfin y permite hacer copias de seguridad de los medios hacia Telegram.

Características principales:

- **Transferencia bidireccional**: Descarga medios desde Telegram a tu biblioteca o realiza respaldos de tu servidor hacia Telegram.
- **Manejo de archivos grandes (> 2 GB)**: Supera el límite de subida de los bots dividiendo automáticamente los archivos grandes en partes de 1.95 GB (`7z`) y reuniéndolos al descargar.
- **Organización y metadatos TMDB**: Estandariza automáticamente nombres de archivos y carpetas para Jellyfin descargando carátulas e información desde TMDB.
- **Panel Web y Bot de Telegram**: Panel de control intuitivo en Vue 3 y bot interactivo con comandos (`/add`, `/import`, `/search`, `/queue`).

Se despliega de forma sencilla en segundos mediante Docker Compose.

![Vista previa](./preview.png)
