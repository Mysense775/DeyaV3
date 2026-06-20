# ⚡ Быстрый Старт Deya v3.0

## One-Line Установка

### 🐳 Через Docker (рекомендуется)

```bash
curl -fsSL https://raw.githubusercontent.com/Mysense775/DeyaV3/main/install.sh | bash
```

Или вручную:

```bash
git clone https://github.com/Mysense775/DeyaV3.git && cd deya
docker-compose up -d
```

### 🖥️ Нативная установка

```bash
curl -fsSL https://raw.githubusercontent.com/Mysense775/DeyaV3/main/install.sh | bash
```

Или:

```bash
git clone https://github.com/Mysense775/DeyaV3.git && cd deya
npm install && pip3 install -r requirements.txt
npm start
```

---

## Проверка

```bash
# Health check
curl http://localhost:3000/health

# Должно вернуть:
# {"status":"ok","version":"3.0.0"}
```

---

## Первые Шаги

### 1. Настроить API ключи

```bash
nano ~/.deya/.env
```

Минимум:
```env
# Выбрать один AI провайдер:
OPENAI_API_KEY=sk-your-key
# или
ANTHROPIC_API_KEY=sk-your-key
# или
GOOGLE_API_KEY=your-key
```

### 2. Начать диалог

**Telegram:**
- Найти бота: @deya_ai_bot
- Или написать напрямую после настройки webhook

**Web API:**
```bash
curl -X POST http://localhost:3000/api/chat \
  -H "Content-Type: application/json" \
  -d '{"message":"Привет, Deya!"}'
```

**CLI:**
```bash
npm run cli
```

---

## Примеры Команд

### Контент
```
Создай видео "закат над океаном" --duration=5
Напиши статью про AI в маркетинге
Сделай баннер 1080x1080 для Instagram
```

### Маркетинг
```
Настрой автопостинг в Telegram
Проверь SEO моего сайта example.com
Создай email-воронку для новых подписчиков
```

### Разработка
```
Сгенерируй API на Python для блога
Сделай код-ревью этого файла
Настрой CI/CD pipeline
```

---

## Обновление

```bash
# Docker
cd ~/.deya && docker-compose pull && docker-compose up -d

# Native
cd ~/.deya && git pull && npm install && pm2 restart deya
```

---

## Помощь

- 📖 Документация: https://docs.deya.ai
- 💬 Telegram: https://t.me/deya_ai
- 🐛 Issues: https://github.com/Mysense775/DeyaV3/issues

---

*One line to rule them all. 🌺*
