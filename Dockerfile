# Многоступенчатая сборка Dockerfile

# Этап 1: Сборка frontend
FROM node:18-alpine AS frontend-builder

WORKDIR /build

# Копируем весь контекст для доступа к frontend
COPY . .

# Переходим в директорию frontend
WORKDIR /build/frontend

# Устанавливаем зависимости
RUN npm ci

# Собираем frontend
RUN npm run build

# Этап 2: Backend с Python
FROM python:3.11-slim

WORKDIR /app

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    gcc \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Копируем requirements.txt
COPY --from=frontend-builder /build/backend/requirements.txt ./

# Устанавливаем Python зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем код backend
COPY --from=frontend-builder /build/backend/ ./backend/

# Копируем собранный frontend из предыдущего этапа
COPY --from=frontend-builder /build/frontend/dist ./frontend/dist

# Создаем директории для uploads
RUN mkdir -p uploads/products uploads/qrcodes uploads/production_photos

# Устанавливаем переменные окружения
ENV PYTHONUNBUFFERED=1
ENV DATABASE_URL=sqlite:///./warehouse.db

# Открываем порт
EXPOSE 8000

# Команда запуска
CMD ["uvicorn", "backend.app.main:app", "--host", "0.0.0.0", "--port", "8000"]
