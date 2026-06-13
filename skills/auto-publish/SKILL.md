---
name: "auto-publish"
description: "Автопубликация: CMS, блоги, новостные сайты, площадки"
---

# Auto-Publish Skill

## Назначение
Автоматическая публикация контента на CMS, блоги, новостные сайты и контент-площадки.

## Поддерживаемые платформы
### CMS
- WordPress (REST API)
- Ghost
- Strapi
- Drupal
- Joomla

### Блог-платформы
- Medium
- Хабр
- Dev.to
- Substack
- Telegraph

### Новостные/контентные площадки
- VC.ru
- TJournal
- DTF
- Яндекс.Дзен
- Пульс Mail.ru

### E-commerce
- Shopify
- WooCommerce
- Tilda
- Webflow

## Возможности
- Публикация с форматированием (Markdown, HTML)
- Загрузка медиа (изображения, видео)
- Управление категориями и тегами
- SEO-поля (title, description, keywords)
- Черновики и премодерация
- Планирование публикаций
- Массовая публикация
- Обновление существующих постов

## Команды
- `publish <platform> <content> [--draft]` — опубликовать
- `publish schedule <platform> <time> <content>` — запланировать
- `publish update <platform> <post_id> <new_content>` — обновить
- `publish list <platform> [--status=<status>]` — список постов
- `publish delete <platform> <post_id>` — удалить
- `publish bulk <platform> <file>` — массовая публикация

## Форматы контента
- Markdown (по умолчанию)
- HTML
- JSON (структурированные данные)
- Word/PDF (конвертация)

## Интеграции
- REST API каждой платформы
- GraphQL (Strapi, Ghost)
- XML-RPC (WordPress legacy)
- Webhooks для уведомлений

## Пример использования
```
publish wordpress "Моя новая статья" --draft
publish schedule medium "2024-01-01 10:00" "Новогодний пост"
publish update habr 12345 "Обновлённая версия"
publish bulk vc.ru articles.json
```

## Требования
- API ключи/токены для каждой платформы
- Права на публикацию
- Поддержка форматов контента
