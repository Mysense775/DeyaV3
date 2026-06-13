---
name: "design-studio"
description: "Дизайн: графика, UI/UX, презентации, баннеры, мемы"
---

# Design Studio Skill

## Назначение
Создание визуального контента: графики, UI/UX макетов, презентаций, баннеров, мемов и других дизайн-материалов.

## Возможности
### Графика
- Создание баннеров для соцсетей
- Инфографика и диаграммы
- Обложки для статей/видео
- Логотипы и фирменный стиль
- Иллюстрации

### UI/UX
- Wireframes и прототипы
- Мокапы интерфейсов
- Дизайн-системы
- Компоненты (кнопки, формы, карточки)

### Презентации
- Слайды для выступлений
- Pitch decks
- Отчёты и аналитика
- Обучающие материалы

### Мемы и развлекательный контент
- Генерация мемов по шаблонам
- Комиксы
- GIF-анимации
- Стикеры

## Инструменты
- Canvas API для генерации изображений
- SVG для векторной графики
- HTML/CSS для макетов
- Figma API (чтение/экспорт)
- Canva API
- Unsplash/Pexels для стоковых фото

## Команды
- `design banner <size> <text> [--style=<style>]` — баннер
- `design infographic <data> [--type=<type>]` — инфографика
- `design ui <component> [--platform=<platform>]` — UI-компонент
- `design presentation <topic> [--slides=<count>]` — презентация
- `design meme <template> <text>` — мем
- `design logo <name> [--style=<style>]` — логотип
- `design cover <title> [--type=<type>]` — обложка

## Размеры для соцсетей
- Instagram: 1080x1080, 1080x1350, 1080x1920
- Facebook: 1200x630, 1080x1080
- Twitter: 1200x675, 1500x500
- VK: 1080x1080, 510x228
- YouTube: 1280x720, 2560x1440

## Стили
- `minimal` — минимализм
- `corporate` — корпоративный
- `creative` — креативный
- `retro` — ретро
- `futuristic` — футуристичный
- `playful` — игривый

## Пример использования
```
design banner 1080x1080 "Распродажа! -50%" --style=minimal
design infographic "data.json" --type=pie
design ui button --platform=mobile
design presentation "AI Trends 2024" --slides=10
design meme "drake" "Старый подход|Новый подход"
```

## Выходные форматы
- PNG, JPG (растр)
- SVG (вектор)
- PDF (презентации)
- HTML (интерактивные макеты)
- GIF (анимация)
