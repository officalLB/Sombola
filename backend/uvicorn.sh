#!/usr/bin/env bash
set -euo pipefail

# Load .env into environment if present
set -a
if [ -f .env ]; then
	. ./.env
fi
set +a

UVICORN_BIN="uvicorn"
if [ -x ".venv/bin/uvicorn" ]; then
	UVICORN_BIN=".venv/bin/uvicorn"
fi

exec "$UVICORN_BIN" app.main:app --host 0.0.0.0 --port 8000 --reload