# Установка Deya v3.0

## Системные Требования

- **OS:** Linux, macOS, Windows (WSL2)
- **RAM:** 4GB минимум, 8GB рекомендуется
- **Disk:** 2GB свободного места
- **Node.js:** 18+ (проверить: `node --version`)
- **Python:** 3.9+ (проверить: `python3 --version`)
- **FFmpeg:** для работы с видео

## Быстрая Установка

### 1. Клонировать репозиторий

```bash
git clone https://github.com/Mysense775/DeyaV3.git
cd deya
```

### 2. Запустить скрипт установки

```bash
npm run setup
```

Или вручную:

```bash
# Установить Node.js зависимости
npm install

# Установить Python зависимости
pip3 install -r requirements.txt

# Создать структуру директорий
mkdir -p memory skills workspace logs tmp
```

### 3. Настроить переменные окружения

```bash
cp .env.example .env
nano .env  # или vim, или любой редактор
```

**Обязательно заполнить:**
- `OPENAI_API_KEY` или другой AI провайдер
- `TELEGRAM_BOT_TOKEN` (если нужен Telegram бот)

### 4. Запустить

```bash
npm start
```

Deya будет доступна на `http://localhost:3000`

---

## Установка через Docker

### Требования
- Docker 20.10+
- Docker Compose 2.0+

### Запуск

```bash
# Клонировать
git clone https://github.com/Mysense775/DeyaV3.git
cd deya

# Создать .env
cp .env.example .env
# Отредактировать .env

# Запустить
docker-compose up -d

# Проверить статус
docker-compose ps

# Логи
docker-compose logs -f deya
```

### Остановка

```bash
docker-compose down
```

---

## Установка на VPS / Сервер

### Ubuntu 22.04

```bash
# Обновить систему
sudo apt update && sudo apt upgrade -y

# Установить Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Установить Python и FFmpeg
sudo apt install -y python3 python3-pip ffmpeg git

# Клонировать и запустить
git clone https://github.com/Mysense775/DeyaV3.git
cd deya
npm install
pip3 install -r requirements.txt
npm run setup
npm start
```

### Использование PM2 (для production)

```bash
# Установить PM2
sudo npm install -g pm2

# Запустить через PM2
pm2 start src/index.js --name deya

# Автозапуск при загрузке
pm2 startup
pm2 save

# Мониторинг
pm2 status
pm2 logs deya
pm2 monit
```

---

## Настройка Nginx (Reverse Proxy)

```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}
```

---

## SSL / HTTPS

### Используя Certbot

```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d your-domain.com
```

---

## Обновление

```bash
# Скачать обновления
git pull origin main

# Обновить зависимости
npm install
pip3 install -r requirements.txt

# Перезапустить
pm2 restart deya
```

---

## Устранение Неполадок

### Ошибка: "Node.js version too old"
```bash
# Установить nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc

# Установить Node.js 20
nvm install 20
nvm use 20
```

### Ошибка: "FFmpeg not found"
```bash
# Ubuntu/Debian
sudo apt install ffmpeg

# macOS
brew install ffmpeg

# Windows (chocolatey)
choco install ffmpeg
```

### Ошибка: "Permission denied"
```bash
# Исправить права
chmod +x scripts/*.sh
chmod 600 .env
```

---

## Проверка Установки

После запуска откройте в браузере:
- Health check: `http://localhost:3000/health`
- API docs: `http://localhost:3000/api/skills`

---

## Следующие Шаги

1. [Настройка скилов](docs/skills.md)
2. [Интеграция с Telegram](docs/telegram.md)
3. [Настройка автопостинга](docs/auto-posting.md)
4. [API документация](docs/api.md)

---

*Проблемы? Пишите в Issues на GitHub или в Telegram @deya_ai* 🌺
