#!/usr/bin/env bash
set -euo pipefail

SERVICE="${1:-db}"
ENV_FILE="${2:-.env}"
OUT_DIR="${3:-./backups}"

./scripts/db-env.sh "$ENV_FILE"

mkdir -p "$OUT_DIR"
TS="$(date +%Y%m%d_%H%M%S)"
FILE="$OUT_DIR/${POSTGRES_DB}_${TS}.dump"

echo "Creating backup: $FILE"
docker compose exec -T "$SERVICE" pg_dump \
  -U "${POSTGRES_USER}" \
  -d "${POSTGRES_DB}" \
  -Fc > "$FILE"

echo "Done."
