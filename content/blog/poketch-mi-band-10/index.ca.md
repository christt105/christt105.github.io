---
title: Creant el Pokereloj per a la Mi Band 10
description: Com he creat una skin personalitzada del pokereloj per a la Mi Band 10 amb Mi Create.
date: 2026-07-26
image: cover.jpg
keywords:
  - Mi Band 10
  - Xiaomi
  - Pokémon
  - Mi Create
  - Gadgetbridge
readingTime: true
comments: true
draft: false
categories:
  - Gadgets
tags:
  - Mi Band
  - Xiaomi
  - Pokémon
---
Hola de nou.

Fa pocs mesos se'm va trencar la corretja de la Mi Band 4. La corretja que acostumo a comprar costa menys de 2€, però vaig pensar que potser era el moment d'actualitzar-la. Realment no sóc gaire de rellotges, no sóc de mirar gaire l'hora (per això arribo sempre tard) i principalment el faig servir per veure els passos. Tot i així em venia de gust alguna cosa més gran, amb millors sensors i si es pogués connectar a Strava, encara millor. La meva parella es va comprar una Mi Band 10 fa poc, així que no m'ho vaig pensar gaire i vaig comprar la mateixa.

## Personalització
No acostumo a tenir gaires accessoris, però els que tinc vull que siguin de coses que m'agraden, que parlin una mica de mi. A la Mi Band 4 tenia un pokereloj bastant maco. Hi ha molt poques skins oficials i les que hi ha són molt lletges i estan en un idioma que no fa servir el sistema internacional. Com que és molt nova, molt poca gent ha fet skins, i per descomptat que no n'hi havia cap de pokereloj, així que tocava treballar una mica.

## Mans a l'obra
Realment és tot molt caòtic. Xiaomi no proporciona una manera de personalitzar les skins de manera fàcil i les que ha fet la comunitat són una mica ___seves___.

He fet servir el programa Mi Create, que va ser el que més confiança em va donar.

{{< github-repo-card owner="ooflet" repo="Mi-Create" >}}

És un programa que et permet crear un projecte per a diferents rellotges, inclosa la Mi Band 10. Realment és un XML amb diferents components que vinculen dades de la polsera, com els passos, l'hora o la temperatura, a unes imatges dels números del 0 al 9.

Fa uns anys (acabo de comprovar que en fa 5, com passa el temps) vaig fer el pokereloj a Unity amb uns amics. La veritat és que va ser un projecte molt guai i ens ho vam passar molt bé. La idea era agafar els sprites d'aquest projecte, però vaig trobar aquest projecte d'un [pokereloj per a la Mi Band 7](https://amazfitwatchfaces.com/mi-band-7/view/688) que era pràcticament idèntic al que necessitava. Vaig descarregar l'arxiu i el vaig descomprimir. Era un arxiu `.bin`, però és un zip disfressat. Conté totes les imatges.

Tocava obrir el Mi Create i crear un nou projecte. No és gaire complex de fer servir. He anat posant les imatges, adaptant les mides i modificant algunes coses.

![Captura de pantalla de Mi Create creant el Pokereloj](mi-create-poketch.png)

Hi ha algunes coses que he canviat. He tret el Lucario de baix, he fet servir un format de data DD-MM, he traduït els noms dels dies i ho he fet tot més gran perquè es vegi millor. També he afegit una petita animació perquè no semblés tot tan estàtic.

Aquest ha estat el resultat final:

![Previsualització de la skin del Pokereloj](poketch_preview_blink.gif)

Realment els píxels semblen bastant distorsionats, entenc que és perquè s'ha convertit diverses vegades i s'han arrossegat els problemes, tot i així a la pantalla del rellotge ni es nota.

## Com ho passo al rellotge?
La pregunta del milió, ja ho tenia tot fet i semblava que hauria de vendre totes les meves dades. Segons la documentació de Mi Create, havia d'instal·lar una versió estranya de Mi Fitness, donar la MAC del meu rellotge a uns servidors russos, així que no confiava gaire.

Existeix una aplicació de codi obert, [Gadgetbridge](https://gadgetbridge.org/), que et permet fer diverses coses, però a les especificacions posava que la Mi Band 10 no tenia gaire bona compatibilitat. Una altra opció és [Notify for Xiaomi](https://mibandnotify.com/), que és a Google Play i em dona més confiança.

La vaig instal·lar i vaig fer els passos per connectar-la amb el rellotge. M'ha donat molts problemes i he acabat desinstal·lant l'aplicació de Mi Fitness, i llavors sí que l'he aconseguit connectar. El procés és molt fàcil, des de Mi Create exportes i des de l'aplicació carregues l'arxiu i es puja automàticament.

I ja està, ja tinc el meu pokereloj a la Mi Band 10.

![La skin de Pokereloj a la Mi Band 10](./cover.jpg)

## Projecte

He pujat el projecte a GitHub per si algú hi té interès o per si en algun moment necessito canviar alguna cosa.

{{< github-repo-card owner="christt105" repo="poketch-mi-band10" >}}

També l'he pujat a [amazfitwatchfaces](https://amazfitwatchfaces.com/mi-band/view/521), tot i que potser encara no hi estigui disponible.

## Acomiadament
I fins aquí. Projecte d'un dia, una cosa menys a fer.

Fins a la propera.
