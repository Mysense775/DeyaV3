---
name: "email-marketing"
description: "Email-маркетинг: рассылки, автоворонки, сегментация"
---

# Email Marketing Skill

## Назначение
Управление email-маркетингом: создание рассылок, автоворонок, сегментация аудитории и анализ эффективности.

## Поддерживаемые сервисы
- Mailchimp
- SendGrid
- UniSender
- SendPulse
- MailerLite
- ConvertKit
- AWS SES
- Яндекс.Почта для домена

## Возможности
### Рассылки
- Создание email-шаблонов
- Персонализация (имя, город, интересы)
- A/B тестирование тем и контента
- Планирование отправки
- Массовые рассылки

### Автоворонки
- Приветственные цепочки
- Триггерные письма (брошенная корзина, день рождения)
- Реактивация неактивных
- Пост-продажная коммуникация
- Обучающие серии

### Сегментация
- По активности (активные, спящие, потерянные)
- По интересам (теги, клики)
- По демографии (возраст, город, пол)
- По поведению (покупки, посещения)

### Аналитика
- Open rate, CTR, bounce rate
- Конверсии
- Отписки
- ROI по кампаниям

## Команды
- `email template <name> <content>` — создать шаблон
- `email campaign <name> [--template=<template>] [--segment=<segment>]` — создать кампанию
- `email schedule <campaign> <time>` — запланировать
- `email funnel <name> <triggers>` — создать воронку
- `email segment <name> <conditions>` — создать сегмент
- `email analytics <campaign>` — аналитика кампании
- `email abtest <campaign> <variants>` — A/B тест

## Триггеры для автоворонок
- `signup` — регистрация
- `purchase` — покупка
- `abandoned_cart` — брошенная корзина
- `birthday` — день рождения
- `inactive_30d` — неактивен 30 дней
- `click_link` — клик по ссылке

## Пример использования
```
email template "Welcome" "Добро пожаловать, {{name}}!"
email segment "Active Users" "last_open < 7_days"
email campaign "Newsletter #1" --template=Welcome --segment="Active Users"
email schedule "Newsletter #1" "2024-01-01 10:00"
email funnel "Onboarding" "signup -> wait_1d -> email_1 -> wait_3d -> email_2"
email abtest "Subject Test" "Вариант A|Вариант B"
```

## Интеграции
- CRM системы
- E-commerce платформы
- Формы захвата лидов
- Webhook-уведомления
