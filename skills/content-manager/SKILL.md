---
name: "content-manager"
description: "Контент-менеджмент: планирование, календарь, генерация идей"
---

# Content Manager Skill

## Назначение
Управление контент-стратегией: планирование публикаций, контент-календарь, генерация идей, отслеживание трендов и анализ эффективности.

## Возможности
### Планирование
- Контент-календарь (неделя/месяц/квартал)
- Привязка к событиям и праздникам
- Повторяющиеся серии
- Приоритеты и дедлайны
- Назначение ответственных

### Генерация идей
- Анализ трендов
- Конкурентный анализ
- Поиск популярных тем
- Генерация заголовков
- Content gap analysis

### Типы контента
- Блог-посты
- Социальные сети
- Видео
- Подкасты
- Инфографика
- Новостные дайджесты
- Case studies
- Интервью

### Календарь публикаций
- Визуальный календарь
- Drag-and-drop
- Цветовая кодировка (типы/платформы)
- Экспорт (ICS, PDF)
- Интеграция с Google Calendar

### Тренды
- Google Trends
- Яндекс.Вордстат
- Тренды соцсетей
- Новостные агрегаторы
- Reddit/Hacker News

## Команды
- `content plan <period>` — создать план
- `content idea <topic> [--count=<n>]` — сгенерировать идеи
- `content calendar [--month=<month>]` — показать календарь
- `content schedule <post> <date> <platform>` — запланировать
- `content trend <topic> [--region=<region>]` — тренды
- `content analyze <post>` — анализ эффективности
- `content repurpose <content> <formats>` — адаптировать под форматы

## Форматы контента
- `post` — пост в соцсети
- `article` — статья
- `video` — видео
- `story` — сторис
- `reel` — рилс/шортс
- `carousel` — карусель
- `live` — прямой эфир
- `podcast` — подкаст

## Пример использования
```
content plan month
content idea "искусственный интеллект" --count=10
content calendar --month=january
content schedule "Новогодний пост" "2024-01-01" instagram
content trend "нейросети" --region=ru
content analyze post_123
content repurpose article "instagram,telegram,twitter"
```

## Интеграции
- Google Calendar
- Notion
- Trello
- Asana
- Google Sheets
- CMS (WordPress, Ghost)
- Социальные сети

## Аналитика
- Лучшее время публикации
- Engagement rate
- Reach и impressions
- CTR
- Конверсии

## Автоматизация
- Напоминания о дедлайнах
- Автопубликация по расписанию
- Репостинг между платформами
- Сбор обратной связи
