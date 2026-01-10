#!/usr/bin/env bash
set -euo pipefail

SERVICE="${1:-db}"
ENV_FILE="${2:-.env}"

./scripts/db-env.sh "$ENV_FILE"

docker compose exec "$SERVICE" psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}"
