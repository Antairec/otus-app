#!/bin/bash
set -e

CONTAINERS=(
    dashboard-ui-1
    users-api-1
    documents-api-1
    postgres-db-1
)

IMAGES=(
    antairec/dashboard-ui:latest
    antairec/users-api:latest
    antairec/documents-api:latest
    antairec/postgres-db:latest
)

VOLUMES=(
    postgres-data
    documents-uploads
)

# Удаление контейнеров
for container in "${CONTAINERS[@]}"; do
    if docker container inspect "$container" >/dev/null 2>&1; then
        docker rm -f "$container"
    fi
done

# Удаление сети
if docker network inspect otus-net >/dev/null 2>&1; then
    docker network rm otus-net
fi

# Удаление томов
for volume in "${VOLUMES[@]}"; do
    if docker volume inspect "$volume" >/dev/null 2>&1; then
        docker volume rm "$volume"
    fi
done

# Удаление образов
for image in "${IMAGES[@]}"; do
    if docker image inspect "$image" >/dev/null 2>&1; then
        docker image rm "$image"
    fi
done

echo "Очистка завершена."