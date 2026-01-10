#!/usr/bin/env bash
set -euo pipefail

SERVICE="${1:-db}"
ENV_FILE="${2:-.env}"
DUMP_FILE="${3:-}"

./scripts/db-env.sh "$ENV_FILE"

if [[ -z "$DUMP_FILE" || ! -f "$DUMP_FILE" ]]; then
  echo "Usage: $0 <service> <env_file> <path/to/file.dump>"
  exit 1
fi

echo "Restoring into ${POSTGRES_DB} from $DUMP_FILE ..."
cat "$DUMP_FILE" | docker compose exec -T "$SERVICE" pg_restore \
  -U "${POSTGRES_USER}" \
  -d "${POSTGRES_DB}" \
  --clean --if-exists

echo "Done."
