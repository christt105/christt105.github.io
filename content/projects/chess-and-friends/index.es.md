---
showTranslations: false
title: "Chess & Friends"
image: cover.webp
banner: banner.webp
description: "Web que registra la precisión y los resultados de mis partidas de chess.com contra mis hermanos, con la API pública de chess.com."
tags: ["herramienta", "javascript", "chess", "api"]
filters: ["tool", "web"]
repo: "christt105/chess-and-friends"
githubDownload: false
page: "https://christt105.github.io/chess-and-friends/"
weight: 210
---

`Chess & Friends` es una web pequeña que registra la precisión y los resultados de las partidas de chess.com que juego contra mis hermanos y muestra cómo evolucionan con el tiempo. Saca todo de la API pública de chess.com, sin API key y sin análisis local con motor.

Características principales:

- **Vista individual**: La evolución de mi precisión y mis números en solitario.
- **Vista de amigos**: Una comparación entre todos los del grupo, con una tabla cara a cara.
- **Datos automáticos**: Un script de Node descarga las partidas de la API y las guarda en un `games.json`, y los meses cerrados se cachean para pedir solo el actual.
- **Cero mantenimiento**: Una página estática sin paso de build ni frameworks, que se actualiza sola para no tener que tocarla.

Empezó como una broma para llevar la cuenta de las palizas que me dan mis hermanos. Cuento toda la historia en [el post del blog](/es/blog/chess-and-friends/).

![La vista de amigos del dashboard de Chess & Friends](./preview.webp)
