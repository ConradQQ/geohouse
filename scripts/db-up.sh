#!/usr/bin/env bash
set -euo pipefail

SERVICE="${1:-db}"
ENV_FILE="${2:-.env}"

./scripts/db-env.sh "$ENV_FILE"

docker compose up -d "$SERVICE"

echo "Waiting for $SERVICE to be ready..."
until docker compose exec -T "$SERVICE" pg_isready -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" >/dev/null 2>&1; do
  sleep 1
done

echo "$SERVICE is ready."
