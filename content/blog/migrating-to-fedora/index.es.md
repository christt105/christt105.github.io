---
title: "De Zorin OS a Fedora: Crónica de una migración y un USB rebelde"
description: Mi experiencia migrando el portátil a Fedora, los problemas inexplicables con el pendrive de instalación y mis primeras impresiones con la distro del sombrero.
date: 2026-07-01
image: cover.png
keywords:
  - Fedora
  - Zorin OS
  - Linux
  - boot
  - USB
  - instalación
readingTime: true
comments: true
draft: false
categories:
  - Sistemas Operativos
tags:
  - linux
  - zorin-os
  - fedora
  - instalacion
  - opinion
---

## Puntos clave de esta migración

Antes de entrar en detalles, aquí os dejo un resumen rápido de lo que ha sido este proceso:

* **La decisión:** Tras el sabor agridulce con Zorin OS (especialmente por el tema de kernels antiguos y soporte de hardware moderno como el wifi), decidí dar el salto a Fedora en el portátil.
* **El obstáculo del USB:** Preparar el instalador fue un dolor de cabeza inesperado. El pendrive se quedaba colgado indefinidamente en la pantalla de boot de Fedora.
* **La solución al arranque:** Tuve que pelearme con el formateo de la imagen y ajustar un par de cosas en la BIOS (como desactivar el Secure Boot) y usar el modo de gráficos básicos para que por fin cargara el instalador.
* **El sistema final:** Fedora 40/41 con Gnome va como un tiro. Y lo mejor de todo: la tarjeta de red funciona de serie sin scripts raros.

---

¡Hola de nuevo!

Como ya os adelanté en el post anterior donde os contaba mi pequeño fracaso con Zorin OS, tenía claro que el siguiente paso para el portátil de casa era probar Fedora. La verdad es que Zorin se ve genial, pero quedarte estancado en un kernel antiguo cuando tienes hardware moderno en casa es una receta para el desastre. 

Así que, aprovechando un rato libre este fin de semana, me dispuse a realizar la migración. Spoiler: no fue soplar y hacer botellas.

## El misterio del pendrive rebelde

Para empezar, me bajé la ISO de Fedora Workstation. Como suelo hacer siempre, agarré un pendrive viejo que tengo por el escritorio y quemé la imagen. 

Aquí empezó la pesadilla. Conecté el USB al portátil, lo encendí, seleccioné arrancar desde el dispositivo USB y... nada. Se quedaba congelado de forma indefinida en la pantalla de boot de Fedora. Esa pantalla de carga oscura con el logo de Fedora y la ruedita dando vueltas (o a veces ni eso, se quedaba el cursor parpadeando arriba a la izquierda en plan dramático).

La verdad es que al principio pensé que era cosa del propio USB. A veces estos pendrives promocionales baratos fallan más que una escopeta de feria. Así que busqué otro pen de mejor calidad, lo volví a flasear usando Ventoy, y lo volví a intentar. Mismo resultado. Se quedaba ahí colgado, riéndose de mí.

Decidí cambiar de táctica y usar la herramienta oficial, **Fedora Media Writer**, en lugar de Ventoy o Rufus. Además, entré en la BIOS del portátil para desactivar el *Secure Boot*, que a veces se pone un poco tonto con distros que no son Ubuntu o Windows. 

Por último, en el menú de arranque de Fedora (Grub), en lugar de darle a la opción por defecto, entré en la sección de *Troubleshooting* (resolución de problemas) y seleccioné **Start Fedora in basic graphics mode** (arrancar Fedora en modo de gráficos básicos). No sé si fue por la herramienta oficial, el Secure Boot o el modo de gráficos básicos, pero la pantalla de carga por fin avanzó y me planté en el instalador de Fedora. ¡Menudo alivio!

## Instalación y puesta a punto

Una vez dentro del instalador de Fedora, todo fue como la seda. Anaconda (el instalador de Fedora) ha mejorado bastante su interfaz y ahora es súper intuitivo. Creé las particiones de nuevo (esta vez asegurándome de dejar una partición swap decente de 8 GB para evitar que se me congele la RAM al abrir dos pestañas de VS Code) y le di a instalar.

En unos diez minutos ya tenía el ordenador reiniciado y con el escritorio limpio de Fedora listo para trastear.

Lo primero que hice, obviamente, fue comprobar si el wifi funcionaba. Y efectivamente: al llevar un kernel de Linux muy actualizado (la versión 6.8+ frente al kernel 6.2 que arrastraba Zorin), reconoció la tarjeta MediaTek al instante. Sin scripts de GitHub de dudosa procedencia y sin miedo a que una actualización me rompa la conexión. ¡Esto sí que es vida!

## Primeras sensaciones

Por ahora la verdad es que estoy encantado. Gnome puro en Fedora se siente extremadamente fluido y limpio. He vuelto a configurar todo el ecosistema que compartimos:

* **Flatpaks** habilitados en la tienda de software (imprescindible para Calibre, Discord y Spotify).
* **Syncthing** configurado en segundo plano para sincronizar mi vault de Obsidian.
* **VS Code** y el cliente de Git listos para cuando me entra el gusanillo de programar desde el sofá.

Aunque a mi pareja le da un poco igual la distribución mientras pueda abrir Calibre y sus libros, agradezco mucho tener un sistema con paquetes actualizados y un ciclo de soporte robusto.

Sé que no soy ningún experto en Fedora (siempre he sido más de la familia de Debian/Ubuntu), pero la estabilidad y frescura que transmite esta distro me está gustando mucho. Ya os iré contando si surgen más problemillas en el día a día.

¿Y vosotros? ¿Habéis tenido problemas raros al bootear Fedora desde un USB? ¡Nos vemos en el próximo post!
