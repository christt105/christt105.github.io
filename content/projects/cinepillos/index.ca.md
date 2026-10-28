---
showTranslations: false
title: "Cinepillos"
image: cover.webp
banner: banner.webp
description: "Web de codi obert per decidir quina pel·lícula veure amb amics: suggeriments compartits, sessions programades i votacions."
tags: ["eina", "nextjs", "typescript", "prisma", "postgresql", "tmdb"]
filters: ["tool", "docker", "web"]
repo: "christt105/cinepillos"
githubDownload: false
page: "https://cinepillos.vercel.app"
weight: 200
---

`Cinepillos` (abans "Club de Cine") és una web de codi obert per organitzar nits de cinema amb amics. Un grup manté un tauler compartit de pel·lícules suggerides, programa una sessió i vota quina d'elles veure.

Característiques principals:

- **Tauler de suggeriments compartit**: Qualsevol membre pot afegir una pel·lícula cercant-la a la mateixa web, amb TMDB al darrere.
- **Sessions i votacions**: Cada sessió té data i hora, s'obre una ronda de votació entre els suggeriments i guanya la pel·lícula més votada.
- **Grups privats**: Una mateixa instància pot allotjar diversos clubs alhora, i ningú veu res d'un altre club.
- **Avatars de TMDB i TVDB**: Tria un pòster de pel·lícula o una foto d'un personatge com a avatar.
- **Stack i hosting**: Next.js, Prisma i Postgres, desplegat a Vercel amb Neon, amb inici de sessió de Google. També es pot allotjar un mateix amb Docker Compose.

Es publica amb llicència AGPL-3.0. Explico com va sorgir al [post del blog](/ca/blog/cinepillos/).

![La pàgina d'inici de Cinepillos](./preview.webp)
