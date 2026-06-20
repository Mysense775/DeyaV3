# Deya v3.0 🌺

**AI-Ассистент для Бизнеса и Креатива**

[![Version](https://img.shields.io/badge/version-3.0-blue)](https://github.com/Mysense775/DeyaV3)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![OpenClaw](https://img.shields.io/badge/runtime-OpenClaw-orange)](https://openclaw.ai)

---

## Что это?

Deya — интеллектуальный ассистент с духом Бали, объединяющий деловую хватку и тонкую интуицию. Создаёт контент, автоматизирует процессы, пишет код и помогает расти бизнесу.

**26+ скилов** для решения любых задач:
- 🎬 Видео и дизайн
- 📝 Контент и SEO
- 📱 Автопостинг и чат-боты
- 💻 Код и DevOps
- 📊 Аналитика и отчёты
- 🛡️ Безопасность

---

## ⚡ One-Line Установка

```bash
curl -fsSL https://raw.githubusercontent.com/Mysense775/DeyaV3/main/install.sh | sudo bash
```

**Или через Docker:**

```bash
git clone https://github.com/Mysense775/DeyaV3.git && cd deya
docker-compose up -d
```

**Готово!** Открой http://localhost:3000

---

## 📋 Требования

- Linux / macOS / Windows (WSL)
- Node.js 18+ (проверить: `node --version`)
- Python 3.9+ (проверить: `python3 --version`)
- FFmpeg (для видео)
- 4GB RAM

---

## 🚀 Быстрый Старт

### 1. Установить (одной строкой)

```bash
curl -fsSL https://raw.githubusercontent.com/Mysense775/DeyaV3/main/install.sh | sudo bash
```

### 2. Настроить

```bash
nano ~/.deya/.env  # Добавить API ключи
```

### 3. Запустить

```bash
# Docker (автоматически)
docker-compose -f ~/.deya/docker-compose.yml up -d

# Или systemd
sudo systemctl start deya

# Или напрямую
cd ~/.deya && npm start
```

### 4. Проверить

```bash
curl http://localhost:3000/health
# {"status":"ok","version":"3.0.0"}
```

---

## Скилы

### 🎨 Контент
| Скил | Описание |
|------|----------|
| **video-content** | Генерация видео, субтитры, шортсы, слайд-шоу |
| **article-writer** | SEO-статьи, гайды, аналитика |
| **design-studio** | Баннеры, инфографика, UI/UX, презентации |
| **auto-posting** | Публикация в соцсети, шедулинг |

### 📈 Маркетинг
| Скил | Описание |
|------|----------|
| **seo-promotion** | Аудит, ключевые слова, позиции |
| **email-marketing** | Рассылки, воронки, сегментация |
| **chatbot-builder** | Боты для Telegram, VK, WhatsApp |
| **ecommerce-manager** | Товары, цены, маркетплейсы |

### 💻 Разработка
| Скил | Описание |
|------|----------|
| **code-master** | Генерация, ревью, рефакторинг, DevOps |
| **ai-assistant** | GPT, Claude, Gemini, локальные модели |
| **analytics-reports** | Дашборды, метрики, отчёты |

### ⚙️ Автоматизация
| Скил | Описание |
|------|----------|
| **business-automation** | Workflow, триггеры, интеграции |
| **content-manager** | Календарь, планирование, тренды |

### 🛡️ Безопасность
| Скил | Описание |
|------|----------|
| **healthcheck** | Аудит, шифрование, firewall, бэкапы |

---

## Примеры Использования

### Создать видео
```
video generate "Красный закат над океаном" --duration=5
video shorts video.mp4 --count=3
video subtitles video.mp4 --lang=ru
```

### Написать статью
```
article idea "нейросети для бизнеса"
article write "Как ИИ меняет маркетинг" --style=expert --length=1500
article publish medium article.md
```

### Автопостинг
```
post telegram "Привет, мир! 🌍"
schedule instagram "2024-01-01 12:00" "Новогодний пост"
crosspost "telegram,vk,twitter" "Важное объявление!"
```

### Работа с кодом
```
code generate "функция сортировки" --lang=python
code review app.py
code test calculator.py --type=unit
```

---

## Конфигурация

### Переменные Окружения

```env
# AI Модели
OPENAI_API_KEY=sk-...
ANTHROPIC_API_KEY=sk-ant-...
GOOGLE_API_KEY=...

# Видео
KIE_API_KEY=...

# Соцсети
TELEGRAM_BOT_TOKEN=...
VK_ACCESS_TOKEN=...
INSTAGRAM_TOKEN=...

# Почта
SENDGRID_API_KEY=...

# Аналитика
GA4_PROPERTY_ID=...
YANDEX_METRIKA_ID=...
```

---

## Архитектура

```
Deya/
├── core/               # Ядро и личность
│   ├── soul.md         # Ценности и стиль
│   ├── identity.md     # Профиль
│   └── user.md         # Пользователь
│
├── skills/             # Скилы
│   ├── active/         # Активные
│   └── proposals/      # На рассмотрении
│
├── memory/             # Память
│   ├── RAG_MEMORY.md   # Структурированная
│   └── 2026-06/        # Сессии
│
├── integrations/       # Интеграции
│   ├── kie.ai/         # Видео
│   ├── telegram/       # Бот
│   └── notion/         # База знаний
│
├── config/             # Конфигурация
│   ├── .env.example
│   └── setup.md
│
└── docs/               # Документация
    ├── skills.md
    ├── api.md
    └── deployment.md
```

---

## Roadmap

### v3.1
- [ ] Полная интеграция KIE.ai
- [ ] Voice/Audio скилы
- [ ] Улучшенная RAG

### v3.2
- [ ] Multi-user поддержка
- [ ] Web UI дашборд
- [ ] Плагин система

### v4.0
- [ ] Автономный режим
- [ ] Distributed агенты
- [ ] Self-improvement

---

## Сообщество

- **Telegram:** [@deya_ai](https://t.me/deya_ai)
- **GitHub:** [github.com/Mysense775/DeyaV3](https://github.com/Mysense775/DeyaV3)
- **Docs:** [docs.deya.ai](https://docs.deya.ai)

---

## Лицензия

MIT License — открытый исходный код, свободное использование.

---

*Создано с любовью и заботой. 🌺*

*Suksma за доверие!*
