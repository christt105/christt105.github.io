---
title: Creando mi Media Tracker con Obsidian y Hugo
description: Cómo he migrado mi Media Tracker a una solución propia usando Obsidian y Hugo, manteniendo el control de mis datos.
date: 2026-01-03
image: cover.png
keywords:
  - obsidian
  - hugo
  - media tracker
  - notion
  - markdown
readingTime: true
comments: true
draft: true
categories:
  - Desarrollo Web
tags:
  - Obsidian
  - Hugo
  - Media Tracker
  - Notion
  - Python
---
Hola de nuevo. Esta vez ha pasado menos tiempo desde el último post, y espero que sea algo más corto que el anterior.

En este post os voy a explicar lo que he hecho en referencia a mi nuevo [media tracker](https://christt105.github.io/MediaTracker/).


### Hugo
[Hugo](https://gohugo.io/) es una herramienta magnífica. Es un generador de webs estáticas enfocado en el formato Markdown. Ya hablé de Hugo en mi post [Porteando mi web a hugo](blog/porting-to-hugo/index.es.md), donde estuve creando mi página web y este mismo blog con Hugo. Me parece maravillosa y se integra muy bien con Obsidian, ya que el núcleo de ambas herramientas son los archivos Markdown, así que decidí usarlo para crear la página web y sea el escaparate de mi Media Tracker.

#### Tema
Hugo funciona a partir de un tema. Obviamente no hay ningún tema (o yo no lo he encontrado) que tenga todo lo que necesito. Igualmente no iba a hacer un tema de cero, mi idea era hacer lo mismo que hice con la página web, buscar un tema y editarlo a mi gusto, ya que no tengo muchos conocimientos de programación web. Estuve mirando y me decanté finalmente por el tema [hugo-blog-awesome](https://github.com/hugo-sid/hugo-blog-awesome). Es un tema muy simple y minimalista, justo lo que buscaba para empezar.

Una vez elegido el tema, creé un [repositorio en GitHub](https://github.com/christt105/MediaTracker) que contendrá el contenido de la página web y las modificaciones del tema. Podría haber separado el contenido de las modificaciones del tema, pero al ser un proyecto relativamente simple, decidí ponerlo en el mismo repositorio. Hugo funciona de forma que si creas un archivo con el mismo nombre, usará ese como prioridad al del tema. Así, que en el repositorio vive el contenido de la web, que simplemente es un archivo Markdown por cada elemento, y los archivos para sobreescribir el tema con lo necesario.

También configuré en [GitHub Actions](https://docs.github.com/actions), para que cada commit, generase los archivos de la web y los publique en una web. Podéis ver el resultado final en [https://christt105.github.io/MediaTracker/](https://christt105.github.io/MediaTracker/).

##### Cambios en el tema
No voy a entrar en mucho detalle porque la mayoría de cambios los ha hecho la IA. Principalmente he cogido el estilo del tema base y le he añadido estilos nuevos y he cambiado prácticamente toda la estructura. He cambiado la página principal para mostrar una vista en galería de cada elemento ordenado de más reciente a más antiguo. Las páginas de cada categoría es parecida a la principal. También he añadido un script que carga un banner aleatorio cada vez que accedes a la web.

##### RSS
No suelo usar [RSS](https://wikipedia.org/wiki/RSS) aunque me parece interesante para notificar contenido nuevo. He creado dos archivos, [uno con todos los elementos](https://christt105.github.io/MediaTracker/index.xml) y otro [únicamente con los elementos acabados](https://christt105.github.io/MediaTracker/acabados.xml). Lo he añadido al servidor de Discord, aunque mis amigos aún no lo saben.

##### Script
Aunque Hugo funciona con Markdown, hay que hacer unos ajustes en cuanto a estructura para que funcione todo correctamente, así que he creado un script en Python para convertir las notas. El script lo tengo en el repositorio de la web: [https://github.com/christt105/MediaTracker/scripts/migration.py](https://github.com/christt105/MediaTracker/blob/main/scripts/migration.py).

El script lo ejecuto cada vez que quiero actualizar la web. Primeramente borra el contenido generado por el script anteriormente para empezar siempre limpio y posteriormente va recorriendo cada nota de mi vault personal, crea una carpeta en el repositorio con el nombre y pega la nota dentro de la carpeta.

Cada nota es procesada para hacer algunos cambios. Primeramente cambia todos los Wikilinks, los que usa obsidian de esta forma `[[Otra Nota]]`, por un link en formato Markdown, si la nota referenciada es otra película, serie o videojuego, o por texto simple. Esto lo hago porque lo mismo referencio una nota de mi vault personal que no estará en la web o referencio una película dentro de otra. Seguidamente modifico los links a youtube que hubiera en la nota y los modifico por el [shortcode](https://gohugo.io/content-management/shortcodes/) de Hugo para que se muestre correctamente.

Hay varios procesos que envuelven el tema de las imágenes. Principalmente tengo tres tipos de imágenes. 

Primeramente tenemos las imágenes de las portadas y los banners que están en un servicio externo como TMDB o Steamgridb. En esta categoría entran todas las imágenes que estén dentro de las propiedades `cover` y `banner` y tengan una url a tmdb, tvdb, steamgriddb o donde sea. Estas imágenes son las únicas que se pueden perder en algún momento, el servicio puede cerrar o eliminar esas imágenes. Estas imágenes se copian al repositorio, así evito que si una imagen deja de estar disponible en internet, yo la tengo guardada y a la hora de cargar la web todas provienen del mismo servidor. Cada url de imagen se codifica para que tenga su nombre identificativo que siempre será el mismo. El script comprueba si esa imagen ya está en el repositorio y si es el caso la ignora y si no, la descarga. En caso de que la url de la imagen cambie, la guardaría en el repositorio y al final del script elimina todas las imágenes que no se han usado.

Por otro lado tenemos las imágenes de las portadas y banners que se guardan localmente en el propio vault. Estas imágenes se copian siempre ya que pueden cambiar pero tener el mismo nombre, y al ser un proceso local no dura mucho. Todas las imágenes se guardan en una carpeta de caché y posteriormente se van copiando a cada carpeta de cada nota que la use. Se separan en carpetas para las portadas y los banners y se guardan con un sufijo para saber la procedencia del archivo.

Finalmente tenemos las imágenes que están dentro de las notas. Estas imágenes se copian directamente del vault y se guardan dentro de la carpeta de la nota.

De esta forma, el script genera una copia inmutable de mis datos, mis notas en el vault principal siempre serán las que se modifiquen. Gracias a que guardo las imágenes como caché, el script es muy rápido y evito que la web deje de funcionar correctamente por factores externos.

##### Generación de Collages
Aún falta una cosa por integrar, el generador de collages. Es una tontería pero me hacía ilusión.

No estaba muy seguro de si podría hacerlo siendo una página web estática, pero sí que es posible. Gracias a la herramienta [html2canvas-pro](https://yorickshan.github.io/html2canvas-pro/), es posible generar una imagen de un elemento de la web.

Después de varios intentos porque me generaba las imágenes con mala calidad si había bastantes elementos, conseguí que descargase una imagen con la calidad original de cada portada. Si hay muchos elementos, el tamaño de la imagen es bastante grande. Añadí varios parametros para filtrar por fecha y tipo y modificar el número de columnas. Ahora puedo generar un collage de las portadas desde cualquier dispositivo y en cualquier momento con un click.

![Generador de Collages](CollageGenerator.png)

##### Comentarios
En Hugo es frecuente tener un apartado de comentarios. No creo que sea muy útil, pero me hacía ilusión ponerlo. En el blog estoy usando [Giscus](https://giscus.app), un sistema de comentarios que usa las discusiones de Github para almacenarlos. El problema principal es que necesitas una cuenta de GitHub para poder comentar, lo que añade una barrera importante para que alguien comente. Para un blog de tecnología es más que aceptable y funciona muy bien, pero para un lugar de películas, series y videojuegos, no es un sistema que encaje. Estuve mirando [Disqus](https://disqus.com/), pero añade anuncios en la capa gratuita y no quiero nada de eso en mis páginas web. También estuve mirando [Cusdis](https://cusdis.com/), que es una alternativa opensource y autohospedada, pero me da bastante pereza hostearlo cuando realmente nadie lo usará. Así que al final he usado Giscus.

![Comentario](ComentarioGiscus.jpg)

##### Actualizador automático 
Ya tengo la web configurada y el script para convertir mis notas de Obsidian a Hugo. Sin embargo, surge un problema: no quiero tener que pasar las notas al ordenador y ejecutar el script manualmente cada vez que quiera actualizar algo.

​Gracias a mi Mini PC y a [Syncthing](https://syncthing.net/), tengo mi _vault_ de Obsidian sincronizado entre todos mis dispositivos. De este modo, cualquier cambio que haga en mis notas desde el móvil se refleja automáticamente en el Mini PC. Con la carpeta del Media Tracker siempre sincronizada, solo faltaba automatizar la ejecución.

​Para ello, he configurado una tarea en el Mini PC usando [cron](https://wikipedia.org/wiki/Cron_\(Unix\)) que se ejecuta cada día a las 9:00. Esta tarea lanza el script de Python sobre el repositorio y, una vez finalizado, si detecta cambios, realiza un git push. Así, cada mañana, el sistema actualiza los archivos y los sube a GitHub, generando una nueva versión de la web. Ya no tengo que preocuparme por el despliegue, todo el proceso es completamente automático.

## Flow Actual
Simkl + jellyfin + Obsidian + RSS

## Próximos pasos
Y con esto ya he explicado todo lo que tengo, suficiente. He tenido que hacer un parón de este post para optimizar la web porque usaba muchísimos recursos al descargar las imágenes.

Dejaré este proyecto por un tiempo pero tengo muchas ideas para ir mejorando. Me gustaría añadir gráficos para mostrar estadísticas de lo que veo y juego. También me gustaría añadir un sistema de filtros en la pantalla principal, para poder filtrar por tipo y etiquetas, y así eliminar las secciones. Otro punto importante es darle uso a la propiedad de `rewatches` y generar una entrada en cada fecha incluida en esa propiedad, de forma que si hay una película que he visto dos veces, que aparezca en ambas fechas. Me gustaría añadir un motor de búsqueda, para poder ir directamente a la nota por nombre. Finalmente, debería dedicarle algo de tiempo a optimizar la web, añadir elementos relacionados en cada nota y mejorar la lógica de series y temporadas.

## Conclusiones
No es la herramienta más cómoda de configurar y usar, pero tiene todo lo que quiero. Esto no es ningún tutorial, por lo que hay muchos archivos que no los he puesto para no hacer el post muy largo. Si estás interesado en que publique un tutorial sobre como crear este Media Tracker, házmelo saber en los comentarios de abajo.

Probablemente podría haber creado un post por cada sección porque me ha quedado un post mucho más largo de lo que me gustaría.

Espero que te haya gustado y nos vemos en el siguiente post.

