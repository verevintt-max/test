# Многоступенчатая сборка Dockerfile

# Этап 1: Сборка frontend
FROM node:18-alpine AS frontend-builder

WORKDIR /build

# Копируем весь контекст для доступа к файлам
COPY . .

# Проверяем, что скопировалось
RUN echo "=== Contents of /build ===" && ls -la && \
    echo "=== Contents of /build/frontend ===" && ls -la frontend/ || echo "frontend directory not found"

# Переходим в frontend
WORKDIR /build/frontend

# Проверяем наличие package.json
RUN echo "=== Checking for package.json ===" && \
    ls -la && \
    if [ ! -f package.json ]; then \
        echo "ERROR: package.json not found!" && \
        echo "Current directory: $(pwd)" && \
        echo "Contents:" && ls -la && \
        exit 1; \
    fi

# Устанавливаем зависимости
RUN npm install --legacy-peer-deps

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

# Копируем requirements.txt из первого этапа
COPY --from=frontend-builder /build/backend/requirements.txt ./

# Проверяем наличие requirements.txt
RUN if [ ! -f requirements.txt ]; then echo "ERROR: requirements.txt not found!" && exit 1; fi

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
