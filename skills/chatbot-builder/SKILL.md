---
name: "chatbot-builder"
description: "Чат-боты и автоответы: Telegram, VK, WhatsApp, сайт"
---

# Chatbot Builder Skill

## Назначение
Создание и управление чат-ботами с автоответами, сценариями диалогов и интеграциями для различных платформ.

## Поддерживаемые платформы
- Telegram (Bot API)
- VK (Messages API)
- WhatsApp (Business API)
- Viber
- Facebook Messenger
- Instagram Direct
- Веб-виджет (для сайтов)
- Slack
- Discord

## Возможности
### Сценарии диалогов
- Дерево диалогов (if/then/else)
- Контекстные ответы
- Обработка намерений (intents)
- Извлечение сущностей (entities)
- Fallback-ответы

### Интерактивные элементы
- Кнопки (inline, reply)
- Меню и навигация
- Опросы и квизы
- Формы сбора данных
- Карусели и галереи

### Интеграции
- CRM (Битрикс24, amoCRM)
- Платёжные системы
- Базы данных
- Внешние API
- Webhook-уведомления

### AI-возможности
- GPT для генерации ответов
- Классификация сообщений
- Анализ тональности
- Распознавание изображений
- Голосовые сообщения

## Команды
- `bot create <name> <platform>` — создать бота
- `bot scenario <name> <flow>` — добавить сценарий
- `bot intent <name> <examples>` — добавить намерение
- `bot response <intent> <answers>` — задать ответы
- `bot button <name> <actions>` — создать кнопки
- `bot connect <integration> <settings>` — подключить интеграцию
- `bot analytics <name>` — статистика бота
- `bot test <name> <message>` — протестировать

## Типы сценариев
- `faq` — частые вопросы
- `lead_capture` — сбор лидов
- `support` — техподдержка
- `sales` — продажи
- `survey` — опросы
- `onboarding` — онбординг
- `notification` — уведомления

## Пример сценария
```
bot create "SalesBot" telegram
bot intent "цена" "сколько стоит|цена|стоимость|прайс"
bot response "цена" "Наши тарифы: Базовый - $10, Про - $30, Бизнес - $100"
bot scenario "main" "start -> приветствие -> меню -> [цена|о нас|контакты]"
bot button "меню" "[Узнать цены:price][О нас:about][Контакты:contacts]"
```

## Интеграции
- Google Sheets (хранение данных)
- Битрикс24 (CRM)
- amoCRM
- ЮKassa (платежи)
- Telegram Payments
- Webhook-сервисы

## Аналитика
- Количество диалогов
- Конверсия сценариев
- Популярные намерения
- Время ответа
- Удовлетворённость
