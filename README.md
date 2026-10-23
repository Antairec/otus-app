# Microservices Demo — Docker Containerization

**Languages / Языки:** [Русский](#russian) · [English](#english)

<a id="russian"></a>

## 🇷🇺 Русская версия

### О проекте

В этом учебном проекте я **контейнеризировал демонстрационное микросервисное приложение** с помощью Docker и автоматизировал его развёртывание, резервное копирование данных и удаление инфраструктуры.

Были написаны **четыре Dockerfile** и созданы образы для четырёх контейнеров:

- **`users-api`** — API для работы с пользователями;
- **`documents-api`** — API для работы с документами;
- **`dashboard-ui`** — веб-интерфейс приложения;
- **`postgresql`** — база данных PostgreSQL.

Таким образом, приложение состоит из **трёх контейнеров с сервисами приложения и одного контейнера с PostgreSQL**. Собранные Docker-образы опубликованы в Docker Registry. В репозитории также находится файл `docker-compose.yml`.

### Структура репозитория

```text
.
├── users-api/
├── documents-api/
├── dashboard-ui/
├── postgresql/
├── backups/
├── docker-compose.yml
├── deploy_with_build_and_expose_ports.sh
├── deploy_with_docker_images_and_expose_ports.sh
├── deploy_with_docker_images.sh
├── backup_all_data.sh
├── destroy_infrastructure.sh
├── .gitignore
└── README.md
```

Каталоги сервисов содержат файлы, необходимые для их контейнеризации. Резервные копии сохраняются в каталог `backups/`.

### Запуск приложения

**Требования:** Docker Engine; Docker Compose — для второго способа.

Клонировать репозиторий и перейти в каталог проекта:

```bash
git clone https://github.com/Antairec/otus-app.git
cd otus-app
```

#### Вариант 1. Bash-скрипты

**Собрать Docker-образы и запустить контейнеры с публикацией портов:**

```bash
./deploy_with_build_and_expose_ports.sh
```

**Запустить контейнеры из готовых образов с публикацией портов:**

```bash
./deploy_with_docker_images_and_expose_ports.sh
```

**Запустить контейнеры из готовых образов с публикацией только веб-интерфейса:**

```bash
./deploy_with_docker_images.sh
```

**Резервное копирование данных PostgreSQL и Docker-томов API в `backups/`:**

```bash
./backup_all_data.sh
```

**Удаление развёрнутой инфраструктуры:**

```bash
./destroy_infrastructure.sh
```

#### Вариант 2. Docker Compose

**Запуск приложения:**

```bash
docker compose up -d
```

**Проверка состояния контейнеров:**

```bash
docker compose ps
```

**Остановка и удаление контейнеров:**

```bash
docker compose down
```

`docker-compose.yml` использует файл `nginx.conf` из корня проекта.

### Доступ к приложению

| Способ запуска | Адрес |
| --- | --- |
| `deploy_*.sh` | `http://<IP-сервера>:80` |
| `docker compose up -d` | `http://<IP-сервера>:81` |

### Что реализовано

- Контейнеризация микросервисного приложения с помощью четырёх Dockerfile.
- Сборка и публикация образов в Docker Registry.
- Автоматизация развёртывания Bash-скриптами.
- Два способа развёртывания: с локальной сборкой или с готовыми образами.
- Различные схемы публикации портов: порты сервисов либо только порт веб-интерфейса.
- Резервное копирование данных PostgreSQL и Docker-томов API.
- Автоматизированное удаление инфраструктуры.

---

<a id="english"></a>

## 🇬🇧 English Version

### Overview

In this training project, I **containerized a demo microservices application** using Docker and automated its deployment, data backups, and infrastructure teardown.

I wrote **four Dockerfiles** and created images for four containers:

- **`users-api`** — user management API;
- **`documents-api`** — document management API;
- **`dashboard-ui`** — application web interface;
- **`postgresql`** — PostgreSQL database.

The stack therefore consists of **three application containers and one PostgreSQL container**. I built the Docker images and pushed them to a Docker registry. The repository also includes a `docker-compose.yml` file.

### Repository Structure

```text
.
├── users-api/
├── documents-api/
├── dashboard-ui/
├── postgresql/
├── backups/
├── docker-compose.yml
├── deploy_with_build_and_expose_ports.sh
├── deploy_with_docker_images_and_expose_ports.sh
├── deploy_with_docker_images.sh
├── backup_all_data.sh
├── destroy_infrastructure.sh
├── .gitignore
└── README.md
```

The service directories contain the files required to containerize each component. Backups are stored in the `backups/` directory.

### Running the Application

**Requirements:** Docker Engine; Docker Compose for the second option.

Clone the repository and enter the project directory:

```bash
git clone https://github.com/Antairec/otus-app.git
cd otus-app
```

#### Option 1. Bash Scripts

**Build Docker images and start the containers with published ports:**

```bash
./deploy_with_build_and_expose_ports.sh
```

**Start containers from prebuilt images with published ports:**

```bash
./deploy_with_docker_images_and_expose_ports.sh
```

**Start containers from prebuilt images with only the web interface port published:**

```bash
./deploy_with_docker_images.sh
```

**Back up PostgreSQL data and API Docker volumes to `backups/`:**

```bash
./backup_all_data.sh
```

**Remove the deployed infrastructure:**

```bash
./destroy_infrastructure.sh
```

#### Option 2. Docker Compose

**Start the application:**

```bash
docker compose up -d
```

**Check container status:**

```bash
docker compose ps
```

**Stop and remove containers:**

```bash
docker compose down
```

`docker-compose.yml` uses the `nginx.conf` file from the project root.

### Application Access

| Deployment method | URL |
| --- | --- |
| `deploy_*.sh` | `http://<server-ip>:80` |
| `docker compose up -d` | `http://<server-ip>:81` |

### What This Project Demonstrates

- Containerizing a microservices application with four Dockerfiles.
- Building and publishing images to a Docker registry.
- Automating deployment using Bash scripts.
- Deploying from local builds or prebuilt images.
- Configuring different port publishing options: service ports or only the web interface port.
- Backing up PostgreSQL data and API Docker volumes.
- Automating infrastructure teardown.

[↑ Русский](#russian) · [↑ English](#english)
