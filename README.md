# scaffold

A basic project framework for building apps that have a Vue front end, Django back end, REST API in the middle, user sign up and authentication ready, Dockerized development and production environments, with a configuration for deployment to Heroku.

## Includes

* Django
* Django REST framework
* Django REST Auth and All Auth
* Vue
* Vue Router
* Vuex
* Vue CLI 3
* Gunicorn
* Dockerized development environment with Docker Compose
* Deployment to Heroku in Docker containers

## Setup

* Install these dependencies:
  * Docker
  * Python 3.7 (use pyenv if you prefer)
  * pipenv
  * nodejs
  * vue-cli
  * Heroku CLI
* Check out source from Github and cd into the project directory.
* Add a .env file to the project root that contains all relevant environment variables. See the section below on Environment Variables.
* Run the following and then see the section on Starting a development environment for further instructions.

```shell
> make init
> make dev-up
```

## Starting a development environment

```shell
> make dev-up
```

This will build and start the development environment. You should see all kinds of logs in the shell from the various Docker containers. Both the frontend and backend should automatically pick up changes to the filesystems as you do your development.

Check <http://localhost:8000/> to ensure things are working.

You can tear down the environment by hitting Ctrl-C, or in another terminal:

```shell
> make dev-down
```

## Starting a testing environment

This environment tries to mimic the pattern of deployment as closely to Heroku as is reasonable. Specifically, it bundles up the Javascript and lets whitenoise serve the files up. Also, no code reloading happens when changes are made to the local filesystem. All requests are proxied to Gunicorn.

```shell
> make test-up
```

This will build and start the test environment.

Check <http://localhost:8000/> to ensure things are working.

You can tear down the environment by hitting Ctrl-C, or in another terminal:

```shell
> make test-down
```

## Configuring your editor to point to the virtualenv Python

In the ./backend directory run `pipenv --venv` to get the path to the virtualenv Python, then configure your editor to point to that path as its Python. In Visual Studio Code this can be done in .vscode/settings.json by setting the python.pythonPath variable.

## Adding new Python dependencies

```shell
> cd ./backend
> pipenv install foo
> cd ..
> make dev-up
```

## Creating a new backend app

With the development environment running, to start a new app called foo:

```shell
> make new-backend-app name=foo
```

## Creating database migration files

With the development environment running:

```shell
> make migrations
```

## Migrating the database

With the development environment running, to actually execute the database migration:

```shell
> make migrate-db
```

## Creating a superuser

With the development environment running:

```shell
> make superuser
```

## Environment variables

All the environment variables are stored in a .env file in the project root. The production variables should all be stored in Heroku Config Vars. The following is a listing of all configuration variables that are available:

### Always required

* DOMAIN=localhost:8000 in development, your URL in production
* DJANGO_DEBUG=true in development, false in production
* DJANGO_SECRET_KEY=Your Django app's secret key

### Required in development

* POSTGRES_DB=
* POSTGRES_USER=
* POSTGRES_PASSWORD=
* POSTGRES_HOST=
* POSTGRES_PORT=

### Always optional

* DJANGO_EMAIL_BACKEND=Defaults to the console-based version which makes the next two settings irrelevant. Check [the docs](https://docs.djangoproject.com/en/2.2/topics/email/#email-backends) for more information.
* DJANGO_EMAIL_HOST=
* DJANGO_EMAIL_PORT=
* TLS_ENABLED=set true after SSL certificates have been configured in Heroku

### Optional in production

* DJANGO_STATIC_HOST=If using a CDN, set to your CDN's URL. See [here](http://whitenoise.evans.io/en/stable/django.html#instructions-for-amazon-cloudfront) for more information.

**NOTE:** In production, Heroku will automatically provide a DATABASE_URL configuration variable which will be injested by Django in place of the other database configuration variables.

## Deploying to Heroku

heroku stack:set container
Add database resource
