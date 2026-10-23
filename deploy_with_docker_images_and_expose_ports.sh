#!/bin/bash
set -e
docker network inspect otus-net >/dev/null 2>&1 || docker network create otus-net
docker volume inspect postgres-data >/dev/null 2>&1 || docker volume create postgres-data
docker volume inspect documents-uploads >/dev/null 2>&1 || docker volume create documents-uploads

docker inspect postgres-db-1 >/dev/null 2>&1 || \
docker run -d \
  --name postgres-db-1 \
  --network otus-net \
  --restart unless-stopped \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=p123 \
  -e POSTGRES_DB=postgres \
  -v postgres-data:/var/lib/postgresql/data \
  --health-cmd="pg_isready -U postgres" \
  --health-interval=5s \
  --health-timeout=3s \
  --health-retries=20 \
  antairec/postgres-db:latest

docker inspect users-api-1 >/dev/null 2>&1 || \
docker run -d -p 3000:3000 \
  --name users-api-1 \
  --network otus-net \
  --restart unless-stopped \
  --network-alias users-api \
  antairec/users-api:latest


docker inspect documents-api-1 >/dev/null 2>&1 || \
docker run -d -p 3002:3002 \
  --name documents-api-1 \
  --network otus-net \
  --restart unless-stopped \
  -v documents-uploads:/app/uploads/img \
  --network-alias documents-api \
  antairec/documents-api:latest


docker inspect dashboard-ui-1 >/dev/null 2>&1 || \
docker run -d -p 80:80 \
  --name dashboard-ui-1 \
  --network otus-net \
  --restart unless-stopped \
  antairec/dashboard-ui:latest