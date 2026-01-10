.PHONY: app-up app-psql app-backup app-restore app-migrate \
        book-up book-psql book-backup book-restore book-migrate

# App DB (service: db, env: .env)
app-up:
	@./scripts/db-up.sh db .env

app-psql:
	@./scripts/db-psql.sh db .env

app-backup:
	@./scripts/db-backup.sh db .env ./backups

app-restore:
	@./scripts/db-restore.sh db .env $(file)

app-migrate:
	@./scripts/db-migrate.sh db .env ./migrations

# Book DB (service: book_db, env: .env.book)
book-up:
	@./scripts/db-up.sh book_db .env.book

book-psql:
	@./scripts/db-psql.sh book_db .env.book

book-backup:
	@./scripts/db-backup.sh book_db .env.book ./backups

book-restore:
	@./scripts/db-restore.sh book_db .env.book $(file)

book-migrate:
	@./scripts/db-migrate.sh book_db .env.book ./migrations
