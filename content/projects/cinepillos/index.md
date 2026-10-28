---
showTranslations: false
title: "Cinepillos"
image: cover.webp
banner: banner.webp
description: "Open source web app for deciding which movie to watch with friends: shared suggestions, scheduled sessions and voting."
tags: ["tool", "nextjs", "typescript", "prisma", "postgresql", "tmdb"]
filters: ["tool", "docker", "web"]
repo: "christt105/cinepillos"
githubDownload: false
page: "https://cinepillos.vercel.app"
weight: 200
---

`Cinepillos` (formerly "Club de Cine") is an open source web app for organising film nights with friends. A group keeps a shared board of film suggestions, schedules a session and votes on which of the suggested films to watch.

Key features:

- **Shared suggestions board**: Any member can add a film by searching for it directly on the site, backed by TMDB.
- **Sessions and voting**: Each session has a date and time, a voting round opens between the suggestions, and the most voted film wins.
- **Private groups**: One instance can host several clubs at once, and nobody sees anything from another club.
- **Avatars from TMDB and TVDB**: Pick a movie poster or a character photo as your avatar.
- **Stack and hosting**: Next.js, Prisma and Postgres, deployed on Vercel with Neon, with Google sign-in. It can also be self-hosted with Docker Compose.

It is released under the AGPL-3.0 license. Read how it came about in [the blog post](/blog/cinepillos/).

![The Cinepillos home page](./preview.webp)
