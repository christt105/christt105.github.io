---
title: "Primer día de fracaso con mi impresora 3D"
description: "Compré una Ender 3 Max de segunda mano por unos 60 euros y el primer día fue un desastre: primera capa irregular, hilos por todas partes y una retracción que no funciona."
date: 2026-11-23
image: cover.png
keywords:
  - Impresora 3D
  - Ender 3 Max
  - Ender 3
  - Stringing
  - Retracción
  - Calibración
  - Primera capa
readingTime: true
comments: true
categories:
  - Impresora 3D
tags:
  - ender-3
  - 3d-printing
---
Este es el día uno de una serie de diarios que quiero hacer con la nueva impresora que me he comprado. Se la he comprado a mi primo por unos 60 euros, que se quería deshacer de ella y comprarse una Bambu Lab para tener multimaterial y no perder tanto tiempo en el mantenimiento. Es una Ender 3 Max a la que le ha hecho algunas modificaciones que están muy bien. Es absurdamente grande, más de lo que esperaba.

Ya tuve una Anet A8 hace muchísimos años. La monté yo mismo y acabé vendiéndola porque no la usaba: cuando iba a imprimir algo siempre tenía que dedicarle un montón de mantenimiento. Sé que esta también lo tiene, pero la compré básicamente para volver a quitarme el gusanillo de la impresión 3D y hacer cuatro gilipolleces.

El primer día ha sido un fracaso.

## Primera capa: empezamos regular

Primero apreté tuercas y ajusté lo básico, y lancé una impresión de prueba: la primera capa en las cuatro esquinas y en el centro de la cama. Se ve bien en general, pero hay irregularidades. Creo que es un tema de calibración, porque la boquilla estaba demasiado pegada a la cama. Es lo único del día que salió medianamente bien.

![Cuadrados de prueba de la primera capa en las esquinas y el centro de la cama](first-layer-five-squares.jpg)

![Un cuadrado con la primera capa irregular](first-layer-uneven-square.jpg)
![Otro cuadrado de prueba, con una zona claramente peor](first-layer-worse-square.jpg)

## Temperatura: empiezan los hilos

Después hice una torre de temperatura y ahí ya empecé a ver cosas feas. Salían muchísimos hilos, por todas partes, y me puse un poco nervioso.

Una torre de temperatura es una pieza que se imprime en varios tramos, cada uno a una temperatura distinta (aquí de 195 a 220 grados). La idea es comparar los tramos y quedarte con la temperatura que mejor funciona para ese filamento. Importa porque el plástico más caliente es más líquido y gotea más por la boquilla, que es justo lo que forma los hilos (stringing). Si el problema fuera solo la temperatura, bastaría con bajarla hasta que los hilos desaparecieran sin que la pieza empezara a fallar por falta de fusión.

![Torre de temperatura, de 195 a 220 grados](temperature-tower.jpg)

Como se ve en la imagen, hay muchísimos hilos. Donde menos hay es a 195 °C, la temperatura más baja, que además está ligeramente por debajo del mínimo que recomienda el vendedor del filamento. La temperatura influye mucho, pero la impresora no debería imprimir así. Aun así, nos da muchas pistas para identificar el problema.

## Retracción: desastre total

Estuve investigando y parecía un tema de retracción.

La retracción es cuando el extrusor tira un poco del filamento hacia atrás justo antes de que el cabezal se desplace sin imprimir. Así se alivia la presión dentro de la boquilla y no gotea plástico por el camino. Si la retracción no hace bien su trabajo, quedan hilos finos entre las partes de la pieza, que es exactamente lo que me estaba pasando. Se configura con la distancia (cuánto filamento retrae) y la velocidad, y la forma habitual de ajustarla es una prueba de retracción: una pieza que se imprime con distintas distancias y donde buscas el valor con menos hilos.

Así que hice esa prueba. Salió fatal, toda fatal, desde el 0 hasta el 6 que probé. La Ender tiene un extrusor Bowden, que funciona distinto a uno directo, y el tema de la retracción es algo importante a tener en cuenta, pero como se ve, no hubo ningún cambio.

![Prueba de retracción llena de hilos](retraction-test-stringing.jpg)

Para rematar, al acabar una impresión la boquilla sigue extruyendo filamento y se queda un hilo colgando de la impresora. Lo cual me daba algo de pista sobre el problema que estaba pasando.

![Un hilo de filamento colgando de la boquilla al terminar](filament-string-hanging-from-nozzle.jpg)

## La pieza de mi hermana

Luego imprimí una pieza que quería mi hermana para no sé qué del laboratorio. Salió bastante mal, pero como no era algo definitivo lo dejé así, y menos mal, porque me ha dicho que hay que cambiar cosas. Tiene hilos que se pueden cortar y lijar, pero no debería imprimir así.

Hay otro problema, que no es tanto de la impresora: la pieza tiene mucho voladizo, y los hilos se quedaban colgando entre las partes.

![La pieza de mi hermana vista desde arriba, con hilos cruzados](sister-part-top-view.jpg)
![Los hilos entre los voladizos](sister-part-stringing-overhangs.jpg)
![La pieza de mi hermana de frente](sister-part-front-view.jpg)
![Otra vista de la pieza, con hilos en el aire](sister-part-strings-in-air.jpg)

![Dos barras unidas por hilos en el aire](bridge-bars-strings.jpg)

## Un poco de alegría: la pieza del cajón

Para que no fuera todo negativo, imprimí la típica pieza de IKEA para sujetar los tornillos de un cajón que se rompía cada dos días, de la que me faltaba una.

![La pieza en la cama](ikea-part-on-bed.jpg)
![La pieza recién terminada](ikea-part-finished.jpg)
![La pieza sobre la mesa](ikea-part-on-table.jpg)
![Las dos mitades de la pieza](ikea-part-two-halves.jpg)

La que elegí era un poco más ancha que la original, pero encaja bien, y que sobresalga un poco solo se nota al abrir el cajón.

![La pieza colocada en el cajón](ikea-part-in-drawer.jpg)

Es una pieza que, si se la hubiera pedido a IKEA, me habrían dado diez gratis, pero bueno, me ha dado cierto gustillo haberla impreso yo.

## Conclusión

Un primer día bastante malo, pero es un poco la gracia de esta impresora. Tiene solución y seguro que puede funcionar muchísimo mejor. Nos vemos en el siguiente día, a ver si consigo arreglarlo.
