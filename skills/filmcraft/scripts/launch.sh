#!/usr/bin/env bash
# Launch FilmCraft with control port for live bridge on Linux / macOS
set -euo pipefail

PORT=${1:-50051}
CLI=${FILMCRAFT_CLI:-filmcraft-cli}
APP=${FILMCRAFT_BIN:-filmcraft}

if ! command -v "$APP" >/dev/null 2>&1; then
    if [ -x "/Applications/FilmCraft.app/Contents/MacOS/filmcraft" ]; then
        APP="/Applications/FilmCraft.app/Contents/MacOS/filmcraft"
    else
        echo "FilmCraft executable not found" >&2
        exit 2
    fi
fi

if pgrep -x filmcraft >/dev/null 2>&1; then
    if "$CLI" --bridge "127.0.0.1:$PORT" inspect >/dev/null 2>&1; then
        echo "FilmCraft is already running and listening on control port $PORT."
        exit 0
    else
        echo "Warning: FilmCraft is already running, but control port $PORT is not responding." >&2
        echo "Please close the existing instance and relaunch." >&2
        exit 1
    fi
fi

echo "Starting FilmCraft on port $PORT..."
"$APP" --control "$PORT" &

for i in $(seq 1 15); do
    sleep 0.8
    if "$CLI" --bridge "127.0.0.1:$PORT" inspect >/dev/null 2>&1; then
        echo "FilmCraft successfully launched and ready on 127.0.0.1:$PORT!"
        exit 0
    fi
done

echo "Warning: FilmCraft started, but control port $PORT did not respond within timeout." >&2
exit 1
