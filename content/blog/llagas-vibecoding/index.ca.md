---
title: La meva relació amb les llagues i el vibecoding
description: Com en cinc minuts i amb una IA em vaig fer una web per portar el registre de les llagues que em surten a la boca, amb fotos d'Immich i un mapa de la boca, sense revisar ni una sola línia de codi, i per què em sembla perfectament bé.
date: 2026-10-16
image: cover.png
keywords:
  - vibecoding
  - ia
  - claude
  - llagues
  - immich
  - self-hosting
  - pwa
  - projectes personals
  - salut
readingTime: true
comments: true
categories:
  - Programació
tags:
  - vibecoding
  - ia
  - claude
  - immich
  - self-hosting
  - open source
---

Hola de nou. Avui toca un post una mica diferent. No parlaré d'un d'aquells projectes als quals tinc estima i que cuido línia a línia, sinó de tot el contrari: una web que vaig fer en cinc minuts, que no he revisat absolutament res, i que em sembla perfecte que sigui així.

Es diu **Llagas**, serveix per portar el registre de les llagues que em surten a la boca, i és la meva excusa per parlar de com convisc amb el *vibecoding*.

{{< github-repo-card owner="christt105" repo="llagas" >}}

![La pantalla d'inici i les estadístiques de Llagas, amb dades de demostració](cover.webp)

## El problema

Sóc dels que tenen llagues a la boca amb bastant freqüència. Res greu, però prou com per voler saber quan em surten, quant duren, on, si va ser per mossegar-me o per estrès, i què em va anar bé per curar-les. Moment friqui perquè un metge et miri amb una mica de por.

## El que ja tenia a Obsidian

No partia de zero. Feia temps que les apuntava a Notion. Després van passar al meu vault d'Obsidian, una nota per llaga amb unes quantes propietats:

```yaml
---
type: llaga
fecha_aparicion: 2026-06-19
fecha_desaparicion: 2026-07-03
ubicacion: Paladar
dolor:
causa_sospechada:
tratamiento:
---
```

I funcionava. Amb una vista de Bases tenia una taula de totes elles, i poca cosa més. Però se'm quedava curt en coses molt concretes:

- Apuntar una llaga nova des del mòbil era més fricció de la que volia. Si he d'obrir Obsidian, crear la nota, omplir les propietats... acabo deixant-ho per després, i després és mai.
- La ubicació era text lliure. "Llavi inferior", "llavi de baix", "llav inf". Impossible treure estadístiques decents.
- Les fotos. Fer una foto a una llaga per veure com evoluciona és útil, però les fotos ja viuen al meu [Immich](https://immich.app/), i no volia duplicar-les dins del vault.
- Volia **veure on** em surten. No una llista de noms, sinó un dibuix de la boca amb els punts marcats.

Podia haver fet un plugin d'Obsidian o haver-me currat més les plantilles, però per al que volia, que era una cosa exclusiva per a aquest tema amb exactament les eines que se m'acudien, em demanava una cosa pròpia.

## La solució: demanar-ho a Claude

Així que em vaig asseure amb Claude, li vaig explicar el que volia i li vaig anar demanant coses. I en uns cinc minuts tenia una primera versió funcionant. Directament des del mòbil li ho vaig demanar tot i, com que viu al meu servidor de casa, ho va fer en un no res. L'he anat polint després, però el més important hi era des del principi:

- **Alta ràpida des del mòbil**, com a PWA instal·lable. Un botó i llestos.
- **Un mapa de la boca**. Dibuix d'una boca oberta i la ubicació es tria tocant on és la llaga. El text de la ubicació s'omple sol.
- **Fotos d'Immich**. La web només guarda els identificadors de les fotos, no les copia. En editar una llaga m'ensenya les fotos que vaig fer els dies que va durar, les selecciono i s'afegeixen a un àlbum d'Immich. També puc fer una foto des de la mateixa web.
- **Estadístiques**: quantes porto a l'any, durada mitjana, la més llarga, cada quant em surten, en quines zones, i un mapa amb totes elles.

![Triar la ubicació tocant el dibuix de la boca, i el mapa amb totes les llagues de l'historial](mapa.webp)

Totes les imatges estan fetes amb dades de demostració generades, estic malament però puc viure bé.

Les fotos d'Immich funcionen igual: trio el rang de dies i la web m'ensenya les fotos d'aquell període per enllaçar-les.

![Selector de fotos d'Immich i l'historial agrupat per mesos (les fotos de la captura són de farciment)](immich.webp)

Després vaig migrar totes les llagues que tenia a Obsidian a la nova base de dades amb un script d'importació, i de passada busca les fotos que ja tenia enllaçades a les notes i les vincula.

## No he revisat res de codi

I aquí ve el que realment m'interessa explicar: **no he mirat el codi**. Ni una línia. No sé com està estructurat, no sé si hi ha res estrany, i no m'importa.

Això, que en qualsevol dels meus altres projectes seria una heretgia, aquí té tot el sentit per diverses raons:

- **És un projecte simple.** Una web per a mi, a la meva xarxa local, sense comptes ni usuaris que no siguin jo. Si es trenca, el pitjor que passa és que no puc apuntar una llaga durant una estona.
- **El risc és mínim.** No toca res important. Només guarda unes dates i uns identificadors de fotos.
- **Es prova sol en usar-lo.** Si funciona quan la faig servir, funciona. Si alguna cosa falla, ho noto a l'instant i li ho explico a Claude.
- **El seu objectiu és fer-me la vida més fàcil**, no ser perfecte. No tots els projectes han de ser-ho.

I hi ha un punt que em sembla encara més important: **sense la IA ni m'ho hauria plantejat**. Hauria trigat moltíssim més, hauria hagut d'aprendre coses que no m'interessen per a una cosa tan petita, i el més probable és que hagués seguit amb la nota d'Obsidian. El vibecoding aquí no ha substituït un projecte que hauria fet jo, ha fet possible un que no hauria existit.

## L'altre costat: els projectes que sí que m'importen

No vull que això es llegeixi com un "deixeu-ho tot en mans de la IA", perquè la meva relació amb ella és **completament diferent segons el projecte**.

Tinc altres projectes que són més importants i als quals tinc moltíssima estima, com [Elit3D](../elit3d-godot-update) o [Godosters](../godosters-origin). Amb aquests vaig moltíssim més lent. També m'ajudo de la IA, però reviso cada línia, no deixo que se'n vagi de mare, decideixo jo com s'organitza el codi i què s'accepta i què no. Si he de triar entre anar ràpid o entendre-ho tot, allà trio entendre-ho tot.

Crec que part de "conviure amb el vibecoding" és això: saber quan deixar-te portar i quan no. El que em semblaria un error és aplicar el mateix criteri a tot, en qualsevol dels dos sentits. Revisar cada línia de Llagas seria perdre el temps, i no revisar res d'Elit3D seria una irresponsabilitat.

## Com està desplegat

Ja que és un projecte tan còmode de tocar, l'he publicat també com a imatge de Docker a GitHub, i el tinc al meu home server al costat de la resta de serveis. La configuració bàsica és un `docker-compose` amb l'adreça del meu Immich i una clau d'API:

```yaml
services:
  llagas:
    image: ghcr.io/christt105/llagas:${LLAGAS_TAG:-latest}
    restart: unless-stopped
    ports:
      - "8097:8080"
    environment:
      TZ: Europe/Madrid
      IMMICH_URL: http://immich.lan:2283
    env_file: .env
    volumes:
      - ./data:/data
```

No té autenticació, perquè està pensada per a la meva xarxa local (i per a Tailscale quan sóc fora de casa). És just el tipus de decisió que es pot prendre a la lleugera en un projecte així i que mai prendria en un que serveixi dades d'altres persones.

## Conclusió

Llagas no és un projecte que ensenyaré en una entrevista, ni vull. És una eina petita que em resol un problema petit i l'he fet en cinc minuts.

Si alguna cosa me n'emporto d'això és que el vibecoding no ha de ser per força una etiqueta per dir "el meu codi és dolent" ni una bandera per dir "ja no cal saber programar". És una eina més, i el important és triar bé on fer-la servir. Per a les coses que m'importen, continuo anant a poc a poc i mirant-ho tot. Per a les que simplement vull que existeixin, em deixo portar.

La IA ha vingut per quedar-se, ens agradi o no, ara cadascú que la faci servir com més li vingui de gust.

Si et passa el mateix que a mi i vols tenir-ho al teu servidor, el codi és a [GitHub](https://github.com/christt105/llagas) amb instruccions. Això sí, sota el teu propi risc, que jo tampoc l'he llegit, hehe.

Fins al següent post!
