---
showTranslations: false
title: "InformadoRSS"
image: cover.webp
banner: banner.png
description: "Reenviador ligero y self-hosted de RSS/Atom a Discord en un solo contenedor, un reemplazo pequeño de MonitoRSS."
tags: ["herramienta", "c#", "vue", "rss", "discord", "ntfy", "sqlite", "docker"]
filters: ["tool", "docker", "c#"]
repo: "christt105/InformadoRSS"
githubDownload: false
page: "https://github.com/christt105/InformadoRSS"
weight: 190
---

`InformadoRSS` es un servicio ligero y self-hosted que vigila feeds RSS y Atom, filtra sus elementos por ruta y los entrega a canales de Discord o a [ntfy](https://ntfy.sh/). Funciona en un único contenedor: un binario en C# con .NET 10 compilado con NativeAOT que sirve una interfaz web en Vue 3 y guarda todo en SQLite. Solo habla con Discord a través de la API REST del bot (sin gateway ni comandos). Es de código abierto con licencia MIT.

Características principales:

- **Feeds y rutas**: Un feed es una URL; cada feed tiene rutas con un filtro, uno o varios destinos (Discord o ntfy) y una plantilla de mensaje.
- **Constructor de filtros y editor de plantillas**: Crea los filtros y edita los mensajes desde la interfaz web en lugar de escribirlos a mano.
- **Selector de servidor y canal de Discord**: Elige los destinos por nombre y comprueba en qué canales no puede publicar el bot.
- **Alertas**: Un aviso cuando un feed o un destino se rompe y otro cuando se recupera, por Discord o ntfy.
- **Copias de seguridad diarias**: Copias programadas de la base de datos en una carpeta, conservando las más recientes.
- **Importador de MonitoRSS**: Importa feeds y rutas desde una exportación de MonitoRSS, con simulación y un canal de pruebas para comparar los mensajes antes de cambiar.
- **Patrón de identidad para feeds que reescriben entradas**: Una expresión regular sobre la descripción que se añade al id del elemento, así un cambio de estado en una lista de MyAnimeList cuenta como elemento nuevo.

Cuento cómo y por qué lo hice en [el post del blog](/es/blog/informadorss/). La imagen se publica en `ghcr.io/christt105/informadorss`.

![El editor de rutas: filtro, plantilla del mensaje y canal de destino](./web-route.webp)
