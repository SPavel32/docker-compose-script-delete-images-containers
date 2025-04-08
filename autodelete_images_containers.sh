#!/bin/bash

# Остановка и удаление контейнеров, поднятых через docker-compose
docker-compose down

# Удаление образов, созданных docker-compose
images=$(docker-compose images -q)

if [ -n "$images" ]; then
  echo "Удаление образов: $images"
  echo "$images" | xargs docker rmi || echo "Ошибка при удалении образов"
else
  echo "Нет образов для удаления."
fi

# Получаем список всех контейнеров (даже остановленных), созданных docker-compose
containers=$(docker ps -a -q --filter="label=com.docker.compose.project")

if [ -n "$containers" ]; then
  echo "Удаление контейнеров: $containers"
  docker rm $containers || echo "Ошибка при удалении контейнеров"
else
  echo "Нет контейнеров для удаления."
fi