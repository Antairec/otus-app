#!/bin/bash
set -Eeuo pipefail

DB_CONTAINER_NAME="postgres-db-1"
DB_VOLUME_NAME="postgres-data"

DOC_CONTAINER_NAME="documents-api-1"
DOC_VOLUME_NAME="documents-uploads"

BACKUP_DIR="$PWD/backups"
TIMESTAMP="$(date +%Y-%m-%d_%H-%M-%S)"

DB_BACKUP_FILE="${DB_VOLUME_NAME}_${TIMESTAMP}.tar.gz"
DOC_BACKUP_FILE="${DOC_VOLUME_NAME}_${TIMESTAMP}.tar.gz"

mkdir -p "$BACKUP_DIR"

# Проверяем наличие томов и контейнеров
docker volume inspect "$DB_VOLUME_NAME" >/dev/null
docker volume inspect "$DOC_VOLUME_NAME" >/dev/null

docker inspect "$DB_CONTAINER_NAME" >/dev/null
docker inspect "$DOC_CONTAINER_NAME" >/dev/null

# Запоминаем первоначальное состояние
db_was_running="$(docker inspect \
  --format '{{.State.Running}}' "$DB_CONTAINER_NAME")"

doc_was_running="$(docker inspect \
  --format '{{.State.Running}}' "$DOC_CONTAINER_NAME")"

# При завершении возвращаем контейнеры в исходное состояние
restore_containers() {
  local exit_code=$?

  trap - EXIT

  if [[ "$db_was_running" == "true" ]]; then
    docker start "$DB_CONTAINER_NAME" >/dev/null || true
  fi

  if [[ "$doc_was_running" == "true" ]]; then
    docker start "$DOC_CONTAINER_NAME" >/dev/null || true
  fi

  exit "$exit_code"
}

trap restore_containers EXIT

# Останавливаем контейнеры
if [[ "$doc_was_running" == "true" ]]; then
  docker stop "$DOC_CONTAINER_NAME" >/dev/null
fi

if [[ "$db_was_running" == "true" ]]; then
  docker stop "$DB_CONTAINER_NAME" >/dev/null
fi

# Создаём оба архива
docker run --rm \
  -v "${DB_VOLUME_NAME}:/db_volume:ro" \
  -v "${DOC_VOLUME_NAME}:/doc_volume:ro" \
  -v "${BACKUP_DIR}:/backup" \
  -e HOST_UID="$(id -u)" \
  -e HOST_GID="$(id -g)" \
  -e DB_BACKUP_FILE="$DB_BACKUP_FILE" \
  -e DOC_BACKUP_FILE="$DOC_BACKUP_FILE" \
  alpine:3.20 \
  sh -ec '
    tar -czf "/backup/$DB_BACKUP_FILE" -C /db_volume .
    tar -czf "/backup/$DOC_BACKUP_FILE" -C /doc_volume .

    gzip -t "/backup/$DB_BACKUP_FILE"
    gzip -t "/backup/$DOC_BACKUP_FILE"

    chown "$HOST_UID:$HOST_GID" \
      "/backup/$DB_BACKUP_FILE" \
      "/backup/$DOC_BACKUP_FILE"
  '

echo "Backups created:"
echo "${BACKUP_DIR}/${DB_BACKUP_FILE}"
echo "${BACKUP_DIR}/${DOC_BACKUP_FILE}"