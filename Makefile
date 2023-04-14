help: ## Print help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: help

CONTAINER_PHP=php
CONTAINER_NGINX=nginx
CONTAINER_DB=mysql
CONTAINER_NODE=node

VOLUME_DB=laravel-docker-app_db_data

build: ## docker compose up with build
	@docker compose up -d --build

stop: ## docker compose stop
	@docker compose stop

up: ## docker compose up
	@docker compose up -d

down: ## docker compose down
	@docker compose down

ps:	## docker compose ps
	@docker compose ps

destroy: ## destroy all containers
	@docker compose down
	@if [ "$(shell docker volume ls --filter name=${VOLUME_DB}) --format {{Name}} }" ]; then \
		@docker volume rm ${VOLUME_DB}; \
	@fi

exec: ## exec to app
	@docker exec -it ${CONTAINER_PHP} bash

init: ## create a laravel fresh project


