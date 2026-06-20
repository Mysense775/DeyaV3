#!/usr/bin/env bash
# Deya v3.0 — автоустановка серверного агента
# Репозиторий: https://github.com/Mysense775/DeyaV3
# Релиз:       https://github.com/Mysense775/DeyaV3/releases
#
# Использование:
#   curl -fsSL https://raw.githubusercontent.com/Mysense775/DeyaV3/main/install.sh | sudo bash
#   curl -fsSL https://raw.githubusercontent.com/Mysense775/DeyaV3/main/install.sh | bash  # ~/.deya
#
# Переменные окружения (опционально):
#   DEYA_VERSION=V3.0          — тег релиза (по умолчанию V3.0)
#   DEYA_INSTALL_DIR=/opt/deya-v3
#   DEYA_USE_DOCKER=1          — установка через Docker Compose
#   DEYA_SKIP_SYSTEMD=1        — не создавать systemd-сервис
#   DEYA_AIROUTER_KEY=sk-...   — API-ключ AI Router (запишется в .env)

set -euo pipefail

DEYA_VERSION="${DEYA_VERSION:-V3.0}"
DEYA_REPO="https://github.com/Mysense775/DeyaV3.git"
DEYA_RAW="https://raw.githubusercontent.com/Mysense775/DeyaV3/main"
DEYA_RELEASE_TARBALL="https://github.com/Mysense775/DeyaV3/archive/refs/tags/${DEYA_VERSION}.tar.gz"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log()  { echo -e "${BLUE}$*${NC}"; }
ok()   { echo -e "${GREEN}✅ $*${NC}"; }
warn() { echo -e "${YELLOW}⚠️  $*${NC}"; }
err()  { echo -e "${RED}❌ $*${NC}" >&2; exit 1; }

need_cmd() {
    command -v "$1" >/dev/null 2>&1 || err "Не найдена команда: $1"
}

is_root() {
    [ "$(id -u)" -eq 0 ]
}

detect_platform() {
    case "$(uname -s)" in
        Linux*)  echo "linux" ;;
        Darwin*) echo "macos" ;;
        *)       echo "unknown" ;;
    esac
}

# --- заголовок ---
echo -e "${GREEN}"
cat <<'BANNER'
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║   🌺  DEYA v3.0 — серверный AI-агент  🌺                     ║
║       Автоустановка · OpenClaw · 26+ скилов                  ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
BANNER
echo -e "${NC}"

PLATFORM="$(detect_platform)"
if [ "$PLATFORM" = "unknown" ]; then
    err "Неподдерживаемая ОС. Нужны Linux или macOS."
fi

# Директория установки
if is_root; then
    DEYA_INSTALL_DIR="${DEYA_INSTALL_DIR:-/opt/deya-v3}"
    DEYA_USER="${SUDO_USER:-root}"
    DEYA_GROUP="$(id -gn "${DEYA_USER}" 2>/dev/null || echo root)"
else
    DEYA_INSTALL_DIR="${DEYA_INSTALL_DIR:-${HOME}/.deya}"
    DEYA_USER="$(whoami)"
    DEYA_GROUP="$(id -gn)"
    warn "Запуск без root — установка в ${DEYA_INSTALL_DIR}"
fi

log "📦 Платформа: ${PLATFORM}"
log "📁 Каталог:   ${DEYA_INSTALL_DIR}"
log "🏷️  Версия:   ${DEYA_VERSION}"

# --- системные зависимости ---
install_system_deps() {
    log "🔍 Проверка зависимостей..."

    if [ "$PLATFORM" = "linux" ] && command -v apt-get >/dev/null 2>&1; then
        apt-get update -qq
        apt-get install -y curl wget git ca-certificates python3 python3-pip python3-venv \
            build-essential ffmpeg jq unzip
    elif [ "$PLATFORM" = "macos" ] && command -v brew >/dev/null 2>&1; then
        brew install curl git python ffmpeg jq || true
    fi

    # Node.js 20+
    if ! command -v node >/dev/null 2>&1; then
        log "📦 Установка Node.js 20..."
        if [ "$PLATFORM" = "linux" ] && command -v apt-get >/dev/null 2>&1; then
            curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
            apt-get install -y nodejs
        elif [ "$PLATFORM" = "macos" ] && command -v brew >/dev/null 2>&1; then
            brew install node@20
        else
            err "Установите Node.js 20+ вручную: https://nodejs.org"
        fi
    fi

    NODE_MAJOR="$(node -v | sed 's/v//' | cut -d. -f1)"
    [ "${NODE_MAJOR}" -ge 18 ] || err "Node.js 18+ обязателен. Сейчас: $(node -v)"

    need_cmd python3
    need_cmd git
    need_cmd curl

    ok "Node.js $(node -v)"
    ok "Python $(python3 --version 2>&1)"
    command -v ffmpeg >/dev/null 2>&1 && ok "FFmpeg установлен" || warn "FFmpeg не найден — видео-скилы могут не работать"
}

# --- скачивание исходников ---
fetch_sources() {
    log "⬇️  Загрузка Deya v3 (${DEYA_VERSION})..."

    mkdir -p "${DEYA_INSTALL_DIR}"
    TMP_DIR="$(mktemp -d)"
    trap 'rm -rf "${TMP_DIR}"' EXIT

    if curl -fsSL "${DEYA_RELEASE_TARBALL}" -o "${TMP_DIR}/deya-v3.tar.gz" 2>/dev/null; then
        tar -xzf "${TMP_DIR}/deya-v3.tar.gz" -C "${TMP_DIR}"
        SRC_DIR="$(find "${TMP_DIR}" -maxdepth 1 -type d -name 'DeyaV3-*' | head -1)"
        [ -n "${SRC_DIR}" ] || err "Не удалось распаковать архив релиза"
    else
        warn "Релиз ${DEYA_VERSION} недоступен — клонируем main"
        git clone --depth 1 --branch main "${DEYA_REPO}" "${TMP_DIR}/DeyaV3"
        SRC_DIR="${TMP_DIR}/DeyaV3"
    fi

    # Обновляем содержимое каталога установки
    if command -v rsync >/dev/null 2>&1; then
        RSYNC_EXCLUDE=(--exclude memory --exclude logs --exclude workspace --exclude .env)
        if [ -d "${DEYA_INSTALL_DIR}/.git" ] || [ -f "${DEYA_INSTALL_DIR}/package.json" ]; then
            warn "Обновление существующей установки..."
            rsync -a --delete "${RSYNC_EXCLUDE[@]}" "${SRC_DIR}/" "${DEYA_INSTALL_DIR}/"
        else
            rsync -a "${SRC_DIR}/" "${DEYA_INSTALL_DIR}/"
        fi
    else
        if [ -f "${DEYA_INSTALL_DIR}/package.json" ]; then
            find "${DEYA_INSTALL_DIR}" -mindepth 1 \
                ! -path "${DEYA_INSTALL_DIR}/memory*" \
                ! -path "${DEYA_INSTALL_DIR}/logs*" \
                ! -path "${DEYA_INSTALL_DIR}/workspace*" \
                ! -name .env -exec rm -rf {} + 2>/dev/null || true
        fi
        cp -a "${SRC_DIR}/." "${DEYA_INSTALL_DIR}/"
    fi

    ok "Исходники готовы"
}

# --- npm / python ---
install_app_deps() {
    log "📦 Установка зависимостей приложения..."
    cd "${DEYA_INSTALL_DIR}"

    export npm_config_loglevel=error
    npm install --omit=dev

    if [ -f requirements.txt ]; then
        log "🐍 Python-зависимости..."
        python3 -m pip install -q -r requirements.txt 2>/dev/null \
            || pip3 install -q -r requirements.txt \
            || warn "Не все Python-пакеты установились — проверьте pip"
    fi

    if [ -f package.json ] && node -e "process.exit(require('./package.json').scripts.setup?0:1)" 2>/dev/null; then
        npm run setup || warn "npm run setup завершился с предупреждениями"
    fi

    ok "Зависимости установлены"
}

# --- .env ---
configure_env() {
    log "🔧 Настройка .env..."
    cd "${DEYA_INSTALL_DIR}"

    if [ ! -f .env ] && [ -f .env.example ]; then
        cp .env.example .env
    fi

    if [ -f .env ]; then
        # AI Router — единый endpoint для LLM
        grep -q '^OPENAI_API_BASE=' .env 2>/dev/null \
            || echo 'OPENAI_API_BASE=https://airouter.host/v1' >> .env
        grep -q '^AIROUTER_BASE_URL=' .env 2>/dev/null \
            || echo 'AIROUTER_BASE_URL=https://airouter.host/v1' >> .env

        if [ -n "${DEYA_AIROUTER_KEY:-}" ]; then
            if grep -q '^OPENAI_API_KEY=' .env; then
                sed -i.bak "s|^OPENAI_API_KEY=.*|OPENAI_API_KEY=${DEYA_AIROUTER_KEY}|" .env
            else
                echo "OPENAI_API_KEY=${DEYA_AIROUTER_KEY}" >> .env
            fi
            rm -f .env.bak
        fi

        chmod 600 .env 2>/dev/null || true
    fi

    ok ".env готов (отредактируйте ключи: ${DEYA_INSTALL_DIR}/.env)"
}

# --- права ---
fix_permissions() {
    if is_root && [ "${DEYA_USER}" != "root" ]; then
        chown -R "${DEYA_USER}:${DEYA_GROUP}" "${DEYA_INSTALL_DIR}"
    fi
}

# --- systemd ---
setup_systemd() {
    [ "${DEYA_SKIP_SYSTEMD:-0}" = "1" ] && return 0
    [ "$PLATFORM" != "linux" ] && return 0
    command -v systemctl >/dev/null 2>&1 || return 0

    log "⚙️  Настройка systemd-сервиса deya..."
    NODE_BIN="$(command -v node)"

    cat > /etc/systemd/system/deya.service <<EOF
[Unit]
Description=Deya v3.0 — серверный AI-агент
Documentation=https://github.com/Mysense775/DeyaV3
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=${DEYA_USER}
Group=${DEYA_GROUP}
WorkingDirectory=${DEYA_INSTALL_DIR}
Environment=NODE_ENV=production
Environment=PORT=3000
ExecStart=${NODE_BIN} ${DEYA_INSTALL_DIR}/src/index.js
Restart=on-failure
RestartSec=10
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable deya
    systemctl restart deya || systemctl start deya

    ok "Сервис deya включён (systemctl status deya)"
}

# --- docker ---
install_docker_mode() {
    log "🐳 Установка через Docker Compose..."
    cd "${DEYA_INSTALL_DIR}"

    command -v docker >/dev/null 2>&1 || err "Docker не найден. Установите Docker или уберите DEYA_USE_DOCKER=1"
    if docker compose version >/dev/null 2>&1; then
        COMPOSE="docker compose"
    elif command -v docker-compose >/dev/null 2>&1; then
        COMPOSE="docker-compose"
    else
        err "Docker Compose не найден"
    fi

    configure_env
    ${COMPOSE} up -d --build
    ok "Deya запущен в Docker"
}

# --- healthcheck ---
wait_for_health() {
    log "🏥 Проверка health..."
    for i in $(seq 1 30); do
        if curl -fsS "http://127.0.0.1:3000/health" >/dev/null 2>&1; then
            ok "Deya отвечает: http://localhost:3000/health"
            return 0
        fi
        sleep 2
    done
    warn "Health check не прошёл — проверьте логи: journalctl -u deya -f"
}

# --- финал ---
print_done() {
    SKILLS_COUNT=0
    [ -d "${DEYA_INSTALL_DIR}/skills" ] && SKILLS_COUNT="$(find "${DEYA_INSTALL_DIR}/skills" -name 'SKILL.md' 2>/dev/null | wc -l | tr -d ' ')"

    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  🌺  УСТАНОВКА DEYA v3.0 ЗАВЕРШЕНА  🌺                       ║${NC}"
    echo -e "${GREEN}╠══════════════════════════════════════════════════════════════╣${NC}"
    echo -e "${GREEN}║  📁 Каталог:  ${DEYA_INSTALL_DIR}${NC}"
    echo -e "${GREEN}║  📦 Скилов:   ${SKILLS_COUNT}+${NC}"
    echo -e "${GREEN}║  🌐 Health:   http://localhost:3000/health${NC}"
    echo -e "${GREEN}╠══════════════════════════════════════════════════════════════╣${NC}"
    echo -e "${GREEN}║  Следующие шаги:${NC}"
    echo -e "${GREEN}║  1. Добавьте API-ключ в ${DEYA_INSTALL_DIR}/.env${NC}"
    echo -e "${GREEN}║     OPENAI_API_BASE=https://airouter.host/v1${NC}"
    echo -e "${GREEN}║     OPENAI_API_KEY=ваш-ключ-ai-router${NC}"
    echo -e "${GREEN}║  2. Настройте Telegram: TELEGRAM_BOT_TOKEN в .env${NC}"
    echo -e "${GREEN}║  3. Перезапуск: sudo systemctl restart deya${NC}"
    echo -e "${GREEN}║  4. Логи:       sudo journalctl -u deya -f${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}🌺 Suksma! Добро пожаловать в семью Deya.${NC}"
    echo ""
}

# --- main ---
install_system_deps

if [ "${DEYA_USE_DOCKER:-0}" = "1" ]; then
    fetch_sources
    install_docker_mode
else
    fetch_sources
    install_app_deps
    configure_env
    fix_permissions
    setup_systemd
    wait_for_health || true
fi

print_done
