postgres: 
	docker run --name my-postgres12 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=123456 -p 6432:5432 -d postgres:12-alpine

intergratepostgresql:
	docker exec -it my-postgres12 psql -U root simple_bank

createdb:
	docker exec -it my-postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it my-postgres12 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:123456@localhost:6432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:123456@localhost:6432/simple_bank?sslmode=disable" -verbose down

sqlc: 
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgre createdb dropdb sqlc test