---
showTranslations: false
title: "TeleDonkey"
image: cover.png
description: "Bot de Telegram per afegir enllaços ed2k/magnet/torrent a un mlDonkey remot i consultar les descàrregues."
tags: ["eina", "python", "telegram", "docker"]
filters: ["python", "tool"]
repo: "christt105/teledonkey"
docker: "christt105/teledonkey"
githubDownload: false
page: "https://hub.docker.com/r/christt105/teledonkey"
weight: 170
---

`teledonkey` és un bot de Telegram self-hosted que controla una instància remota de [mlDonkey](https://github.com/ygrek/mldonkey) des del mòbil, sense exposar-ne la interfície web.

Característiques principals:

- Envia un enllaç `ed2k://`, `magnet:` o `.torrent` i s'afegeix a la cua de descàrregues.
- Consulta les descàrregues actives amb barres de progrés, a més d'ordres per pausar, reprendre i cancel·lar.
- Es comunica amb mlDonkey per la seva consola telnet i s'executa en el seu propi contenidor Docker, independent de mlDonkey.
- Restringit al teu ID de Telegram i t'avisa quan s'inicia.
