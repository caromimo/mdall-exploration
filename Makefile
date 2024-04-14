# Testing credentials (for development only - not for production)
direction = up
user = mdall
password = mdall
host = localhost
database = mdall
DATABASE_URL = postgres://$(user):$(password)@$(host):5432/$(database)?sslmode=disable

.PHONY: db
db:
	docker run -d -e POSTGRES_USER=$(user) -e POSTGRES_PASSWORD=$(password) --network=host postgres:14.11

.PHONY: connect
connect:
	psql --host=localhost --username=$(user) --dbname=$(database) --password

.PHONY: dump
dump:
	pg_dump -s -F p -E UTF-8 --host=localhost --username=$(user) --dbname=$(database) --password

.PHONY: migration
migration:
		migrate create -ext sql -dir migrations -seq $(name)

.PHONY: migrate
migrate:
		migrate -database $(DATABASE_URL) -path migrations $(direction)

.PHONY: stop
stop:
		docker stop $$(docker ps -q)