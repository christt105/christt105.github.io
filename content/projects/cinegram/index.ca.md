---
showTranslations: false
title: "Cinegram"
image: cover.webp
description: "Plataforma self-hosted per a connectar Jellyfin amb Telegram: descàrrega, reanomenat automàtic i còpia de seguretat de mitjans."
tags: ["eina", "python", "c#", "telegram", "jellyfin", "docker", "vue"]
filters: ["tool", "docker", "python", "c#"]
repo: "christt105/cinegram"
docker: "christt105/cinegram-bot-net"
githubDownload: false
page: "https://hub.docker.com/r/christt105/cinegram-bot-net"
weight: 180
---

`Cinegram` és una plataforma self-hosted que actua de pont entre una biblioteca multimèdia de [Jellyfin](https://jellyfin.org/) i [Telegram](https://telegram.org/). Automatitza la descàrrega de pel·lícules i sèries des de Telegram cap a Jellyfin i permet fer còpies de seguretat dels mitjans cap a Telegram.

Característiques principals:

- **Transferència bidireccional**: Descarrega mitjans des de Telegram a la teva biblioteca o realitza còpies de seguretat del teu servidor cap a Telegram.
- **Gestió de fitxers grans (> 2 GB)**: Supera el límit de pujada dels bots dividint automàticament els fitxers grans en parts de 1.95 GB (`7z`) i reunint-los en descarregar.
- **Organització i metadades TMDB**: Estandarditza automàticament noms de fitxers i carpetes per a Jellyfin descarregant caràtules i informació des de TMDB.
- **Tauler Web i Bot de Telegram**: Tauler de control intuïtiu en Vue 3 i bot interactiu amb ordres (`/add`, `/import`, `/search`, `/queue`).

Es desplega de manera senzilla en segons mitjançant Docker Compose.

![Vista prèvia](./preview.png)
