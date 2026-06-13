---
name: "business-automation"
description: "Автоматизация бизнес-процессов: workflow, интеграции, триггеры"
---

# Business Automation Skill

## Назначение
Автоматизация бизнес-процессов: создание workflow, настройка триггеров и интеграция между различными сервисами.

## Возможности
### Workflow
- Визуальный конструктор процессов
- Условия и ветвления (if/then/else)
- Циклы и итерации
- Параллельные процессы
- Ожидание событий/времени
- Обработка ошибок

### Триггеры
- По времени (cron)
- По событию (webhook)
- По изменению данных
- По email
- По сообщению
- По API-запросу

### Интеграции
- CRM (Битрикс24, amoCRM, HubSpot)
- Почта (Gmail, Яндекс, Mail.ru)
- Мессенджеры (Telegram, Slack)
- Таблицы (Google Sheets, Excel)
- Формы (Google Forms, Typeform)
- Облако (Google Drive, Dropbox)
- Соцсети
- Платёжные системы

### Готовые шаблоны
- `lead_nurturing` — прогрев лидов
- `order_processing` — обработка заказов
- `support_ticket` — тикеты поддержки
- `content_calendar` — контент-план
- `employee_onboarding` — онбординг сотрудников
- `invoice_reminder` — напоминания об оплате
- `feedback_collection` — сбор отзывов

## Команды
- `automation create <name>` — создать workflow
- `automation trigger <name> <type> <config>` — добавить триггер
- `automation action <name> <action>` — добавить действие
- `automation connect <service> <credentials>` — подключить сервис
- `automation template <template_name>` — использовать шаблон
- `automation run <name>` — запустить
- `automation log <name>` — просмотреть логи
- `automation status <name>` — статус

## Примеры workflow

### Прогрев лидов
```
trigger: form_submit (landing page)
action: add_to_crm (amoCRM)
wait: 1 hour
action: send_email (welcome)
wait: 2 days
action: send_email (case_study)
condition: opened_email?
  yes: action: send_email (offer)
  no: action: send_telegram (manager)
```

### Обработка заказа
```
trigger: new_order (website)
action: create_invoice (1C)
action: send_email (order_confirmation)
action: notify_telegram (warehouse)
wait: until_payment
action: send_to_delivery (SDEK)
action: send_tracking (customer)
```

## Интеграции через API
- REST API
- GraphQL
- Webhooks
- Zapier (через API)
- Make.com (Integromat)
- n8n

## Мониторинг
- Логи выполнения
- Уведомления об ошибках
- Метрики эффективности
- Время выполнения

## Пример использования
```
automation create "LeadNurturing"
automation trigger "LeadNurturing" webhook "https://site.com/form"
automation action "LeadNurturing" "add_to_crm"
automation action "LeadNurturing" "send_email_welcome"
automation run "LeadNurturing"
automation log "LeadNurturing"
```

## Безопасность
- Шифрование данных
- Управление доступом
- Аудит действий
- Backup workflow
