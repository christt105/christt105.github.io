---
title: "Automatitzant la meva biblioteca de Jellyfin amb mnamer i un bot de Telegram"
description: "Un bot de Telegram per a automatitzar l'organització de la teva biblioteca de Jellyfin utilitzant mnamer."
date: 2026-03-27
image: cover.png
keywords:
  - mnamer
  - telegram bot
  - self-hosting
  - jellyfin
  - c#
readingTime: true
comments: true
draft: false
categories:
  - Self-hosting
  - Programació
tags:
  - telegram
  - bot
  - c#
  - jellyfin
  - docker
  - mnamer
---
Hola de nou!

Aquesta vegada us porto un projecte que portava mesos aturat. Estic intentant completar la meva llista de projectes pausats per a donar-me una mica de pau. Seguim amb el tema del self-hosting, aquesta vegada amb un bot de Telegram.

## Problema
La idea va sorgir quan vaig començar a utilitzar al mini PC el descarregador P2P vulgarment anomenat "la mula". Quan una descàrrega acabava no tenia manera de saber-ho, i havia d'anar-hi manualment, crear la carpeta amb el nom correcte a la meva biblioteca de Jellyfin i enganxar-hi l'arxiu canviant-li el nom. Com a principiant en això d'automatitzar coses, era una cosa que no em podia permetre.

## Preludi
Al cap de poc temps vaig provar [tinyMediaManager](https://www.tinymediamanager.org/) en Docker, però era pràcticament inusable des del telèfon mòbil, que és el meu dispositiu habitual per a gestionar això.

Poc després vaig buscar altres opcions i vaig trobar [mnamer](https://github.com/jkwill87/mnamer), un programa per consola capaç de reanomenar pel·lícules i sèries. Era exactament el que buscava. Utilitza [TMDB](https://www.themoviedb.org/) per a les pel·lícules i [TheTVDB](https://thetvdb.com/) per a les sèries (que ho prefereixo perquè té millors regles per a alguns animes). Amb algunes ordres pots fer que llegeixi tots els arxius de vídeo d'una carpeta i els reanomeni i els col·loqui a les carpetes pertinents de la teva biblioteca.

Vaig estar utilitzant mnamer un temps; quan alguna cosa acabava de descarregar-se, obria la consola de comandaments per SSH i executava un àlies que em vaig crear.

```bash
# Ruta al docker-compose de mnamer
export MNAMER_COMPOSE="/home/christian/Server/70-79_Media/74_gestion_media/mnamer/docker-compose.yml"

# Executar mnamer genèric
alias mnamer="docker compose -f $MNAMER_COMPOSE run --rm mnamer"

# Executar en mode prova (no mou res, només mostra)
alias mnamer-test="docker compose -f $MNAMER_COMPOSE run --rm mnamer --test -r /data/Descargas"

# Executar en mode real (mou de Descargas a destí)
alias mnamer-run='docker compose -f $MNAMER_COMPOSE run --rm mnamer -r /data/Descargas'

alias mnamer-tmdb='docker compose -f $MNAMER_COMPOSE run --rm mnamer -r /data/Descargas --id-tmdb'

alias mnamer-tvdb='docker compose -f $MNAMER_COMPOSE run --rm mnamer -r /data/Descargas --id-tvdb'
```

Tenia mnamer en un contenidor Docker i vaig crear alguns comandaments per a fer-lo funcionar sense haver d'escriure gaire cosa. Amb `mnamer-test` podia comprovar que tot s'anava a reanomenar correctament. Si alguna cosa no l'agafava bé, executava `mnamer-tmdb` o `mnamer-tvdb` i li passava l'ID que buscava al navegador. Si tot estava bé, simplement executava `mnamer-run --batch` perquè ho fes tot d'una tirada. Com podeu comprovar, continuava sent bastant manual; hi havia molt de marge de millora.

Uns mesos abans vaig estar experimentant amb els bots de Telegram. Vaig intentar crear-ne un amb Python, però em vaig acabar atabalant i vaig passar a C# utilitzant [WTelegramBot](https://github.com/wiz0u/WTelegramBot), una API exquisida per a crear bots amb moltíssimes funcionalitats i en un llenguatge amb el qual em sentia més a gust. Aquest bot està en pausa, un altre projecte més a la llista interminable.

## La travessia del bot
Amb les idees clares, a finals de l'any passat vaig estar treballant uns dies en el bot. La idea principal era que cada vegada que hi hagués un arxiu en una carpeta, el bot enviés un missatge amb la proposta de mnamer i un link a TMDB o TheTVDB per a poder comprovar que era correcte. Una vegada feta la comprovació, prémer un botó i que s'enviés a la biblioteca.

Vaig fer una cosa molt bàsica per a comprovar si hi havia arxius i enviar un missatge amb la proposta de mnamer i un botó per a acceptar-la. Si mnamer s'equivocava, havia d'anar manualment al disc dur, canviar-li el nom i tornar-ho a provar, cosa que no solia passar, però era realment molest.

Vaig estar uns mesos així fins que al febrer vaig decidir continuar. Vaig afegir-hi el File Watcher i que poguessis contestar amb un ID per a rectificar l'opció. També vaig intentar arreglar el tema dels permisos dels arxius i ara el contenidor s'executa amb l'usuari 1000:1000 per defecte; encara que a mi em funciona, crec que no està del tot ben implementat.

Ho vaig tornar a deixar perquè m'anava bastant bé, fins fa pocs dies que em vaig posar a arreglar un parell de coses i a crear tota la documentació perquè altra gent ho pogués provar. Vaig configurar que GitHub Actions generés una imatge Docker cada vegada que creés una etiqueta (tag) i vaig fer el repositori públic.

I així està en l'estat actual. Imagino que l'aniré millorant a poc a poc si la gent l'utilitza, com acaba de passar fa no-res, que un amic m'ha enviat una PR arreglant els IDs dels usuaris; és la part més reconfortant de la programació. Crec que és una cosa complexa de configurar, però fins que més gent no ho intenti no sé com fer-ho millor.

![Exemple del bot reanomenant](example.png)

Si t'interessa el codi font del projecte o les instruccions per a instal·lar-lo, el pots trobar al meu compte de GitHub:

{{< github-repo-card owner="christt105" repo="mnamer-telegram" >}}

## Conclusió
És la primera vegada que faig un programa amb C# directament; la meva experiència amb C# sol ser gairebé sempre dins de l'entorn de Unity. Sé que hi ha moltes coses malament i millorables, però estic gaudint aprenent noves formes de programar.

Un altre projecte bastant reduït que puc ratllar de la meva llista de pendents i passar a una altra cosa. Si tens una configuració semblant i vols provar el bot, t'animo que ho facis i deixis una estrella en [el repositori](https://github.com/christt105/mnamer-telegram). He publicat el meu exemple de com ho tinc muntat aquí: https://github.com/christt105/mnamer-telegram/discussions/2.

Ens veiem en el següent post!