---
title: Jellytags
description: Creación de una web para gestionar las etiquetas de los medios de Jellyfin
date: 2026-03-06
image: cover.png
keywords:
readingTime: true
comments: true
draft: true
categories:
  - 
tags:
  - jellyfin
  - docker
  - Web
  - Self-hosted
---
Bienvenidos a otro post.

Como es costumbre, he dejado a medias el post del Media Tracker y he empezado con otra cosa. Quiero acabarlo pero me gustaría crear un tema de Hugo específico para que cualquiera pueda usarlo fácilmente.

Hoy os traigo un proyecto muy corto que tenía ganas de hacer.

## Problema
Como ya expliqué en otro post, tengo una instancia de [Jellyfin](https://jellyfin.org/) ejecutándose en mi servidor casero. Al principio está bien porque ves como va creciendo tu biblioteca, pero después se vuelve un descontrol con mucho ruido visual.

Lo comparto con varios integrantes de la familia y hay muchos elementos que unos quieren ver que no interesan a los demás. De momento Jellyfin no tiene una opción para ocultar elementos por usuario manualmente, [aunque llegará en un futuro](https://features.jellyfin.org/posts/1072/let-the-user-hide-a-movie-or-tv-show).

Por lo que he podido ver, hay dos soluciones. O separo los contenidos por bibliotecas, cosa que hará que haya aun más descontrol, o creo unas etiquetas y hago que ciertos usuarios no puedan ver los contenidos de esas etiquetas. Esta última solución es la que más me encaja, aunque hay un ligero bache, Jellyfin no permite edición múltiple de etiquetas, por lo que tendría que ir una por una. Realmente ya lo iba haciendo, tenía la etiqueta de `anime` y la iba poniendo a medida que añadía un elemento de esa categoría, pero es lento y si quiero cambiar muchas cosas a la vez es tedioso.

## Solución
La mejor solución que se me ocurrió fue hacer una página web que use la API de Jellyfin y así es como nace [Jellytags](https://github.com/christt105/jellytags), un proyecto de código abierto de dos días.

[![Repositorio Jellytags GitHub|437x24](https://opengraph.githubassets.com/1/christt105/jellytags)](https://github.com/christt105/jellytags)
### Stack tecnológico
Con mis básicas habilidades de desarrollo web, tenía que buscar algo simple. Así que elegí lo siguiente:

- [Vite](https://vite.dev/) y [TypeScript](https://www.typescriptlang.org/)
- [jellyfin-sdk-typescript](https://typescript-sdk.jellyfin.org/)
- [Docker](https://www.docker.com/)

La idea es hacerlo lo más simple que pueda. Iba a hacerlo con html y javascript directamente pero quería probar algo más moderno con Vite y TypeScript, así que esa ha sido mi elección para la base. Un añadido extra es el uso de un sdk oficial de Jellyfin para Typescript que me va a poner las cosas más fáciles a la hora de hacer las peticiones a la API. Por último, todo va a correr detrás en una imagen de Docker, para que cualquiera pueda descargar la imagen, poner las variables para acceder a su instancia de Jellyfin y a funcionar.

### Resultado
La página web es muy simple, se compone únicamente de tres archivos, el html, el main.ts y el css. Podría separarlo pero no tiene mucha complejidad. Gran parte de este proyecto ha sido gracias a la IA, ya que sin ella habría tardado mucho más y con un aspecto visual mucho más deplorable.

![Resultado de Jellytags](./screenshot.png)
Se compone de tres secciones:
- La barra superior con el nombre de la página, un buscador de elementos y etiquetas, el seleccionable del orden de los elementos y un botón para refrescar la página.
- La parte izquierda ocupa la mayor parte de la pantalla ya que cuenta con todos los elementos (Películas y Series) preparadas para ser seleccionadas. Muestra el elemento, el tipo y las etiquetas que ya tiene.
- El panel derecho es el controlador de las etiquetas. Te permite limpiar la selección, ver los elementos que tienes seleccionados y añadir etiquetas.
#### Móvil
Otra cosa que necesitaba era que la web funcionase en móvil, mejor o peor pero que funcionase. Conseguí que funcionase bastante decentemente.
![Captura Móvil 1|300](mobile1.jpg)
![Captura Móvil 2|300](mobile2.jpg)

## Deploy
Tener la página en local está muy bien, pero hay que crear una build de la web y hacer que cualquiera pueda usarla. Para esto he creado un [workflow en GitHub](https://github.com/christt105/jellytags/blob/main/.github/workflows/docker-publish.yml), gracias a las GitHub Actions, que cada vez que creo una tag con el formato `v1.0.0`, el propio GtiHub creará una imagen de Docker y la subirá a Docker Hub en https://hub.docker.com/r/christt105/jellytags, para que cualquier persona pueda descargarla y usarla.

Una vez creada la imagen, ya puedo ir a mi servidor y crear un archivo `docker-compose.yml` con el siguiente contenido:

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

Por último, solo me queda hacer `docker compose up -d` y ya tendría la página web accesible desde mi red local en `http://ip-local-server:8181` conectada a mi Jellyfin.

## Conclusiones
Y hasta aquí este post. Mucho más corto de lo que suelo hacer en el blog pero realmente es lo que debería de ser siempre, posts cortos y al grano.

Espero que os haya gustado y os sea útil. Recordad que el proyecto está gratis para usar y contribuir en https://github.com/christt105/jellytags. Si tenéis algún problema no dudéis en abrir una issue en el proyecto. Podéis dejar una "me gusta" en el repositorio o un comentario en este post, son más que bienvenidos.

Hasta la próxima!