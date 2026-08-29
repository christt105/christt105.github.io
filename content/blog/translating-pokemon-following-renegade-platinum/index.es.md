---
title: Cómo traduje Pokémon Following Renegade Platinum
description: Cómo traduje al español Pokémon Following Platinum y cómo combiné esa traducción con la de Drakyem de Pokémon Renegade Platinum para tener Pokémon Following Renegade Platinum en castellano.
date: 2026-08-29
image: cover.webp
keywords:
  - Pokémon
  - Renegade Platinum
  - Following Platinum
  - romhack
  - traducción
  - thenewpoketext
readingTime: true
comments: true
draft: true
categories:
  - Pokémon Following Renegade Platinum
tags:
  - Pokémon
  - romhack
---
Vamos a recuperar un proyecto de hace varios años del que estoy bastante orgulloso.

## Cómo empezó todo

Me apetecía jugar a la cuarta generación de Pokémon pero quería que fuera algo diferente y con mecánicas de calidad de vida. Investigando me encontré con Pokémon Renegade Platinum, una modificación de Pokémon Platino con más dificultad y muchas más mejoras, hecha por Drayano. También encontré un proyecto de dos españoles, Mikelan98 y AdAstra, llamado Pokémon Following Platinum, una modificación de Pokémon Platino que añadía la mecánica tan característica de Pokémon HeartGold y SoulSilver de que te siguen los Pokémon en el mundo. También añadía alguna mejora como el tipo hada y un poco más. Finalmente, había una persona que había juntado ambos parches y había hecho un parche que incluía los Pokémon que te siguen en el Renegade Platinum. Yo quería eso. Había un problema, estaba en inglés y me daba mucha pereza jugarlo con los ataques en inglés.

El Pokémon Renegade Platinum lo tradujo Drakyem, hizo un trabajo excelente. Por otro lado, aunque los que hicieron el Pokémon Following Platinum son españoles, lo sacaron únicamente en inglés. Así que me propuse traducir el Following Platinum y luego combinar ambas traducciones en el Pokémon Following Renegade Platinum, sin tener ni idea por dónde empezar. 

Encontré un programa bastante antiguo y escondido que exportaba todos los diálogos de una ROM. Luego los podías editar y volver a introducir en el juego. Flujo completado, podía empezar. Mi idea era simple: extraer los diálogos de una ROM del Pokémon Platino en español e inglés, hacer el match de todos los diálogos, extraer los ficheros del Following Platinum y sobrescribirlos con los del juego original en español, traducir los pocos diálogos que tenía el Following Platinum y finalmente, coger los del Renegade Platinum en castellano, sobrescribirlos en el Following Renegade Platinum y añadir los del Following Platinum. Esto me daría una ROM con las traducciones de Drakyem y la mía. Manos a la obra.

## El proceso de traducción

Esto es a lo que quería llegar, con los diálogos ya en español y el Pokémon siguiéndome por el mapa:

![Diálogo en español con un Pokémon en el overworld en una cinemática en el laboratorio](following-veamos.png)

Antes de nada tocaba montar todas las ROMs que iba a necesitar: Pokémon Platino en inglés y en español, Pokémon Renegade Platinum en inglés y en español (parcheadas con el hack de Drayano) y Pokémon Following Platinum, que solo existía en inglés, así que hice una copia para trabajar sobre ella en español. Todo esto con thenewpoketext, la herramienta que exporta e importa los textos de las ROMs de Pokémon de DS. Fui escribiendo un script de Python para cada paso del proceso, así que voy a explicar qué hacía cada uno.

Con tantas ROMs y scripts moviéndose a la vez, así es como encajaba todo el proceso:

```mermaid
flowchart TD
    A["Platino EN + ES<br/>Renegade EN + ES<br/>Following EN"] -->|export.py| B["XML por<br/>cada ROM"]
    B -->|comparer.py| C["Diffs EN↔ES<br/>por parejas"]
    C -->|replace.py| D["Following ES<br/>(texto reciclado<br/>de Platino)"]
    D -->|"translate_following.py<br/>+ revisión manual"| E["Following ES<br/>(traducido)"]
    E -->|"import_following_into_<br/>followingrenegade.py"| F["Following<br/>Renegade ES"]
    C -->|"Renegade ES<br/>(Drakyem)"| F
    F -->|"thenewpoketext:<br/>patch + mkrom"| G["ROMs jugables<br/>en español"]
```

### Exportar y comparar los diálogos

Lo primero era sacar el texto de dentro de las ROMs. `export.py` llamaba a thenewpoketext para volcar los diálogos de cada ROM a un XML, y de paso usaba `msg_name_changer.py` para renombrar un par de archivos `.narc` de mensajes que en Platino salen mal ordenados si no se tocan a mano. Me costó bastante encontrar esta información en su momento.

Con todo en XML, entraba `comparer.py`. Este script cogía parejas de ROMs (Platino inglés contra Platino español, Renegade inglés contra Renegade español, Following inglés contra Following Renegade inglés, etc.) y, apoyándose en `xml_parser.py` para leer cada XML a un diccionario, comparaba diálogo a diálogo por su id. El resultado lo guardaba en dos formatos de JSON: uno con todos los cambios juntos y otro separado en tres bloques, los textos que cambian entre las dos ROMs, los que faltan en la primera y los que faltan en la segunda. Esta comparación es la base de todo el proyecto: me permitía saber exactamente qué diálogo en inglés correspondía a qué diálogo en español, y qué diálogos eran nuevos y no existían en el juego original.

Así es, más o menos, la parte que hace el reparto en esos tres bloques:

```python
def compare_files_split(files_dict1, files_dict2):
    result = {
        "changed": {},
        "missing_in_1": {},
        "missing_in_2": {}
    }

    for file_id, texts_dict1 in files_dict1.items():
        if file_id not in files_dict2:
            for text_id, text1 in texts_dict1.items():
                result["missing_in_2"].setdefault(file_id, {})[text_id] = {
                    "text1": text1,
                    "text2": None
                }
            continue

        texts_dict2 = files_dict2[file_id]

        for text_id, text1 in texts_dict1.items():
            if text_id not in texts_dict2:
                result["missing_in_2"].setdefault(file_id, {})[text_id] = {
                    "text1": text1,
                    "text2": None
                }
                continue

            text2 = texts_dict2[text_id]
            if text1 != text2:
                result["changed"].setdefault(file_id, {})[text_id] = {
                    "text1": text1,
                    "text2": text2
                }

    # ... y el mismo bucle a la inversa para rellenar "missing_in_1"

    return result
```

También hice un par de scripts de apoyo para revisar todo esto a ojo: `export_csv.py`, que vuelca todos los XML a una única tabla en csv con una columna por ROM para poder comparar rápido, y `check_max_newline.py`, que recorre los diálogos originales para calcular cuántos caracteres caben en una línea del cuadro de texto antes de que el juego meta un salto de línea automático.

### Reaprovechar la traducción de Pokémon Platino

Con la comparación hecha, `replace.py` cogía los textos en inglés de Following Platinum y Following Renegade Platinum y, allá donde coincidían con un diálogo del Platino o Renegade Platinum original, los sustituía por su equivalente en español. El resultado era una ROM casi completamente en español, salvo los diálogos nuevos que Mikelan98 y AdAstra habían escrito para Following Platinum, que no existían en el juego original y por tanto no tenían ninguna traducción con la que hacer match.

### Traducir lo nuevo de Following Platinum

Esos diálogos nuevos estaban prácticamente todos concentrados en un único archivo, el 724. No recuerdo si para entonces ya existía alguna IA como ChatGPT, imagino que sí pero ni de lejos al nivel de ahora, así que todo esto fue bastante artesano. Mi idea desde el principio era escribir los scripts necesarios para traducir las dos ROMs sin tener que hacerlo todo a mano, así que tiré de traducción automática de toda la vida: `translate_following.py` recorría ese archivo con la librería `deep_translator`, que no es más que un envoltorio en Python de traductores como Google Translate o MyMemory, y generaba un csv con el texto original y su traducción. Antes de mandar cada texto a traducir tenía que sustituir variables como el nombre del jugador o de un Pokémon por texto de relleno, si no el traductor se comía o deformaba esas marcas.

Así de simple era el csv que salía de ahí, con el id del diálogo dentro del archivo 724, el texto original y la traducción automática (la línea 5 es, de hecho, la misma frase que sale en una de las capturas de más abajo):

```csv
id;original;translated
2;......\nYour Pokémon won’t look you in the eye.;...... Tu Pokémon no te mira a los ojos.
5;...Your Pokémon is so very angry!;... ¡Tu Pokémon está muy enfadado!
20;Your Pokémon is dancing with you!;¡Tu Pokémon está bailando contigo!
```

Ese csv lo repasé entrada por entrada a mano para pulir la traducción automática, que para diálogos cortos de videojuego se equivocaba bastante. Con `import_translation_following.py` volvía a meter ese csv ya revisado dentro del XML, deshaciendo el relleno de las variables, cortando las líneas demasiado largas para que no se salieran del cuadro de texto y traduciendo a mano un puñado de textos que quedaban fuera del archivo 724 y que no merecía la pena automatizar.

### Combinar Following Platinum con Renegade Platinum

Con Following Platinum ya traducido, pasé a por Following Renegade Platinum. Aquí no hacía falta traducir nada nuevo: los diálogos de Renegade Platinum ya estaban traducidos por Drakyem, y los de Following Platinum los acababa de traducir yo, solo tenía que combinarlos. `import_following_into_followingrenegade.py` cogía la comparación entre Renegade Platinum inglés y Following Platinum inglés para saber exactamente qué diálogos añadía este último, y por cada uno de ellos copiaba su traducción ya hecha desde el XML de Following Platinum español al de Following Renegade Platinum español. El resultado era el XML completo de Following Renegade Platinum en español.

### Volver a meter todo en la ROM

El último paso, para las tres ROMs, era volver a meter el XML traducido dentro del juego con thenewpoketext, parcheando la ROM y reordenando otra vez esos archivos `.narc` de mensajes. Con eso ya tenía las ROMs jugables en español. Por el camino fui encontrando algún bug curioso, como el diálogo de Regigigas roto, que también arreglé y dejé documentado en el propio repositorio.

Quedó alguna cosa sin traducir, como los textos que van metidos dentro de imágenes en vez de en los diálogos, por ejemplo el nombre de los tipos de Pokémon en alguna pantalla, pero son detalles menores que no afectan a jugar el juego en español.

Mirando los commits, tampoco tardé tanto. El primero es del 19 de febrero de 2023, el parche de Following Platinum lo publiqué el 13 de marzo y el de Following Renegade Platinum llegó apenas tres días después, el 16 de marzo, porque ya tenía toda la traducción hecha y solo hacía falta combinarla. No fueron tres semanas seguidas dándole todos los días, hubo parones de varios días entre commits, pero para lo artesano que era el proceso, se hizo bastante rápido.

{{< github-repo-card owner="christt105" repo="PokemonFollowingRenegadePlatinumTranslation" >}}

## Classic Mode y ratio de shiny

El repositorio no se quedó parado en 2023. Más adelante añadí variantes del parche de Following Renegade Platinum sin tocar nada del proceso de traducción: unas "Classic", que revierten el cambio de tipos que introduce Drayano en Renegade Platinum para quien prefiera los tipos originales de cada Pokémon, y otras que cambian el ratio de aparición de shiny a 1/4096 o 1/512 en vez del 1/8192 de base, combinables entre sí. Sinceramente, el de la modificación del ratio de shiny no lo he sabido testear bien, no tengo una forma fiable de comprobar la probabilidad real sin jugar miles de horas o hacer fuerza bruta con un emulador, así que lo publiqué confiando en el cambio de los valores y sin poder confirmarlo del todo.

## Cómo le ha ido

Más ejemplos del resultado final:

![Diálogo en español con otro Pokémon siguiendo al protagonista frente a una casa](following-enfadado.png)
![Diálogo en español dentro de la casa del protagonista](following-laboratorio.png)

Contando solo las descargas de GitHub, sin contar el formulario de Google ni las páginas de terceros donde ha acabado subido, el parche de Following Platinum tiene más de 3700 descargas entre el patch y la ROM ya parcheada, y el de Following Renegade Platinum casi 2900 contando todas sus variantes (normal, Classic Mode y shiny). Más de 6500 descargas entre los dos, para un proyecto que hice pensando únicamente en mí mismo.

Estoy contento porque lo ha disfrutado mucha gente, incluido yo, mis amigos y mi hermana. Realmente lo ha descargado más gente de lo que reflejan esas cifras, porque ha acabado subido en páginas de terceros, donde en algunos casos no han dado créditos. Lo llegaron a jugar Xamork y Folagor, aunque no dieron créditos ninguno de los dos y publicaron la descarga directa ellos mismos. Yo lo jugué y me lo pasé con un equipo monotype psíquico.

![Hall of Fame de Pokémon Following Renegade Platinum completado con un equipo monotype psíquico](PokemonFollowingRenegadePlatinumMonotypeHallOfFame.png)

No puse la descarga directa de la ROM porque me daba algo de miedo y le tengo mucho aprecio a mi cuenta de GitHub. Igualmente se puede descargar el parche desde el repositorio o directamente en [este formulario](https://forms.gle/YwseURAufk9wccrJ9).

He disfrutado mucho de hacerlo y de que más gente lo haya disfrutado. Es un grano de arena que he aportado a la comunidad de esta franquicia que tanto me ha marcado de pequeño.

Mi hermana se lo pasó al 100%, completando una Living dex.

![Living dex completa de mi hermana, con todos los Pokémon organizados por número de Pokédex](livingdex_collage.png)
![Tarjeta de entrenador de mi hermana](sister-trainer-card.png)
![Diploma por completar la Pokédex Nacional](sister-diploma.png)

*En la tarjeta de entrenador pone que empezó la aventura en 2011, pero eso es porque no cambió la fecha de la consola, los que habéis jugado a Animal Crossing lo entenderéis.*

Y hasta aquí el post de hoy. Estoy muy contento de que haya gente, además de mí, que disfrute de lo que hago. ¡Hasta la próxima!
