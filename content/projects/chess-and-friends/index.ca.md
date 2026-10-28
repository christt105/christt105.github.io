---
showTranslations: false
title: "Chess & Friends"
image: cover.webp
banner: banner.webp
description: "Web que registra la precisió i els resultats de les meves partides de chess.com contra els meus germans, amb l'API pública de chess.com."
tags: ["eina", "javascript", "chess", "api"]
filters: ["tool", "web"]
repo: "christt105/chess-and-friends"
githubDownload: false
page: "https://christt105.github.io/chess-and-friends/"
weight: 210
---

`Chess & Friends` és una web petita que registra la precisió i els resultats de les partides de chess.com que jugo contra els meus germans i mostra com evolucionen amb el temps. Ho treu tot de l'API pública de chess.com, sense API key i sense anàlisi local amb motor.

Característiques principals:

- **Vista individual**: L'evolució de la meva precisió i els meus números en solitari.
- **Vista d'amics**: Una comparació entre tots els del grup, amb una taula cara a cara.
- **Dades automàtiques**: Un script de Node descarrega les partides de l'API i les desa en un `games.json`, i els mesos tancats es cacheen per demanar només l'actual.
- **Zero manteniment**: Una pàgina estàtica sense pas de build ni frameworks, que s'actualitza sola per no haver-la de tocar.

Va començar com una broma per portar el compte de les pallisses que em fan els meus germans. Explico tota la història al [post del blog](/ca/blog/chess-and-friends/).

![La vista d'amics del dashboard de Chess & Friends](./preview.webp)
