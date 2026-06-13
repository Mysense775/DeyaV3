---
name: "ai-assistant"
description: "ИИ-ассистент: GPT, Claude, Gemini, локальные модели"
---

# AI Assistant Skill

## Назначение
Унифицированный доступ к различным ИИ-моделям: GPT, Claude, Gemini, локальные модели через единый интерфейс.

## Поддерживаемые модели
### OpenAI
- GPT-4o
- GPT-4o-mini
- GPT-4-turbo
- DALL-E 3 (изображения)
- Whisper (аудио)

### Anthropic
- Claude 3.5 Sonnet
- Claude 3 Opus
- Claude 3 Haiku

### Google
- Gemini Pro
- Gemini Ultra
- Gemini Nano

### Локальные модели
- Llama 2/3
- Mistral
- Mixtral
- Vicuna
- LocalAI
- Ollama

### Другие
- Perplexity
- Cohere
- AI21 Labs
- Stability AI

## Возможности
### Текст
- Генерация и редактирование
- Перевод и суммаризация
- Анализ тональности
- Классификация
- Q&A
- Code generation

### Изображения
- Генерация (text-to-image)
- Редактирование (image-to-image)
- Анализ (image-to-text)
- Вариации

### Аудио
- Транскрибация
- Перевод
- Генерация речи (TTS)
- Распознавание команд

### Мультимодальность
- Анализ изображений + текст
- Видео + аудио + текст
- Документы (PDF, Word)

## Команды
- `ai ask <model> <prompt>` — задать вопрос
- `ai compare <models> <prompt>` — сравнить ответы моделей
- `ai generate <type> <prompt>` — сгенерировать контент
- `ai chat <model>` — начать диалог
- `ai system <prompt>` — задать системный промпт
- `ai fine-tune <model> <data>` — дообучить модель
- `ai embed <text>` — получить эмбеддинги

## Параметры
- `temperature` — креативность (0-2)
- `max_tokens` — максимальная длина
- `top_p` — nucleus sampling
- `frequency_penalty` — штраф за повторы
- `presence_penalty` — штраф за новые темы

## Пример использования
```
ai ask gpt-4 "Объясни квантовую физику простыми словами"
ai compare "gpt-4,claude,gemini" "Напиши стих про осень"
ai generate image "Кот в скафандре на Марсе"
ai chat claude
ai system "Ты — эксперт по маркетингу"
```

## Интеграции
- OpenAI API
- Anthropic API
- Google AI Studio
- LocalAI/Ollama
- Hugging Face
- Replicate

## Оптимизация
- Кэширование ответов
- Retry-логика
- Fallback между моделями
- Rate limiting
- Cost tracking

## Безопасность
- Фильтрация входных данных
- Модерация выходных данных
- Логирование (без sensitive data)
- API key management
