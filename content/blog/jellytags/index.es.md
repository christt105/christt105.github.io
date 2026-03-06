---
title: "Jellytags: Gestión de etiquetas para Jellyfin"
description: "Creación de una herramienta web para gestionar masivamente las etiquetas de tus medios en Jellyfin."
date: 2026-03-06
image: cover.png
keywords: [Jellyfin, Docker, Self-hosted, API, TypeScript, Gestión de etiquetas, Open Source]
readingTime: true
comments: true
draft: false
categories:
  - Self-hosting
tags:
  - jellyfin
  - docker
  - web
  - self-hosted
---
¡Bienvenidos a un nuevo post!

Como ya es costumbre, he pausado momentáneamente el desarrollo del Media Tracker para centrarme en algo nuevo. Mi intención es terminarlo, pero antes me gustaría crear un tema de Hugo específico para que cualquiera pueda implementarlo fácilmente.

Hoy os traigo un proyecto corto pero funcional que tenía muchas ganas de materializar.

## El Problema
Como comenté en posts anteriores, mantengo una instancia de [Jellyfin](https://jellyfin.org/) en mi servidor doméstico. Al principio es gratificante ver cómo crece la biblioteca, pero con el tiempo se convierte en un caos visual difícil de gestionar.

Comparto el servidor con varios familiares y hay mucho contenido que a unos les interesa y a otros no. Actualmente, Jellyfin no permite ocultar elementos por usuario de forma manual, [aunque puede cambiar en un futuro](https://features.jellyfin.org/posts/1072/let-the-user-hide-a-movie-or-tv-show).

Tras investigar, vi dos opciones: separar el contenido en múltiples bibliotecas (lo que genera más desorden) o usar etiquetas para restringir el acceso a ciertos usuarios. Esta última es la solución ideal por el momento, pero tiene un inconveniente: Jellyfin no permite la edición múltiple de etiquetas. Ir uno por uno (por ejemplo, como hago ahora con la etiqueta `anime`) es un proceso lento y tedioso cuando quieres organizar cientos de elementos.

## La Solución: Jellytags
Para solventar esto, decidí desarrollar una aplicación web que aprovecha la API de Jellyfin. Así nace [Jellytags](https://github.com/christt105/jellytags), un proyecto de código abierto desarrollado en apenas dos días.

[![Repositorio Jellytags GitHub|426](https://opengraph.githubassets.com/1/christt105/jellytags)](https://github.com/christt105/jellytags)

### Stack Tecnológico
Buscaba algo simple y moderno que se ajustara a mis habilidades actuales:

- [Vite](https://vite.dev/) y [TypeScript](https://www.typescriptlang.org/)
- [jellyfin-sdk-typescript](https://typescript-sdk.jellyfin.org/)
- [Docker](https://www.docker.com/)

Aunque podría haberlo hecho con HTML y JavaScript puro, quería experimentar con Vite y TypeScript. El uso del SDK oficial de Jellyfin para TypeScript facilitó enormemente las peticiones a la API. Finalmente, todo se empaqueta en una imagen de Docker para que cualquier usuario pueda desplegarlo en segundos.

### Resultado
La web es minimalista y eficiente. Se compone de solo tres archivos (`index.html`, `main.ts` y `style.css`), manteniendo la complejidad al mínimo. Gran parte del acabado visual y la rapidez de desarrollo se la debo a la asistencia de la IA.

![Resultado de Jellytags](screenshot.png)

La interfaz se divide en tres secciones:
- **Barra superior:** Buscador de elementos y etiquetas, selector de orden y botón de refresco.
- **Panel principal (izquierdo):** Listado de películas y series con su tipo y etiquetas actuales, listos para ser seleccionados.
- **Panel de control (derecho):** Gestión de la selección y herramientas para añadir o limpiar etiquetas de forma masiva.

#### Optimización móvil
Era imprescindible que la web fuera funcional desde el teléfono, y el resultado es decente:

![Captura Móvil 1](mobile1.jpg)
![Captura Móvil 2](mobile2.jpg)

## Despliegue
Para que el proyecto sea útil a la comunidad, he configurado un [workflow en GitHub Actions](https://github.com/christt105/jellytags/blob/main/.github/workflows/docker-publish.yml). Cada vez que publico una etiqueta de versión (ej. `v1.0.0`), se genera automáticamente una imagen en [Docker Hub](https://hub.docker.com/r/christt105/jellytags).

Para instalarlo en tu servidor, solo necesitas un archivo `docker-compose.yml`:

```yaml
services:
  jellytags:
    image: christt105/jellytags:latest
    container_name: jellytags
    restart: unless-stopped
    ports:
      - "8181:80"
    environment:
      - VITE_JELLYFIN_URL=http://your-jellyfin-server-ip:8096
      - VITE_JELLYFIN_TOKEN=your_admin_api_token
```

Basta con ejecutar `docker compose up -d` para tener Jellytags funcionando en `http://tu-ip-local:8181`.

## Conclusiones
Este ha sido un post breve y directo, que es como creo que deberían ser la mayoría.

Espero que Jellytags os resulte útil. El proyecto es totalmente gratuito y está abierto a contribuciones en GitHub. Si encontráis algún error, no dudéis en abrir una issue. Un "me gusta" en [el repositorio](https://github.com/christt105/jellytags) o un comentario aquí abajo se agradecen mucho.

¡Hasta la próxima!
