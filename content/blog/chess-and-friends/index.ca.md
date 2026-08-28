---
title: "Chess & Friends: una web per portar el compte de les pallisses que em donen els meus germans als escacs"
description: Com un gràfic que em va enviar la meva germana per Discord va acabar sent una web que treu dades de l'API de chess.com per fer un seguiment de les humiliacions que em fan passar els meus germans.
date: 2026-08-23
image: cover.webp
keywords:
  - escacs
  - chess.com
  - Claude
  - API
  - dashboard
readingTime: true
comments: true
draft: false
categories:
  - Chess & Friends
tags:
  - escacs
  - chess.com
  - claude
  - ia
---
Hola de nou.

Els meus germans són uns frikis dels escacs, la majoria de vegades que els veig estan jugant partides o mirant vídeos. Jo hi jugo molt de tant en tant, sempre m'ha agradat, però això, un aficionat que juga alguna partida ocasional. De tant en tant els meus germans em reten a una partida i sempre acaba igual, pallissa.

L'altre dia la meva germana em va enviar per Discord, sense venir gaire a tomb, un gràfic de precisió de les nostres últimes partides que s'havia tret no sé molt bé d'on. La veritat és que el gràfic és lamentable, va ser pitjor que perdre la partida en si. Però em va donar una idea: en lloc d'un gràfic solt, per què no alguna cosa més viva, que es anés actualitzant sola?

![](Chart.webp)

## Mans a l'obra

Chess.com té una API pública sense necessitat de clau ni de res estrany: per cada jugador pots demanar l'arxiu de partides d'un mes concret i et retorna, entre altres coses, la precisió de cada bàndol quan està disponible (des de ~2023 chess.com la calcula per a gairebé totes les partides). Amb això com a base, el pla era una web senzilla que anés a buscar les partides entre nosaltres i les pintés en un parell de gràfics.

Ho vaig plantejar a Claude tal qual, amb el que volia i poc més, i a partir d'aquí va ser qüestió d'anar iterant: un script en Node que pega a l'API i guarda un `games.json`, una web estàtica que ho llegeix i ho pinta amb Chart.js, i ja posats, que li donés un aire de tauler d'escacs en lloc de la típica web genèrica. Vam anar afinant coses pel camí: cachejar els mesos ja tancats per no repetir peticions de més, una icona diferent segons com va acabar cada partida (escac i mat, rendició, temps, taules), i una GitHub Action que s'executa cada nit per refrescar les dades sola, així que la web mai necessita que jo la toqui per estar al dia.

{{< github-repo-card owner="christt105" repo="chess-and-friends" >}}

## La web

La teniu publicada aquí: https://christt105.github.io/chess-and-friends/. Té dues vistes. La individual, amb la meva evolució de precisió i els meus números en solitari:

![Vista individual del dashboard de Chess & Friends](dashboard-individual.png)

I la d'"Amics", que compara tots els que juguem entre nosaltres i afegeix una taula de cara a cara:

![Vista de comparació entre germans a Chess & Friends](dashboard-amigos.png)

Res gaire complicat per dins (un HTML, un script de fetch i un altre de dashboard, sense build ni frameworks), però per al que necessitava és exactament el que volia: zero manteniment i amb pinta de projecte de veritat.

## Les pallisses, en números

La veritat és que és lamentable, i hauria fins i tot de fer-me vergonya publicar això. Però bé, tant se val, simplement és un joc. Ja ho sospitava, però veure-ho en una taula ben endreçada és un altre nivell d'humiliació.

## Comiat

Un projecte d'un matí mentre feia tasques domèstiques, per riure'm una mica de mi mateix (mentre escric això ja sento riure els cabrons dels meus germans). L'he deixat públic, qualsevol pot clonar el repo i modificar l'arxiu de dades per generar la seva pàgina web.

Fins a la propera.

{{< youtube c7BVtGnlxT8 >}}
