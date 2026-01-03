# Инструкции по деплою на Render

## Настройка на Render

1. **Создайте новый Web Service** на Render
2. **Подключите репозиторий** GitHub
3. **Настройки сборки:**
   - **Environment**: `Docker`
   - **Dockerfile Path**: `./Dockerfile` (или просто `Dockerfile`)
   - **Docker Build Context**: `.` (точка - корень репозитория)

## Важно!

Убедитесь, что в настройках Render:
- **Root Directory** оставьте пустым (или установите в `.`)
- **Docker Build Context** должен быть `.` (корень репозитория)
- **Dockerfile Path** должен быть `Dockerfile` или `./Dockerfile`

## Проверка структуры репозитория

Убедитесь, что в корне репозитория есть:
```
├── Dockerfile
├── .dockerignore
├── backend/
│   ├── app/
│   └── requirements.txt
└── frontend/
    ├── package.json
    ├── package-lock.json
    └── src/
```

## Переменные окружения

На Render можно установить:
- `DATABASE_URL` (опционально, по умолчанию SQLite)
- `PYTHONUNBUFFERED=1`

## Если сборка не работает

1. Проверьте, что все файлы закоммичены в Git
2. Убедитесь, что `Dockerfile` находится в корне репозитория
3. Проверьте настройки Build Context в Render
4. Посмотрите логи сборки для деталей ошибок

