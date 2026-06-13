---
name: "auto-posting"
description: "Автопостинг в соцсети: Telegram, VK, Instagram, Twitter/X"
---

# Auto-Posting Skill

## Назначение
Автоматический постинг контента в социальные сети: Telegram, VK, Instagram, Twitter/X, LinkedIn, Facebook.

## Возможности
- Публикация текста, изображений, видео, опросов
- Планирование постов по расписанию (интеграция с cron)
- Шаблоны постов с переменными
- Автоматический репост между платформами
- Аналитика: просмотры, лайки, репосты, комментарии
- Управление несколькими аккаунтами

## Команды
- `post <platform> <content>` — опубликовать сейчас
- `schedule <platform> <time> <content>` — запланировать
- `template <name> <content>` — создать шаблон
- `analytics <platform> <period>` — получить статистику
- `crosspost <platforms> <content>` — опубликовать на нескольких платформах

## Интеграции
- Telegram Bot API
- VK API
- Instagram Basic Display API
- Twitter API v2
- LinkedIn API
- Facebook Graph API

## Пример использования
```
post telegram "Привет, мир! 🌍"
schedule instagram "2024-01-01 12:00" "Новогодний пост 🎄"
crosspost "telegram,vk,twitter" "Важное объявление!"
```

## Требования
- API ключи для каждой платформы (хранить в .env)
- Поддержка медиа-файлов
- Обработка ошибок и retry-логика
