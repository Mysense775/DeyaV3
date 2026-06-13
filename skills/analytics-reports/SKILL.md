---
name: "analytics-reports"
description: "Аналитика и отчётность: метрики, дашборды, анализ данных"
---

# Analytics & Reports Skill

## Назначение
Сбор, анализ и визуализация данных из различных источников для создания отчётов и дашбордов.

## Источники данных
### Веб-аналитика
- Google Analytics 4
- Яндекс.Метрика
- Hotjar
- Mixpanel
- Amplitude

### Социальные сети
- Instagram Insights
- VK Stats
- Telegram Analytics
- Twitter Analytics
- Facebook Insights

### SEO
- Google Search Console
- Яндекс.Вебмастер
- Ahrefs
- SEMrush
- Serpstat

### E-commerce
- Яндекс.Маркет
- Ozon Seller
- Wildberries
- AliExpress

### Пользовательские источники
- CSV/Excel файлы
- Google Sheets
- Базы данных (SQL)
- API endpoints

## Возможности
- Автоматический сбор данных по расписанию
- Создание дашбордов (HTML, PDF, изображения)
- Сравнительный анализ (периоды, сегменты)
- Прогнозирование трендов
- Алерты при аномалиях
- Экспорт в различные форматы

## Типы отчётов
- `traffic` — анализ трафика
- `engagement` — вовлечённость
- `conversion` — конверсии
- `revenue` — выручка
- `custom` — пользовательский

## Команды
- `analytics connect <source> <credentials>` — подключить источник
- `analytics dashboard <name> [--sources=<sources>]` — создать дашборд
- `analytics report <type> [--period=<period>]` — сгенерировать отчёт
- `analytics schedule <report> <frequency>` — запланировать
- `analytics alert <metric> <condition>` — настроить алерт
- `analytics export <report> <format>` — экспортировать

## Визуализация
- Линейные графики
- Столбчатые диаграммы
- Круговые диаграммы
- Тепловые карты
- Таблицы с сортировкой
- KPI-карточки

## Пример использования
```
analytics connect ga4 "credentials.json"
analytics dashboard "Main Dashboard" --sources=ga4,instagram
analytics report traffic --period=last_30_days
analytics schedule "Weekly Report" weekly
analytics alert "bounce_rate > 70%"
analytics export "Main Dashboard" pdf
```

## Форматы вывода
- HTML (интерактивный)
- PDF (для печати)
- PNG/JPG (изображения)
- CSV/Excel (данные)
- JSON (API)
