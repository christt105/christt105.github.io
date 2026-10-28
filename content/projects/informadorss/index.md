---
showTranslations: false
title: "InformadoRSS"
image: cover.webp
banner: banner.png
description: "Lightweight self-hosted RSS/Atom to Discord forwarder in a single container, a small replacement for MonitoRSS."
tags: ["tool", "c#", "vue", "rss", "discord", "ntfy", "sqlite", "docker"]
filters: ["tool", "docker", "c#"]
repo: "christt105/InformadoRSS"
githubDownload: false
page: "https://github.com/christt105/InformadoRSS"
weight: 190
---

`InformadoRSS` is a lightweight, self-hosted service that watches RSS and Atom feeds, filters their items per route and delivers them to Discord channels or [ntfy](https://ntfy.sh/). It runs as a single container: a C# .NET 10 binary compiled with NativeAOT that serves a Vue 3 web UI and keeps everything in SQLite. It talks to Discord only through the bot REST API (no gateway, no bot commands). It is open source under the MIT license.

Key features:

- **Feeds and routes**: A feed is a URL; each feed has routes with a filter, one or more destinations (Discord or ntfy) and a message template.
- **Filter builder and template editor**: Build filters and edit messages from the web UI instead of writing them by hand.
- **Discord server and channel picker**: Choose destinations by name, and see which channels the bot cannot post in.
- **Alerts**: One alert when a feed or destination breaks and another when it recovers, through Discord or ntfy.
- **Daily backups**: Scheduled copies of the database to a folder, keeping the newest ones.
- **MonitoRSS importer**: Import feeds and routes from a MonitoRSS export, with a dry run and a test channel to compare messages before switching.
- **Identity pattern for feeds that rewrite entries**: A regular expression over the description that is appended to the item id, so a status change in a MyAnimeList list counts as a new item.

Read how and why I built it in [the blog post](/blog/informadorss/). The image is published to `ghcr.io/christt105/informadorss`.

![The route editor: filter, message template and destination channel](./web-route.webp)
