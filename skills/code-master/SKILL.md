---
name: "code-master"
description: "Работа с кодом: разработка, ревью, рефакторинг, генерация"
---

# Code Master Skill

## Назначение
Комплексная работа с кодом: разработка, код-ревью, рефакторинг, генерация тестов, документации и автоматизация DevOps-процессов.

## Языки программирования
- **Frontend**: JavaScript, TypeScript, React, Vue, Angular, HTML, CSS, SASS
- **Backend**: Python, Node.js, Go, Rust, Java, C#, PHP, Ruby
- **Mobile**: Swift, Kotlin, Flutter, React Native
- **Data**: SQL, Pandas, NumPy, R
- **DevOps**: Bash, PowerShell, YAML, Docker, Terraform
- **Other**: C/C++, Lua, Elixir, Haskell

## Возможности

### Генерация кода
- Создание функций и классов по описанию
- Генерация API endpoints
- CRUD-операции
- Шаблоны проектов (boilerplate)
- Генерация SQL-запросов
- Регулярные выражения
- Конфигурационные файлы

### Код-ревью
- Анализ качества кода
- Поиск багов и уязвимостей
- Проверка стиля (linting)
- Оптимизация производительности
- Проверка типов
- Анализ сложности (cyclomatic complexity)

### Рефакторинг
- Упрощение сложного кода
- Выделение функций/классов
- Переименование переменных
- Удаление дублирования
- Модернизация синтаксиса
- Конвертация между языками

### Тестирование
- Генерация unit-тестов
- Интеграционные тесты
- E2E тесты
- Моки и стабы
- Property-based testing
- Coverage analysis

### Документация
- Автогенерация docstrings
- README.md
- API документация (OpenAPI/Swagger)
- CHANGELOG
- Комментарии к коду
- Диаграммы (UML, flowcharts)

### DevOps
- Dockerfile и docker-compose
- CI/CD пайплайны (GitHub Actions, GitLab CI)
- Kubernetes манифесты
- Terraform конфигурации
- Скрипты деплоя
- Мониторинг и алерты

## Команды
- `code generate <description> [--lang=<lang>]` — сгенерировать код
- `code review <file>` — ревью кода
- `code refactor <file> [--goal=<goal>]` — рефакторинг
- `code test <file> [--type=<type>]` — сгенерировать тесты
- `code docs <file>` — сгенерировать документацию
- `code convert <file> --to=<lang>` — конвертировать язык
- `code optimize <file>` — оптимизировать
- `code explain <code>` — объяснить код
- `code debug <code> [--error=<error>]` — отладка

## Фреймворки и библиотеки
### Python
- Django, Flask, FastAPI
- Pandas, NumPy, SciPy
- TensorFlow, PyTorch
- Requests, BeautifulSoup
- pytest, unittest

### JavaScript/TypeScript
- React, Vue, Angular, Svelte
- Express, NestJS, Next.js
- Lodash, Moment, Axios
- Jest, Mocha, Cypress

### Go
- Gin, Echo, Fiber
- GORM, sqlx
- testify

### Rust
- Actix, Rocket
- Tokio, Serde
- Diesel

## Интеграции
- GitHub/GitLab API
- Bitbucket
- Jira
- SonarQube
- Sentry
- Docker Hub
- AWS/GCP/Azure APIs

## Пример использования
```
code generate "функция сортировки массива" --lang=python
code review app.py
code refactor legacy.js --goal="modern ES6+"
code test calculator.py --type=unit
code docs api.py
code convert script.py --to=go
code optimize slow_query.sql
code explain "recursive fibonacci"
code debug "index out of range" --error="runtime error"
```

## Безопасность
- Проверка на SQL-инъекции
- XSS-проверки
- Проверка зависимостей (vulnerabilities)
- Секреты и ключи (не коммитить!)
- OWASP Top 10

## Best Practices
- SOLID principles
- DRY, KISS, YAGNI
- Clean Code
- Design Patterns
- TDD/BDD
