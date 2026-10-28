---
showTranslations: false
title: "Simpromana"
image: cover.webp
banner: banner.webp
description: "Plugin d'Obsidian per gestionar projectes: graf de tasques, tauler kanban i panell de projecte dins del teu vault."
tags: ["eina", "obsidian", "typescript", "kanban"]
filters: ["tool"]
repo: "christt105/obsidian-simpromana-plugin"
githubDownload: true
page: "https://community.obsidian.md/plugins/simpromana"
weight: 230
---

`Simpromana` és un plugin d'[Obsidian](https://obsidian.md/) per gestionar projectes i tasques. Manté connectades les notes de `Projects`, `Tasks` i `Reference` mitjançant frontmatter, de manera que tot viu al teu vault en lloc d'un servei extern. És de codi obert amb llicència MIT i està disponible als plugins de la comunitat d'Obsidian.

Característiques principals:

- **Vista de flux**: Un graf de tasques i les seves relacions (`blocked_by`, `continues`, `related`), agrupat i col·locat automàticament.
- **Vista de tauler**: Un tauler kanban (Todo/Doing/Review/Done) amb canvis d'estat arrossegant i un filtre opcional per projecte.
- **Panell de projecte**: Un panell lateral que llista les tasques d'un projecte per estat, amb creació ràpida de tasques.
- **Comandes**: *New project*, *New task*, *New reference* i *Archive current task*, cadascuna amb el frontmatter correcte.
- **Integració amb Bases**: Funciona juntament amb el plugin central Bases d'Obsidian, amb vistes `Tasks.base` i `References.base` incrustades a les notes de projecte.

Els camps de frontmatter i les convencions de carpetes són opinats, pensats per com organitzo el meu propi vault, però els noms i els estats es poden configurar als ajustos.

![El tauler kanban de Simpromana](./preview.webp)
