# Проверка файлов в Git

## Проблема
Если Docker не может найти файлы `frontend/package.json` и `backend/requirements.txt`, это означает, что они не закоммичены в Git.

## Решение

Выполните следующие команды в корне проекта:

```bash
# Проверьте статус файлов
git status

# Добавьте все файлы frontend (кроме node_modules)
git add frontend/package.json frontend/package-lock.json frontend/src/ frontend/*.json frontend/*.ts frontend/index.html

# Добавьте все файлы backend
git add backend/

# Проверьте, что файлы добавлены
git status

# Закоммитьте изменения
git commit -m "Add frontend and backend files for Docker build"

# Отправьте в репозиторий
git push
```

## Важно!

Убедитесь, что в `.gitignore` НЕ исключены:
- `frontend/package.json`
- `frontend/src/`
- `backend/app/`
- `backend/requirements.txt`

## Проверка

После коммита проверьте на GitHub, что файлы действительно в репозитории:
- `frontend/package.json` должен быть виден
- `backend/requirements.txt` должен быть виден
- `backend/app/` должен содержать файлы Python

