---
name: "video-content"
description: "Видео-контент: монтаж, генерация, субтитры, шортсы"
---

# Video Content Skill

## Назначение
Создание и обработка видео-контента: генерация, монтаж, добавление субтитров, создание шортсов/рилс.

## Возможности
### Генерация видео
- Текст в видео (text-to-video)
- Изображение в видео (image-to-video)
- AI-аватары и озвучка
- Слайд-шоу из фото
- Скринкасты

### Монтаж
- Обрезка и склейка
- Добавление переходов
- Наложение музыки и звуков
- Цветокоррекция
- Добавление текста/титров
- Замена фона (chroma key)

### Субтитры
- Автоматическая транскрибация
- Перевод субтитров
- Стилизация (шрифт, цвет, позиция)
- SRT, VTT форматы
- Субтитры для соцсетей (большие, цветные)

### Шортсы/Рилс/Reels
- Автоматическая нарезка из длинного видео
- Формат 9:16
- Добавление хуков (первые 3 секунды)
- Автоматические субтитры
- Трендовая музыка

## Инструменты
- FFmpeg (обработка видео)
- Whisper (транскрибация)
- Stable Video Diffusion (генерация)
- ElevenLabs (озвучка)
- Pexels/Pixabay (стоковое видео)

## Команды
- `video generate <prompt> [--duration=<sec>]` — сгенерировать видео
- `video edit <file> [--cut=<start-end>] [--music=<file>]` — отредактировать
- `video subtitles <file> [--lang=<lang>] [--style=<style>]` — добавить субтитры
- `video shorts <file> [--count=<n>] [--duration=<sec>]` — создать шортсы
- `video merge <files>` — склеить видео
- `video extract <file> [--audio|--frames]` — извлечь аудио/кадры

## Форматы
- MP4 (основной)
- MOV
- AVI
- WebM
- GIF (из видео)

## Размеры для платформ
- YouTube: 1920x1080 (16:9)
- Instagram Reels: 1080x1920 (9:16)
- TikTok: 1080x1920 (9:16)
- YouTube Shorts: 1080x1920 (9:16)
- VK Видео: 1920x1080 (16:9)

## Пример использования
```
video generate "Космический закат над океаном" --duration=10
video edit vlog.mp4 --cut=0:00-2:30 --music=background.mp3
video subtitles video.mp4 --lang=ru --style=large_yellow
video shorts podcast.mp4 --count=5 --duration=60
video merge intro.mp4+main.mp4+outro.mp4
```

## Интеграции
- YouTube API (загрузка)
- Instagram API
- TikTok API
- VK API
- Облачное хранилище
