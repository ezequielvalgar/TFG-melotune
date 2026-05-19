# 🎵 MeloTune

**Plataforma Social de Reseñas Musicales**

MeloTune es una aplicación web socialdonde los usuarios pueden reseñar álbumes, seguir a otros usuarios, descubrir música nueva y construir su propia colección musical. Integra las APIs de Spotify y Last.fm para obtener datos musicales en tiempo real.

---

## 🏗️ Stack Tecnológico

| Capa | Tecnología |
|---|---|
| **Frontend** | Angular 19 + TypeScript |
| **Backend** | Laravel 11 (PHP 8.2) |
| **Base de Datos** | MySQL 8.0 |
| **Servidor Web** | Nginx (Alpine) |
| **Contenerización** | Docker + Docker Compose |
| **APIs Externas** | Spotify Web API · Last.fm API |
| **UI / Estilos** | Bootstrap 5 · CSS Variables · FontAwesome 6 |
| **Tipografía** | Outfit (Google Fonts) |

---

## 📋 Requisitos Previos

Para desplegar el proyecto solo necesitas tener instalado:

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (versión 24 o superior)
- Docker Compose (incluido con Docker Desktop)

> ⚠️ **No necesitas** Node.js, PHP, MySQL ni ningún otro software instalado localmente. Docker se encarga de todo.

---

## ⚙️ Configuración del Entorno

Antes de arrancar, crea el archivo de variables de entorno en la raíz del proyecto:

```bash
# En la raíz del proyecto (junto a docker-compose.prod.yml)
cp .env.prod.example .env.prod
```

Edita `.env.prod` y rellena los valores necesarios

## 🚀 Despliegue en Producción (Docker)

### 1. Arrancar todos los contenedores

```bash
docker-compose -f docker-compose.prod.yml --env-file .env.prod up -d
```

Esto levantará 4 contenedores:
- `melotune_db_prod` — MySQL 8.0
- `melotune_backend_prod` — Laravel (PHP-FPM)
- `melotune_nginx_backend` — Nginx → Backend (puerto 8000)
- `melotune_frontend_prod` — Angular compilado servido por Nginx (puerto 80)

### 2. Ejecutar las migraciones de base de datos

Solo es necesario la primera vez (o tras un `--build`):

```bash
docker exec -it melotune_backend_prod php artisan migrate --force
```

### 3. Acceder a la aplicación

| Servicio | URL |
|---|---|
| **Frontend (App)** | http://localhost |
| **Backend (API)** | http://localhost:8000/api |

---

## 🔄 Comandos Útiles

```bash
# Parar todos los contenedores (sin borrar datos)
docker-compose -f docker-compose.prod.yml down

# Reconstruir imágenes tras cambios en el código
docker-compose -f docker-compose.prod.yml --env-file .env.prod up --build -d

# Ver logs del backend en tiempo real
docker logs -f melotune_backend_prod

# Ver logs de Nginx
docker logs -f melotune_nginx_backend

# Limpiar caché de Laravel
docker exec melotune_backend_prod php artisan optimize:clear

# Acceder a la consola del backend
docker exec -it melotune_backend_prod bash

# Acceder a la consola de MySQL
docker exec -it melotune_db_prod mysql -u melotune -p melotune
```

---

## 💾 Backup y Restauración de la Base de Datos

**Crear backup:**
```bash
docker exec melotune_db_prod mysqldump -u melotune -p melotune > backup_melotune.sql
```

**Restaurar backup:**
```bash
cat backup_melotune.sql | docker exec -i melotune_db_prod mysql -u melotune -p melotune
```

---

## 🗂️ Estructura del Proyecto

```
TFG/
├── docker-compose.prod.yml     # Orquestación de contenedores
├── .env.prod                   # Variables de entorno (NO subir a Git)
├── backend/
│   └── melotune/               # Proyecto Laravel
│       ├── Dockerfile.prod
│       ├── nginx.conf
│       ├── app/
│       ├── config/
│       ├── database/migrations/
│       └── routes/api.php
└── frontend/
    └── melotune/               # Proyecto Angular
        ├── Dockerfile.prod
        └── src/
```

---

## 📌 Notas Importantes

- El archivo `.env.prod` contiene credenciales sensibles. Está incluido en `.gitignore` y **nunca debe subirse al repositorio**.
- Los datos de MySQL se persisten en el volumen Docker `db_data_prod`. Al ejecutar `docker-compose down` los datos **no se borran**. Para borrarlos completamente usar `docker-compose down -v`.
- Para aplicar cambios en el código Angular o Laravel es necesario reconstruir las imágenes con `--build`.

