---
showTranslations: false
title: "TeleDonkey"
image: cover.png
description: "Telegram bot to add ed2k/magnet/torrent links to a remote mlDonkey and check downloads."
tags: ["tool", "python", "telegram", "docker"]
filters: ["python", "tool"]
repo: "christt105/teledonkey"
docker: "christt105/teledonkey"
githubDownload: false
page: "https://hub.docker.com/r/christt105/teledonkey"
weight: 170
---

`teledonkey` is a self-hosted Telegram bot that drives a remote [mlDonkey](https://github.com/ygrek/mldonkey) instance from your phone, without exposing its web UI.

Key features:

- Send an `ed2k://`, `magnet:` or `.torrent` link and it is queued for download.
- Inspect active downloads with progress bars, plus pause, resume and cancel commands.
- Talks to mlDonkey over its telnet console and runs as its own Docker container, independent from mlDonkey.
- Restricted to your Telegram user ID and sends a notification when it comes online.
