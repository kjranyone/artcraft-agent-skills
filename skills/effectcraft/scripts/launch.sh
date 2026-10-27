#!/usr/bin/env bash
# Launch EffectCraft with a control port for the live bridge (Linux/macOS).
# No control token is required (unlike FilmCraft).
# Usage: launch.sh [port]     (default 50052)
set -u

PORT=${1:-50052}
BIN=${EFFECTCRAFT_BIN:-effectcraft}
CLI=${EFFECTCRAFT_CLI:-effectcraft-cli}

command -v "$BIN" >/dev/null || { echo "launch: $BIN not found" >&2; exit 2; }

if pgrep -x effectcraft >/dev/null 2>&1; then
  if "$CLI" --bridge "$PORT" info >/dev/null 2>&1; then
    echo "EffectCraft is already running and listening on control port $PORT."
    exit 0
  fi
  echo "launch: EffectCraft is already running without the control port." >&2
  echo "Save and close it first, then re-run launch." >&2
  exit 1
fi

export EFFECTCRAFT_CONTROL_PORT="$PORT"
"$BIN" --control "$PORT" &
LAUNCH_PID=$!

for i in $(seq 1 25); do
  sleep 1
  if "$CLI" --bridge "$PORT" info >/dev/null 2>&1; then
    echo "EffectCraft ready on 127.0.0.1:$PORT (PID $LAUNCH_PID, no token needed)."
    exit 0
  fi
done

echo "launch: control port $PORT did not answer within 25 s" >&2
exit 1
