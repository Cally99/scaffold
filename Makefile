init:
	cd ./backend; pipenv update
	cd ./frontend; npm install

dev-up:
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build

dev-down:
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml down

test-up:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml up --build

test-down:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml down

# Some convenience functions for working with Django. If you need more
# then you'll have to run manage.py on your own by starting a shell
# on the running backend container.
migrations:
	docker exec --interactive scaffold_backend_1 python manage.py makemigrations

migrate-db:
	docker exec --interactive scaffold_backend_1 python manage.py migrate

new-backend-app:
	mkdir ./backend/apps/$(name) && docker exec --interactive scaffold_backend_1 python manage.py startapp $(name) ./apps/$(name)

superuser:
	docker exec --interactive --tty scaffold_backend_1 python manage.py createsuperuser
