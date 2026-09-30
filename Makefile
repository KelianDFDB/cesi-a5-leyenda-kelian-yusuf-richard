.PHONY: up down restart rebuild logs shell

up:
	docker compose up -d --build

down:
	docker compose down

restart: down up

rebuild:
	docker compose build --no-cache --pull
	docker compose up -d

logs:
	docker compose logs -f

shell:
	docker compose exec lab bash
