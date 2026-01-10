#!/usr/bin/env bash
set -euo pipefail

SERVICE="${1:-db}"
ENV_FILE="${2:-.env}"
MIG_DIR="${3:-./migrations}"

./scripts/db-env.sh "$ENV_FILE"

if [[ ! -d "$MIG_DIR" ]]; then
  echo "No migrations dir: $MIG_DIR"
  exit 1
fi

echo "Applying migrations to ${POSTGRES_DB} from $MIG_DIR ..."
shopt -s nullglob
FILES=("$MIG_DIR"/*.sql)
if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "No migration files found in $MIG_DIR"
  exit 0
fi

IFS=$'\n' SORTED=($(printf "%s\n" "${FILES[@]}" | sort))
unset IFS

for f in "${SORTED[@]}"; do
  echo " -> $(basename "$f")"
  docker compose exec -T "$SERVICE" psql \
    -U "${POSTGRES_USER}" \
    -d "${POSTGRES_DB}" \
    -v ON_ERROR_STOP=1 \
    -f /dev/stdin < "$f"
done

echo "Migrations complete."
