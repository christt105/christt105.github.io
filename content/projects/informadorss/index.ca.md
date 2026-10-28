---
showTranslations: false
title: "InformadoRSS"
image: cover.webp
banner: banner.png
description: "Reenviador lleuger i self-hosted de RSS/Atom a Discord en un sol contenidor, un reemplaçament petit de MonitoRSS."
tags: ["eina", "c#", "vue", "rss", "discord", "ntfy", "sqlite", "docker"]
filters: ["tool", "docker", "c#"]
repo: "christt105/InformadoRSS"
githubDownload: false
page: "https://github.com/christt105/InformadoRSS"
weight: 190
---

`InformadoRSS` és un servei lleuger i self-hosted que vigila feeds RSS i Atom, filtra els seus elements per ruta i els lliura a canals de Discord o a [ntfy](https://ntfy.sh/). Funciona en un únic contenidor: un binari en C# amb .NET 10 compilat amb NativeAOT que serveix una interfície web en Vue 3 i ho guarda tot a SQLite. Només parla amb Discord a través de l'API REST del bot (sense gateway ni comandes). És de codi obert amb llicència MIT.

Característiques principals:

- **Feeds i rutes**: Un feed és una URL; cada feed té rutes amb un filtre, un o diversos destins (Discord o ntfy) i una plantilla de missatge.
- **Constructor de filtres i editor de plantilles**: Crea els filtres i edita els missatges des de la interfície web en lloc d'escriure'ls a mà.
- **Selector de servidor i canal de Discord**: Tria els destins pel nom i comprova en quins canals no pot publicar el bot.
- **Alertes**: Un avís quan un feed o un destí es trenca i un altre quan es recupera, per Discord o ntfy.
- **Còpies de seguretat diàries**: Còpies programades de la base de dades en una carpeta, conservant les més recents.
- **Importador de MonitoRSS**: Importa feeds i rutes des d'una exportació de MonitoRSS, amb simulació i un canal de proves per comparar els missatges abans de canviar.
- **Patró d'identitat per a feeds que reescriuen entrades**: Una expressió regular sobre la descripció que s'afegeix a l'id de l'element, així un canvi d'estat en una llista de MyAnimeList compta com a element nou.

Explico com i per què el vaig fer en [el post del blog](/ca/blog/informadorss/). La imatge es publica a `ghcr.io/christt105/informadorss`.

![L'editor de rutes: filtre, plantilla del missatge i canal de destí](./web-route.webp)
