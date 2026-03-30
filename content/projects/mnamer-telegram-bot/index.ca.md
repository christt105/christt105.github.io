---
showTranslations: false
title: "mnamer Telegram Bot"
image: cover.png
description: "Automatitza mnamer amb un bot de Telegram per a projectes Jellyfin en self-hosting."
tags: ["eina", "c#", "telegram", "jellyfin", "docker"]
filters: ["tool"]
repo: "christt105/mnamer-telegram"
docker: "christt105/mnamer-telegram"
githubDownload: false
page: "https://hub.docker.com/r/christt105/mnamer-telegram"
weight: 160
---

`mnamer-telegram` és un bot de Telegram per a self-hosting que automatitza el renom dels fitxers i el seu trasllat a la biblioteca Jellyfin amb `mnamer`.

Característiques principals:

- Vigila fitxers nous amb un watcher i genera propostes de nom amb `mnamer`.
- Envia missatges per Telegram amb suggeriments i enllaços a TMDB / TheTVDB.
- Permet acceptar o corregir la proposta mitjançant respostes/ID, i mou el fitxer només quan es confirma.

El flux principal converteix una gestió manual de línia de comandes en una experiència més àgil i accessible des de mòbil.

![Exemple](./example.png)
