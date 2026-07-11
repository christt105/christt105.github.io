---
title: "La noche que no pude entrar en mi servidor, pero Claude sí"
description: "La historia de cómo arreglé el arranque de red de mi home server, el momento en que me quedé bloqueado fuera de mi propia máquina y Claude seguía dentro trabajando."
date: 2026-06-07
image: cover.webp
keywords:
  - home server
  - self-hosting
  - debian
  - linux
  - docker
  - claude
  - ia
  - red
  - networkd
readingTime: true
comments: true
draft: true
categories:
  - Self-hosting
tags:
  - homeserver
  - linux
  - docker
  - ia
  - claude
---

<!--
BORRADOR / GUION — escribir encima con mis palabras.
Tono: primera persona, "Hola de nuevo", honesto desde mi perspectiva de novato.
Sigue el estilo de "Seis meses con mi primer servidor casero".
-->

> Importante
>
> Esto es un post sobre mi experiencia como novato. No soy ningún experto en la
> materia, ni pretendo serlo. Solo quiero compartir lo que me pasó. Probablemente
> haga muchas cosas mal y me equivoque en algunos aspectos.

<!-- INTRO: enganchar con la imagen de estar bloqueado fuera de mi propia máquina
mientras una IA seguía dentro y yo solo podía hablar con ella. -->

## El problema que arrastraba

<!--
- Vengo del post de los 6 meses con el home server (Debian 13, mini PC, Jellyfin
  y demás en Docker).
- Desde hace un tiempo arrastro un problema molesto: cada corte de luz o reinicio,
  la red se comporta raro y los Docker arrancan mal (se levantan pero no del todo
  bien, hay que reiniciarlos a mano).
- Mi sospecha inicial: empezó al cambiar a Digi, que usa PPPoE, y que alguien me
  recomendó bajar la MTU a 1492. Eso me dio lag por SSH; con 1500 iba bien, pero
  me daba miedo reiniciar para no quedarme sin acceso.
-->

## Le pedí ayuda a Claude (y le di acceso al server)

<!--
- Quería una nota en mi Obsidian explicando el problema y la solución.
- Le di a Claude acceso real a la máquina para diagnosticar (archivos del sistema,
  sin tocar mis notas).
- Reflexión: lo raro/interesante de tener una IA "viviendo" dentro de mi servidor
  con manos de verdad. Enlazar con el post de "Un mes con Claude".
-->

## El diagnóstico: no era la MTU

<!--
- El problema NO era la MTU como yo creía.
- El mito del 1492: eso solo aplica al router que termina el PPPoE (el de Digi),
  NO a mi máquina, que es un cliente más de la LAN. Mi MTU correcta es 1500.
- La causa real: tres gestores de red peleándose por la misma tarjeta
  (systemd-networkd con IP estática vs ifupdown/dhcpcd por DHCP) -> IP duplicada
  (.15 y .246), MTU inconsistente y arranques inestables. Por eso fallaba justo
  tras reiniciar. El mundo de las redes es un campo que me parece alienigena.
-->

## El arreglo

<!--
- Dejar UN SOLO gestor de red (systemd-networkd), IP estática fija, MTU 1500,
  desactivar los otros.
- Corregir también el daemon.json de Docker (estaba en 1492).
- Backups de todo antes de tocar.
-->

## El momento en que me quedé fuera

<!--
EL CORAZÓN DEL POST.
- Al aplicar el fix en vivo, un comando borró sin querer la ruta de la LAN y la
  default route -> SSH congelado, internet IPv4 caído.
- Me quedé fuera de mi propia máquina. Termius (consola de android) congelado, sin monitor a mano, sin
  ganas de ir a conectar pantalla.
- El giro surrealista: yo estaba fuera, pero Claude seguía dentro (su conexión
  aguantó por IPv6) y podíamos seguir hablando. Yo a oscuras desde fuera,
  charlando con la IA que sí tenía las manos dentro de la máquina.
- El detalle gracioso/inquietante: me hizo gracia que Claude pudiera hacer cosas
  en mi server mientras yo no podía ni entrar. Aquí cabe mi chiste de "me robarás
  los datos para vendérselos a Trump" y la reflexión real detrás: el tema de
  seguridad (no escribir la contraseña en el chat porque queda en el transcript),
  confianza, hasta dónde dejas que una IA tenga acceso.
-->

## El rescate

<!--
- Sin sudo (no podía meter la contraseña sin exponerla), la solución fue
  ingeniosa: como mi usuario está en el grupo docker, se lanzó un contenedor con
  red del host y permisos de red que volvió a añadir la ruta que faltaba, y la red
  revivió sola.
- Reflexión de seguridad: un usuario en el grupo docker es básicamente root. Doble
  filo: me salvó, pero es justo lo que da miedo.
- aviso a hackers, ya está cambiado
-->

## Cómo quedó la cosa

<!--
- Resuelto en vivo, sin reboot ni monitor. Red estable, Docker bien, MTU correcta,
  un solo gestor de red.
- Dejamos notas escritas por si había que rescatar la sesión (guiño a que dejamos
  instrucciones por si se perdía la conversación).
-->

## Reflexión final

<!--
- Lo que aprendí: el mito de la MTU, no fiarse de consejos sueltos de internet,
  entender qué hace cada comando antes de ejecutarlo.
- Lo más jugoso: qué se siente al estar bloqueado fuera de tu propia máquina
  mientras una IA trabaja dentro. ¿Comodidad? ¿Vértigo? Pregunta abierta para el
  lector.
- Enlazar con "Un mes con Claude".
-->
