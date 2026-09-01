#!/usr/bin/env sh
# LAN preview for the blog: hugo rebuilds public_preview/ on every save,
# a throwaway nginx (host Docker) serves it at http://192.168.1.15:8098/.
# Usage: ./preview.sh up|down|status|logs
set -eu

cd "$(dirname "$0")"

NAME="christt105-blog-preview"
PORT="8098"
HOST_IP="192.168.1.15"
LABEL="managed-by=claude-preview"
HOST_SRC="/home/christian/Projects/christt105.github.io/public_preview"
DEST="public_preview"
PIDFILE="/tmp/christt105-blog-preview-hugo.pid"
LOGFILE="/tmp/christt105-blog-preview-hugo.log"

url="http://$HOST_IP:$PORT"

stop_hugo() {
  if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    kill "$(cat "$PIDFILE")"
  fi
  rm -f "$PIDFILE"
}

case "${1:-}" in
  up)
    stop_hugo
    if ! hugo --buildDrafts --destination "$DEST" --quiet 2>"$LOGFILE"; then
      echo "hugo build failed, see below (nothing started):" >&2
      cat "$LOGFILE" >&2
      exit 1
    fi
    nohup hugo --watch --buildDrafts --destination "$DEST" >"$LOGFILE" 2>&1 &
    echo $! > "$PIDFILE"
    docker rm -f "$NAME" >/dev/null 2>&1 || true
    docker run -d \
      --name "$NAME" \
      --label "$LABEL" \
      --label "preview-url=$url" \
      --restart no \
      -p "$PORT:80" \
      -v "$HOST_SRC:/usr/share/nginx/html:ro" \
      nginx:alpine >/dev/null
    echo "up      -> $url   (rebuilds on save, drafts included; refresh the tab after each edit)"
    ;;
  down)
    stop_hugo
    if docker rm -f "$NAME" >/dev/null 2>&1; then
      echo "down    -> removed $NAME"
    else
      echo "down    -> $NAME was not running"
    fi
    ;;
  status)
    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
      echo "hugo watch: running (pid $(cat "$PIDFILE"))"
    else
      echo "hugo watch: not running"
    fi
    docker ps --filter "name=$NAME" --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
    ;;
  logs)
    tail -n 50 "$LOGFILE" 2>/dev/null || echo "no hugo log yet"
    ;;
  *)
    echo "Usage: $0 up|down|status|logs" >&2
    exit 1
    ;;
esac
