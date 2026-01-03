# Система управления складом и производством

Полнофункциональная система для управления складом материалов, производством изделий и продажами.

## Быстрый старт

### 1. Запустите Backend

Дважды кликните на файл: **start_backend.bat**

Или в командной строке:
```bash
start_backend.bat
```

Сервер будет доступен на: http://localhost:8000

### 2. Запустите Frontend

Дважды кликните на файл: **start_frontend.bat**

Или в командной строке:
```bash
start_frontend.bat
```

Приложение будет доступно на: http://localhost:3000

## Вход в систему

- **Администратор**: `admin` / `admin123`
- **Мастер**: `master` / `master123`
- **Менеджер**: `manager` / `manager123`

## Структура проекта

```
├── backend/          # FastAPI backend
│   ├── app/
│   │   ├── main.py   # Главный файл приложения
│   │   ├── models.py # Модели базы данных
│   │   ├── routers/  # API роутеры
│   └── requirements.txt
└── frontend/         # React + TypeScript frontend
    ├── src/
    │   ├── pages/    # Страницы приложения
    │   └── components/ # Компоненты
    └── package.json
```

## Требования

- Python 3.8+
- Node.js 16+
- npm или yarn

## Функциональность

- ✅ Управление справочником материалов
- ✅ Поступление материалов на склад
- ✅ Создание карточек изделий (техкарты)
- ✅ Производство готовых изделий
- ✅ Отчеты по остаткам
- ✅ Продажа/списание продукции
- ✅ История операций

## API документация

После запуска backend доступна по адресу: http://localhost:8000/docs

## Docker деплой

### Сборка и запуск с Docker

```bash
# Сборка образа
docker build -t warehouse-app .

# Запуск контейнера
docker run -d -p 8000:8000 \
  -v $(pwd)/warehouse_data:/app/warehouse_data \
  -v $(pwd)/uploads:/app/uploads \
  --name warehouse-app \
  warehouse-app
```

### Использование Docker Compose

```bash
# Запуск
docker-compose up -d

# Просмотр логов
docker-compose logs -f

# Остановка
docker-compose down
```

Приложение будет доступно на: http://localhost:8000

### Переменные окружения

- `DATABASE_URL` - URL базы данных (по умолчанию: `sqlite:///./warehouse.db`)
- `PYTHONUNBUFFERED` - для корректного вывода логов Python

### Важно

- База данных и загруженные файлы сохраняются в volumes для персистентности данных
- При первом запуске создается база данных SQLite
- Frontend автоматически собирается и раздается через backend
