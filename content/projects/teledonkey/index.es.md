---
showTranslations: false
title: "TeleDonkey"
image: cover.webp
description: "Bot de Telegram para añadir enlaces ed2k/magnet/torrent a un mlDonkey remoto y consultar las descargas."
tags: ["herramienta", "python", "telegram", "docker"]
filters: ["python", "tool"]
repo: "christt105/teledonkey"
docker: "christt105/teledonkey"
githubDownload: false
page: "https://hub.docker.com/r/christt105/teledonkey"
weight: 170
---

`teledonkey` es un bot de Telegram self-hosted que controla una instancia remota de [mlDonkey](https://github.com/ygrek/mldonkey) desde el móvil, sin exponer su interfaz web.

Características principales:

- Envía un enlace `ed2k://`, `magnet:` o `.torrent` y se añade a la cola de descargas.
- Consulta las descargas activas con barras de progreso, además de comandos para pausar, reanudar y cancelar.
- Se comunica con mlDonkey por su consola telnet y se ejecuta en su propio contenedor Docker, independiente de mlDonkey.
- Restringido a tu ID de Telegram y te avisa cuando se inicia.
