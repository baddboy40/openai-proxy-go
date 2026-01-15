# OpenAI Proxy - Docker Setup

Docker Compose конфигурация для запуска OpenAI Proxy.

## Требования

- Docker и Docker Compose
- Linux бинарник `proxy-linux` в корне проекта

## Быстрый старт

1. Убедитесь, что файл `proxy-linux` находится в корне проекта

2. Скопируйте пример конфигурации:
   ```bash
   cp env.example .env
   ```

3. Отредактируйте `.env` и заполните обязательные переменные:
   - `OPENAI_MASTER_API_KEY` - ваш OpenAI API ключ
   - `OUR_API_KEYS` - список клиентских ключей через запятую

4. Запустите:
   ```bash
   docker-compose up -d
   ```

## Проверка

```bash
curl http://localhost:3000/healthz
```

Просмотр логов:
```bash
docker-compose logs -f proxy
```

## Остановка

```bash
docker-compose down
```

## Конфигурация

Все настройки находятся в файле `.env`. Пример конфигурации в `env.example`.

### Обязательные переменные:
- `OPENAI_MASTER_API_KEY` - ваш OpenAI API ключ
- `OUR_API_KEYS` - список клиентских ключей через запятую

### Опциональные переменные:
- `OPENAI_BASE_URL` - базовый URL OpenAI API (по умолчанию: https://api.openai.com)
- `REQUEST_TIMEOUT` - таймаут запросов (по умолчанию: 30s)
- `ADMIN_API_KEY` - ключ для админских эндпоинтов
- `PROXY_PORT` - порт для proxy сервера (по умолчанию: 3000)
- `USE_MEMORY_STORE` - использовать память для хранения (по умолчанию: true)
