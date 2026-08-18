---
title: Cinepillos
description: Reprenc un altre projecte, una web per decidir quina pel·lícula veure amb amics, de codi obert.
date: 2026-08-18
image: cover.png
keywords:
  - Cinepillos
  - Next.js
  - Prisma
  - Vercel
  - Neon
  - TMDB
  - Open Source
readingTime: true
comments: true
draft: false
categories:
  - Self-hosting
  - Programació
tags:
  - nextjs
  - typescript
  - prisma
  - postgresql
  - vercel
  - neon
  - docker
---
Hola de nou!

Continuo acabant els projectes que tinc començats, i avui li toca a Cinepillos. El vaig començar fa ja uns mesos, cap al gener, com a "Club de Cine", una web per portar un tauler de propostes de pel·lícules amb un grup d'amics, programar una sessió i votar quina de les propostes es veu. Sincerament, mai he arribat a necessitar-lo de debò, difícilment veig jo pel·lícules, com per veure-les amb altres, però em feia gràcia tenir un lloc per això. Dubto que arribi a fer-lo servir mai de debò, però bé, a veure si li serveix a algú.

## D'on ve el nom
El meu gos té un ninot al qual anomenem "zorropillo", i d'ajuntar això amb "cine" va sortir Cinepillos. Així que el rebrand de "Club de Cine" no té gaire més ciència que aquesta.

## D'autoallotjada a Vercel i Neon
Era l'única web que tenia autoallotjada al meu mini PC de tots els meus projectes, mitjançant túnels de Cloudflare, i aquesta vegada volia provar alternatives en lloc de ficar-la al meu servidor, que ja et comença a ofegar. Així que vaig decidir muntar-la sobre [Vercel](https://vercel.com) per al desplegament i [Neon](https://neon.tech) com a Postgres gestionat. Res al mini PC, cap disc a mantenir, cada push a la branca principal es desplega sol. La veritat és que ambdues plataformes ofereixen uns límits gratuïts molt amplis, de sobra per a aquest projecte.

Això sí, per a qui prefereixi tenir-ho al seu propi servidor, segueix sent perfectament autoallotjable amb Docker Compose, més endavant ho veiem.

## Sobre monetitzar-la
Li he donat voltes a intentar treure una mica de diners amb aquest projecte, per aprofitar una mica el temps que hi dedico, tampoc espero fer-me turbomilionari. Però al final ho vaig descartar. Ni la idea de monetització que tenia al cap era bona, ni em compensava ficar-me en embolics amb les condicions d'ús de TMDB i TVDB, les dues bases de dades de les quals tira la web, que no permeten un ús comercial així com així. Així que Cinepillos es queda gratis i de codi obert, com la resta dels meus projectes, i jo: pobre. Em falta mentalitat de tauró. Visca l'open source.

## Com funciona
La idea és senzilla. Un grup porta un tauler compartit de propostes de pel·lícules, qualsevol membre pot afegir-ne una cercant-la directament a la web. Quan hi ha ganes de quedar, es programa una sessió amb data i hora, s'obre la votació entre les propostes i cadascú vota la que vol veure. Quan es tanca la votació, guanya la més votada i queda registrada com la sessió d'aquell dia.

Una mateixa instància pot tenir diversos clubs alhora i cadascun és completament privat, ningú d'un club veu res d'un altre. El login és amb Google, i a `/settings` cadascú pot triar-se un avatar tret d'un pòster de TMDB o d'una foto de personatge de TVDB, així que fins i tot l'avatar tira de les mateixes bases de dades que la resta de la web.

![Pàgina principal amb la pròxima sessió i les propostes del club](home.png)
![Cercador de pel·lícules tirant de TMDB, amb filtres per gènere](search.png)

## Treballant amb la IA
Amb Claude he seguit el mateix flux que en altres projectes, però aquesta vegada amb un afegit que m'ha agradat força. Cada cop que obro una PR, Vercel desplega una preview i Neon li clona una còpia de la base de dades de producció per a aquesta preview. Així les tasques queden ben contingudes: li demano a Claude una tasca concreta, la puja a GitHub, i quan acaba ja tinc una preview funcionant amb dades reals per provar el canvi, fer-hi un cop d'ull al codi i, si tot va bé, fer-ne merge. Sense haver de muntar res a mà ni preocupar-me de trencar producció mentre provo.

## Codi obert i gratis
Com sempre, tot el codi és a GitHub per a qui vulgui fer-lo servir, tocar-lo o millorar-lo. Cinepillos és gratis i ja el teniu a [cinepillos.vercel.app](https://cinepillos.vercel.app), el login és només amb Google perquè era l'opció més senzilla per a mi, però en ser de codi obert qualsevol pot aixecar la seva pròpia instància amb Docker Compose i les seves pròpies claus de TMDB i TVDB si li encaixa millor.

{{< github-repo-card owner="christt105" repo="cinepillos" >}}

I fins aquí el post d'avui. Si proveu Cinepillos o el codi, ja sabeu on deixar-me un comentari.

Fins a la propera!
