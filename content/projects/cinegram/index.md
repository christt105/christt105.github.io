---
showTranslations: false
title: "Cinegram"
image: cover.webp
description: "Self-hosted platform to bridge Jellyfin with Telegram: download, automatic renaming, and media backups."
tags: ["tool", "python", "c#", "telegram", "jellyfin", "docker", "vue"]
filters: ["tool", "docker", "python", "c#"]
repo: "christt105/cinegram"
docker: "christt105/cinegram-bot-net"
githubDownload: false
page: "https://hub.docker.com/r/christt105/cinegram-bot-net"
weight: 180
---

`Cinegram` is a self-hosted platform that acts as a bridge between a [Jellyfin](https://jellyfin.org/) media library and [Telegram](https://telegram.org/). It automates downloading movies and series from Telegram into Jellyfin and enables backing up existing media from Jellyfin to Telegram.

Key features:

- **Bidirectional Transfer**: Download media from Telegram into your library or back up your server media to Telegram.
- **Large File Handling (> 2 GB)**: Circumvents Telegram bot upload limits by automatically splitting large files into 1.95 GB (`7z`) archives and rejoining them upon download.
- **TMDB Organization & Metadata**: Automatically standardizes file and folder names for Jellyfin while downloading covers and metadata from TMDB.
- **Web Dashboard & Telegram Bot**: Intuitive Vue 3 web panel and interactive bot with commands (`/add`, `/import`, `/search`, `/queue`).

Easily deployed in seconds using Docker Compose.

![Preview](./preview.png)
