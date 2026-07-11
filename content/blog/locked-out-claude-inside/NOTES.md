# Notas completas — material para el post (NO publicar, solo referencia)

Este archivo recoge TODA la información técnica real de lo que pasó el 2026-06-07
con el home server "casa" (Debian 13). Sirve como fuente para escribir el post
`index.es.md`. No se renderiza como post aparte porque no tiene frontmatter, pero
si algún día molesta, moverlo fuera de `content/`.

---

## 1. La máquina y el síntoma

- Home server: mini PC, Debian 13, hostname "casa". Interfaz de red: `enp3s0`.
- Servicios en Docker; Jellyfin va en `network_mode: host` (por eso es el más
  sensible al estado de la red del host).
- Síntoma: tras cada corte de luz o reinicio, la red quedaba rara y los
  contenedores arrancaban mal (se levantaban pero no del todo; había que
  reiniciarlos a mano).
- Sospecha inicial del usuario: empezó al cambiar de ISP a **Digi** (usa PPPoE) y
  tras bajar la **MTU a 1492** por una recomendación. Con 1492 había lag por SSH;
  con 1500 iba fino, pero daba miedo reiniciar por si se perdía el acceso.

## 2. Diagnóstico real (la causa)

- **La MTU NO era el problema de fondo.** El 1492 del PPPoE solo aplica al equipo
  que TERMINA el PPPoE (el router de Digi). Esta máquina es un cliente más de la
  LAN: no tiene interfaz `ppp0`, así que su MTU correcta es **1500**.
- **Causa raíz: tres gestores de red peleándose por `enp3s0`:**
  - `systemd-networkd` → IP estática `192.168.1.15`
  - `ifupdown` (`/etc/network/interfaces`) + `dhcpcd` → DHCP, daba `192.168.1.246`
  - Resultado: **IP duplicada** (.15 y .246 a la vez), MTU inconsistente y
    arranque no determinista. Por eso fallaba justo después de reiniciar.
- IPv6 funcionó en todo momento (default route por RA, `fe80::be7e:...`). Esto fue
  clave: mantuvo viva la sesión de Claude aunque IPv4 se cayera.

## 3. El fix aplicado (persistente en disco)

Archivos finales:

`/etc/systemd/network/20-wired.network`
```
[Match]
Name=enp3s0

[Network]
Address=192.168.1.15/24
Gateway=192.168.1.1
DNS=1.1.1.1 8.8.8.8

[Link]
MTUBytes=1500
```

`/etc/network/interfaces` → limpiado, solo gestiona `lo` (ya no toca `enp3s0`).

`/etc/docker/daemon.json`
```json
{
  "mtu": 1500,
  "default-network-opts": {
    "bridge": { "com.docker.network.driver.mtu": "1500" }
  }
}
```

Servicios: `networking.service` (ifupdown) **disabled**; `dhcpcd` parado.
Backups en: `/root/net-fix-backup-20260607-161738/`.
Script idempotente usado: `/tmp/fix_homeserver_net.sh` (OJO: `/tmp` se borra al
reiniciar, no es persistente).

## 4. EL INCIDENTE (el corazón del post)

- El script, en su paso de limpieza, ejecutó:
  ```bash
  ip addr del 192.168.1.246/24 dev enp3s0
  ```
- Al borrar esa IP secundaria (que compartía subred con la .15), el kernel se
  llevó por delante la **ruta de enlace de la LAN** `192.168.1.0/24` y, con ella,
  la **default route**.
- Efecto inmediato: **SSH congelado e IPv4 caída.** El usuario quedó bloqueado
  fuera de su propia máquina: Termius (consola Android) congelado, sin monitor a
  mano y sin ganas de ir a conectar pantalla.
- **Pero la sesión de Claude seguía dentro** porque aguantó por IPv6. Es decir: el
  dueño fuera, a oscuras, hablando con la IA que sí tenía las manos dentro de la
  máquina y podía seguir actuando.
- Lección documentada: **nunca hacer `ip addr del` de una IP que comparte subred
  sin entender el recálculo de rutas.** Mejor `networkctl reconfigure`.

## 5. EL RESCATE (sin sudo)

- No se podía usar `sudo` sin escribir la contraseña, y escribirla en el chat la
  habría dejado en el transcript → se descartó por seguridad.
- Truco que salvó la situación: el usuario está en el grupo **`docker`**, que es
  equivalente a root. Un contenedor con red del host y `NET_ADMIN` puede modificar
  la tabla de rutas del HOST sin sudo:
  ```bash
  docker run --rm --network host --cap-add NET_ADMIN busybox \
    ip route add 192.168.1.0/24 dev enp3s0 src 192.168.1.15
  ```
- Al volver la ruta de la LAN, `systemd-networkd` reinstaló la default route solo.
  Red recuperada en vivo, **sin reboot y sin monitor**.

## 6. Verificación final (read-only, sin sudo)

```bash
ip -br addr show enp3s0                        # única IPv4 192.168.1.15/24
ip link show enp3s0 | grep -o 'mtu [0-9]*'     # mtu 1500
ip route show default                          # default via 192.168.1.1 dev enp3s0
ip route show | grep '192.168.1.0/24'          # ruta LAN presente
networkctl status enp3s0 | grep State          # routable (configured)
docker run --rm --network host busybox ping -c2 1.1.1.1   # internet IPv4 real
docker ps --format '{{.Names}}\t{{.Status}}'   # contenedores healthy
```

Resultado: IPv4 OK, `State: routable (configured)`, sshd escuchando en
`0.0.0.0:22` y `[::]:22`, todos los contenedores sanos.

Nota: en un "susto" posterior el usuario creyó que no podía entrar por SSH, pero
`uptime` mostró "up 8 days" (la máquina NUNCA se reinició) y la red estaba sana
del lado servidor → era cosa del cliente (Termius con la sesión vieja congelada).

## 7. Ángulos / reflexiones para el post

- El mito de la MTU 1492 y por qué no aplicaba aquí.
- No fiarse de consejos sueltos de internet; entender qué hace cada comando antes
  de ejecutarlo (el `ip addr del` fue justo eso).
- El mundo de las redes se siente alienígena para un novato.
- Seguridad y confianza: dar acceso real a una IA a tu servidor. El chiste de
  "me robarás los datos para vendérselos a Trump" + el punto serio de no exponer
  la contraseña en el transcript.
- Grupo `docker` = root: doble filo, te salva y a la vez da miedo.
- La sensación rara de estar bloqueado fuera de tu propia máquina mientras la IA
  trabaja dentro. ¿Comodidad? ¿Vértigo?

## 8. Enlaces internos sugeridos

- "Seis meses con mi primer servidor casero" (`/six-months-with-my-first-home-server/`)
- "Un mes con Claude" (`/one-month-with-claude/`)

## 9. Avisos

- Las credenciales/accesos mencionados YA están cambiados (aviso del usuario).
- `draft: true` en `index.es.md` hasta que esté redactado.
- Falta `cover.webp`. Candidata: `claude_in_home_server.jpg` (está en la carpeta
  de one-month-with-claude).
