---
title: Un pequeño fracaso con Zorin OS
description: Mi experiencia instalando Zorin OS a mi familia, los pequeños problemas técnicos que surgieron y por qué al final decidí volver a Windows en uno de los equipos.
date: 2026-06-11
image: cover.png
keywords:
  - Zorin OS
  - Linux
  - wifi
  - swap
  - opinión
readingTime: true
comments: true
draft: false
categories:
  - Sistemas Operativos
tags:
  - linux
  - zorin-os
  - opinion
  - reflexiones
---

¡Hola de nuevo!

Hoy os traigo un post un poco diferente, centrado en sistemas operativos y en cómo a veces intentas hacer un favor instalando Linux a tu familia y la cosa no sale como esperabas. Sí, hoy toca hablar de un pequeño fracaso.

Le instalé a mi padrastro Zorin OS porque no se acordaba de la contraseña de su Windows y, para el uso que le iba a dar, sinceramente Linux le debía de ir bien.

Estaba bastante cansado de Microsoft, así que también lo instalé en el portátil de mi pareja. Yo ya llevaba mucho tiempo con Kubuntu en mi ordenador de sobremesa pero, sinceramente, casi no lo usaba; cuando acababa de trabajar, simplemente seguía usando el ordenador del trabajo para mis cosas. Ella usa el portátil solo para Calibre y yo para trastear mientras estoy en el sofá: gestionar el servidor casero, proyectos de programación, etc. Con Windows 11, el portátil de mi pareja iba bastante mal y, al tener un único usuario, estaba todo mezclado: si clicaba en un enlace se abría Opera cuando yo uso Brave. Necesitábamos usuarios distintos y algo mucho más ligero.

## Zorin OS al rescate

Primeramente instalé Zorin OS en el ordenador de mi padrastro, ya que había leído en varias ocasiones que tenía muchísimas descargas y que la gente estaba muy contenta porque se parecía mucho a Windows. Como quería el mínimo de fricción, le metí la distro y listo.

Nada más encenderlo tuve algún problema, con el wifi si no recuerdo mal. El problema es que la tarjeta wifi es algo moderna e incompatible, en concreto una MediaTek MT7902. Lo conseguí solucionar con un *workaround* de alguien que había hecho un script, y desde entonces me desatendí.

Me gustó mucho el *look* que tenía y, un día que mi pareja no estaba, instalé Zorin OS también. Creo que para un portátil Gnome se siente muy bien y, al ser una distro basada en Ubuntu, suele funcionar sin problemas para el grueso de la gente. Lo configuré todo, creé ambos usuarios e instalé Calibre, Telegram, WhatsApp, Discord, Obsidian, Syncthing, VS Code y un cliente de Git. Añadí mi clave SSH para el mini PC y ya estaba todo funcionando.

![Pantalla de inicio de sesión de Zorin OS](LoginZorinos.png)
![Escritorio principal y barra de tareas de Zorin OS](HomeScreenZorinos.png)
![Menú de aplicaciones instaladas en Zorin OS](AppsZorinos.png)
![Vista de multitarea y organización de ventanas](multiwindow.png)

A mi pareja no le hizo mucha gracia al principio, pero como casi no toca el portátil, así está mejor ordenado. Además, puedo mantenerlo mucho más cómodamente; ella no actualiza nunca nada, y con el gestor de paquetes de Linux y la tienda de aplicaciones todo es comodísimo.

## Los problemillas del día a día

Yo estuve probándolo varios días después. Si bien es cierto que tarda más en encender (porque Windows nunca llega a apagarse del todo de forma directa), todo lo demás va muy fluido. Los gestos del trackpad iban finos y podía usarlo cómodamente. Eso sí, tuve algún que otro problema, que no todo fue perfecto.

El desplazamiento con el trackpad era demasiado rápido. Desplazabas un poco con dos dedos y la pantalla avanzaba muchísimo. Al final lo solucioné tocando un par de configuraciones.

Por otro lado, tratando de debugar un proyecto que tengo entre manos, se me congelaba el ordenador y acababa reiniciándose. El problema es que el portátil tiene 8 GB de RAM (que hoy en día parece casi una reliquia) y se queda muy corto para según qué tareas y la de pestañas que suelo tener abiertas. Esto, sumado a que el tamaño de la partición *swap* era de únicamente 2 GB, hacía que el sistema colapsara y no supiera qué hacer. Le aumenté el swap y a partir de ahí todo funcionó muy bien.

Por último, la distribución del teclado en LibreOffice me dio algún que otro problemilla, pero nada inusable. Y mi pareja se queja de que quiere iniciar sesión con el lector de huellas, pero simplemente no se puede porque no hay *drivers* para ese lector en Linux.

## La caída

Llegamos hasta el otro día, cuando mi padrastro me llamó diciendo que no le iba el internet. Y, efectivamente, no aparecía por ningún lado el icono del wifi. No sé qué pasaría, porque yo se lo dejé todo funcionando perfectamente; no sé si alguna actualización automática rompió el *workaround* del script del wifi.

Investigando un poco descubrí que ya habían sacado un *driver* oficial para esa tarjeta, pero para la versión 7.1 del kernel de Linux, mientras que Zorin OS todavía sigue en la versión 6.

Ahora me arrepiento un poco de haber instalado Zorin OS en lugar de Fedora, que habría sido similar pero con un kernel mucho más actualizado que seguramente ya daría soporte al wifi. Como no quería perder más tiempo ni causarle más dolores de cabeza a mi padrastro, le dije a mis hermanos que le instalaran Windows 11 de nuevo y me quité de líos.

Hace unas semanas preparé un USB con Windows 11 para instalarlo otra vez en el ordenador de mi pareja, ya que había hecho algunos comentarios dando a entender que no le gustaba. Iba a hacerlo, pero me esperé a que estuviera ella para preguntarle y me dijo que no, que de momento lo mantuviéramos y que ya veríamos. Así que, por esta parte, parece una victoria.

## Conclusiones

Dicho esto, es una pequeña derrota, pero la prefiero antes que hacer pasar a la familia por malas experiencias con Linux.

Yo, por mi parte, me he cambiado a PikaOS en el ordenador de sobremesa y estoy muy contento, aunque quizás me pase a la versión con KDE en lugar de Gnome. En cuanto al portátil, probablemente acabe probando Fedora, que me da bastante confianza. Mis hermanos seguramente se pasen a Linux también.

La verdad es que estoy contento con el estado actual de mis dispositivos en casa. Sé que Linux no es perfecto ni yo soy ningún experto en la materia, pero me encanta el ecosistema y la filosofía del *open source*. En casa ya tengo el portátil, el servidor casero, la Steam Deck y el de sobremesa con Linux, frente al portátil del trabajo y el del antiguo trabajo con Windows. Es un buen ratio.

Ya haré otro post profundizando en cómo tengo configurado PikaOS, que es una distro bastante simpática.

¡Nos vemos en el próximo post!