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

### Bash-скрипты

| Скрипт | Назначение |
| --- | --- |
| `deploy_with_build_and_expose_ports.sh` | Собирает Docker-образы из Dockerfile, запускает все четыре контейнера и **публикует порты контейнеров на хосте**. |
| `deploy_with_docker_images_and_expose_ports.sh` | Запускает приложение и базу данных из **готовых Docker-образов** с **публикацией портов на хосте**. |
| `deploy_with_docker_images.sh` | Запускает приложение и базу данных из **готовых Docker-образов**; публикует веб-интерфейс на порту **80**, оставляя порты API и PostgreSQL доступными только внутри Docker-сети. |
| `backup_all_data.sh` | Создаёт резервные копии данных PostgreSQL и Docker-томов API в каталоге `backups/`. |
| `destroy_infrastructure.sh` | Удаляет развёрнутую инфраструктуру. |

**Примечание:** API и PostgreSQL могут взаимодействовать с другими контейнерами внутри Docker-сети без публикации своих портов на хосте.

### Запуск и управление

**Требования:** Docker Engine. Docker Compose — для использования `docker-compose.yml`.

**Сборка образов и развёртывание с публикацией портов:**

```bash
bash deploy_with_build_and_expose_ports.sh
```

**Развёртывание из готовых образов с публикацией портов:**

```bash
bash deploy_with_docker_images_and_expose_ports.sh
```

**Развёртывание из готовых образов с публикацией только веб-интерфейса:**

```bash
bash deploy_with_docker_images.sh
```

**Резервное копирование:**

```bash
bash backup_all_data.sh
```

**Удаление инфраструктуры:**

```bash
bash destroy_infrastructure.sh
```


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

### Bash Scripts

| Script | Purpose |
| --- | --- |
| `deploy_with_build_and_expose_ports.sh` | Builds Docker images from Dockerfiles, starts all four containers, and **publishes container ports on the host**. |
| `deploy_with_docker_images_and_expose_ports.sh` | Deploys the application and database from **prebuilt Docker images**, **publishing ports on the host**. |
| `deploy_with_docker_images.sh` | Deploys the application and database from **prebuilt Docker images**; publishes the web interface on port **80**, while API and PostgreSQL ports remain accessible only within the Docker network. |
| `backup_all_data.sh` | Backs up PostgreSQL data and API Docker volumes to `backups/`. |
| `destroy_infrastructure.sh` | Tears down the deployed infrastructure. |

**Note:** The APIs and PostgreSQL can communicate with other containers over the Docker network without publishing their ports to the host.

### Usage

**Prerequisites:** Docker Engine. Docker Compose is needed to use `docker-compose.yml`.

**Build images and deploy with published ports:**

```bash
bash deploy_with_build_and_expose_ports.sh
```

**Deploy prebuilt images with published ports:**

```bash
bash deploy_with_docker_images_and_expose_ports.sh
```

**Deploy prebuilt images with only the web interface published:**

```bash
bash deploy_with_docker_images.sh
```

**Back up data:**

```bash
bash backup_all_data.sh
```

**Tear down the infrastructure:**

```bash
bash destroy_infrastructure.sh
```


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
