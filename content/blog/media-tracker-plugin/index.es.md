---
title: "En busca del registro multimedia definitivo: ahora es personal"
description: "Dije que la tercera parte sería la última, pero he vuelto. Con la ayuda de Claude he reescrito mi Media Tracker: un plugin de Obsidian que sustituye a los scripts y el tema de Hugo dividido para que cualquiera pueda tener el suyo."
date: 2026-06-24
image: cover.png
keywords:
  - Obsidian
  - Hugo
  - Media Tracker
  - Plugin
  - Claude
  - TMDB
  - TheTVDB
  - IGDB
  - Automatización
readingTime: true
comments: true
categories:
  - Media Tracker
tags:
  - Obsidian
  - Obsidian-plugin
  - Hugo
  - Automation
  - Self-hosted
---

Hola de nuevo. Sé lo que estáis pensando: "dijiste que la tercera parte era la última". Y lo era. Pero al final de [aquel post](../media-tracker-hugo) dejé una lista de cosas que me gustaría hacer "algún día", y resulta que ese día ha llegado. Así que considerad esto un epílogo inesperado de la serie "En busca del registro multimedia definitivo".

La novedad es que esta vez no he ido solo. He reescrito buena parte del Media Tracker con la ayuda de [Claude](../one-month-with-claude), y eso ha cambiado las cuentas: cosas que antes no merecía la pena hacer porque "nadie las iba a usar" de repente sí merecían la pena, porque hacerlas ya no me costaba semanas. Os cuento qué he cambiado y cómo está el proyecto ahora mismo.

## El problema que arrastraba

Si recordáis los dos posts anteriores, mi Media Tracker tenía dos mitades:

1. **Obsidian**, donde creo y edito cada película, serie o juego. Funcionaba a base de pegar tres plugins ([Templater](obsidian://show-plugin?id=templater-obsidian), [Movie Search](obsidian://show-plugin?id=movie-search) y [QuickAdd](obsidian://show-plugin?id=quickadd)) y un puñado de scripts en JavaScript hechos a medida.
2. **Hugo**, que convierte esas notas en [la web](https://christt105.github.io/MediaTracker/).

Las dos funcionaban, pero las dos tenían el mismo defecto: eran **imposibles de compartir**. Para que otra persona montara lo mismo tenía que clonar mi vault, instalar plugins concretos, importar paquetes de QuickAdd, configurar scripts uno a uno y, encima, pelearse con un repositorio de Hugo donde el contenido y el tema estaban mezclados. Yo mismo lo dije en el post anterior: *"debería haber sido un plugin"* y *"otra cosa importante es separar el theme de la página"*. Pues eso es justo lo que he hecho.

## La mitad de Obsidian: un plugin de verdad

Lo primero ha sido tirar a la basura los scripts y los tres plugins, y meterlo todo en un único plugin nativo de Obsidian: **[hugo-mediatracker-plugin](https://github.com/christt105/hugo-mediatracker-plugin)**.

Ahora no hay nada que cablear. Instalas el plugin, abres sus ajustes, pones tus claves de API y ya está. Tiene su propia pantalla de configuración nativa, comandos, iconos en la barra lateral y hotkeys configurables.

{{< github-repo-card owner="christt105" repo="hugo-mediatracker-plugin" >}}

![Pantalla de ajustes nativa del plugin](PluginSettings.png)

Lo que hace, a grandes rasgos:

- **Películas y series:** buscas en **[TMDB](https://www.themoviedb.org/)** o **[TheTVDB](https://www.thetvdb.com/)** y crea la nota con póster, banner, géneros, reparto, director, sinopsis y demás. Puedes elegir qué proveedor usa cada tipo; lo típico (como en Jellyfin) es TMDB para películas y TheTVDB para series.
- **Series con temporadas bien numeradas:** TheTVDB respeta la numeración real de las temporadas, algo que se agradece muchísimo con el anime y las series partidas, donde TMDB lo mete todo en una sola temporada.
- **Videojuegos:** busca en **[IGDB](https://www.igdb.com/)** y, si el juego está en Steam, usa el arte oficial automáticamente.
- **Temporadas:** desde la nota de una serie abierta, genera la nota de la temporada enlazada en un comando, igual que hacía el viejo script de QuickAdd.
- **Actualizar imágenes:** cambia la portada o el banner eligiendo de una galería paginada, con **[SteamGridDB](https://www.steamgriddb.com/)** para los juegos.

![Buscador de películas y series del plugin](PluginAddMovie.png)

Una cosa que me gusta especialmente es que no inventa un formato nuevo: las notas que crea llevan **exactamente las propiedades que espera el tema de Hugo**, así que la otra mitad del sistema sigue funcionando sin tocar nada. Y para los que usáis [Pretty Properties](obsidian://show-plugin?id=pretty-properties), las portadas y banners se ven igual de bien que antes.

![Nota creada por el plugin, con Pretty Properties mostrando portada y banner](PluginNote.png)

Se instala con [BRAT](https://github.com/TfTHacker/obsidian42-brat), así que se actualiza solo. El viejo [media-tracker-obsidian-template](https://github.com/christt105/media-tracker-obsidian-template), con sus scripts y plugins preinstalados, lo he **archivado**: ya no hace falta para nada y solo lo dejo como referencia histórica.

Quería hacer especial mención al plugin [Gubchik123/obsidian-movie-search-plugin](https://github.com/Gubchik123/obsidian-movie-search-plugin), ya que gran parte del flujo lo saqué de aquí.

## La mitad de Hugo: dividir el tema

La segunda gran tarea pendiente era separar el tema del contenido. Antes todo vivía en el mismo repositorio porque, como expliqué, no me compensaba el tiempo de hacerlo "bien" para que nadie lo usara. Ahora lo he partido en **tres** piezas siguiendo el patrón de [módulos de Hugo](https://gohugo.io/hugo-modules/):

```
hugo-mediatracker-theme   →  el tema reutilizable (módulo de Hugo)
mediatracker-starter      →  plantilla "Use this template" lista para clonar
MediaTracker              →  mi contenido personal + el script de migración
```

- **[hugo-mediatracker-theme](https://github.com/christt105/hugo-mediatracker-theme)** es el tema, ya como módulo independiente construido sobre [hugo-blog-awesome](https://github.com/hugo-sid/hugo-blog-awesome). Para usarlo solo hay que añadir un bloque en el `hugo.toml`; las actualizaciones del tema base siguen llegando solas.
- **[mediatracker-starter](https://github.com/christt105/mediatracker-starter)** es una plantilla de GitHub: le das a "Use this template", `hugo server`, y tienes una web funcionando con un par de ejemplos de cada tipo. Esto es lo que ahora puedo enseñar a la gente en lugar de mi repositorio personal lleno de cosas mías.
- **[MediaTracker](https://github.com/christt105/MediaTracker)** se queda solo con mi contenido, mi configuración y el `migration.py`.

{{< github-repo-card owner="christt105" repo="mediatracker-starter" >}}

![Sitio de ejemplo levantado con mediatracker-starter](StarterDemo.png)

## Y de paso, casi toda la lista de "algún día"

Ya que estaba metido en harina y con Claude al lado, aproveché para tachar prácticamente todos los "próximos pasos" que dejé en el post anterior:

- **Tipos de medios por datos.** Antes, añadir un tipo nuevo (por ejemplo, "libros") significaba tocar como ocho archivos. Ahora hay un único `data/media_types.yml`: añades un bloque ahí y una entrada de menú, y listo. Las plantillas leen de ese archivo en vez de tener la lista de tipos escrita a mano por todas partes.
- **Nueva API para libros.** Para todos aquellos amantes de los rectángulos de conocimiento he intentado [Open Library](https://openlibrary.org/) para poder crear notas de libros muy fácilmente.
- **Estados normalizados.** Los estados eran literales en español (`Acabado`, `En Curso`...) repartidos por la lógica de las plantillas. Ahora son claves canónicas (`finished`, `in_progress`, `paused`, `dropped`, `not_started`) y las etiquetas visibles salen de los archivos de traducción. Esto deja preparado el terreno para tener la web en varios idiomas.
- **Búsqueda y filtros.** Era lo que más ilusión me hacía. He quitado las secciones separadas por tipo y ahora la página principal tiene una **barra de filtros** (tipo, estado, nota, género, plataforma, año) y un **buscador** que funciona del lado del cliente. Una sola pantalla para verlo todo.

![Barra de filtros y buscador en la página principal](FilterSearch.png)

- **Estadísticas.** Hay una página de estadísticas con distribución de notas, desglose por año, gráficos de plataformas y secciones específicas para anime y cine. Era una de esas cosas "tontas pero que me hacían ilusión", como el generador de collages.

![Página de estadísticas](Stats.png)

- **Tarjetas sociales arregladas.** Antes, al compartir un enlace, no salía la portada porque el `og:image` apuntaba a un sitio que no existía. Ahora las tarjetas de redes muestran portada y un fragmento de mi reseña.

![Vista previa de una tarjeta social al compartir una entrada](SocialCard.png)

- **RSS mejorado.** Los feeds llevan ahora miniaturas de las portadas, y sigue habiendo un feed dedicado solo para lo acabado (el que avisa al bot de Discord).

## El pipeline actual

Con todo esto, el flujo completo queda así:

```
Obsidian + hugo-mediatracker-plugin   ← creo y edito las notas
        │  (Syncthing sincroniza el vault al mini PC)
        ▼
scripts/migration.py                  ← convierte el vault a contenido de Hugo
        │  (cron diario a las 9:00 → git push)
        ▼
hugo-mediatracker-theme               ← pinta la web a partir del contenido
        │
        ▼
GitHub Actions → GitHub Pages         ← compila y publica
```

La parte de automatización del [post anterior](../media-tracker-hugo) sigue igual: el cron del mini PC ejecuta el script cada mañana, y si hay cambios hace `commit` y `push`. La diferencia es que ahora la mitad de Obsidian es un plugin de verdad y la mitad de Hugo es un tema que cualquiera puede usar.

## Trabajar con Claude

No quiero pasar de puntillas por esto, porque es la razón de que este post exista. Ya conté en el post anterior que "la mayoría de cambios los ha hecho la IA", pero esto ha sido otro nivel. Buena parte de la reescritura, el plugin entero, la división en módulos, la generalización de los tipos, la he hecho prácticamente Claude.

Lo interesante no es que escriba código, sino cómo cambia la decisión de **qué vale la pena hacer**. Cosas que llevaba meses aparcando con la excusa de "no tengo tiempo y nadie lo va a usar" pasaron a ser tardes sueltas.

Muchas de estas funcionalidades les decía a Claude desde el móvil que las hiciera, que lo levantara localmente y lo probara. Todo hecho y comprobado por Claude, hasta que lo levantaba y yo lo probaba en el movil, hacia una Pull Requets, revisaba por encima y le decía que la mergeara. Un bucle en el que yo no estaba ni en mi casa, simplemente lo tenía en mi ordenador con acceso a mis proyectos.

## Estado actual y lo que queda

Para ser honesto, no está todo cerrado:

- La web sigue teniendo el **contenido solo en español**. La interfaz ya es traducible (las cadenas están en archivos de i18n), pero traducir cada entrada es otro asunto. De momento se queda en español.
- Aún tengo ideas en la recámara: un calendario con los elementos por día, elementos relacionados más currados, y seguir afinando la lógica de series y temporadas.

Pero lo importante para mí ya está: **cualquiera puede montar esto**. Si quieres tu propio Media Tracker, instala el [plugin](https://github.com/christt105/hugo-mediatracker-plugin) en Obsidian y clona la [plantilla](https://github.com/christt105/mediatracker-starter) de Hugo. Y si te animas, déjame una estrella en los repos o cuéntame qué te parece en los comentarios; esta vez sí que va a servir para que más gente lo use.

Espero que os haya gustado este epílogo. Ahora sí, nos vemos en el siguiente post.

¡Hasta la próxima!
