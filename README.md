# scaffold

A basic project framework for building apps that have a Vue front end, Django back end, REST API in the middle, user sign up and authentication ready, Dockerized development and production environments, with a configuration for deployment to Heroku. Pull requests and feedback are welcome!

## Includes

* Django
* django-rest-framework
* django-rest-auth
* django-all-auth
* Vue
* Vue Router
* Vuex
* Vue CLI 3
* Gunicorn
* Dockerized development environment with Docker Compose
* Deployment to Heroku in a Docker container

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

* DJANGO_ALLOWED_HOSTS=* in development, a list of URLs in production ([see the docs](https://docs.djangoproject.com/en/2.2/ref/settings/#allowed-hosts))
* DJANGO_DEBUG=true in development, false in production
* DJANGO_SECRET_KEY=Your Django app's secret key

### Required in development

* POSTGRES_DB=Pick a reasonable value, such as scaffold
* POSTGRES_USER=Pick a reasonable value, such as scaffold_user
* POSTGRES_PASSWORD=Pick a reasonably secure password
* POSTGRES_HOST=postgres, which is the name of the Docker container running Postgres in the development environment
* POSTGRES_PORT=5432

### Always optional

* DJANGO_EMAIL_BACKEND=Defaults to the console-based version which makes the next two settings irrelevant. Check [the docs](https://docs.djangoproject.com/en/2.2/topics/email/#email-backends) for more information.
* DJANGO_EMAIL_HOST=
* DJANGO_EMAIL_PORT=

### Optional in production

* DJANGO_STATIC_HOST=If using a CDN, set to your CDN's URL. See [here](http://whitenoise.evans.io/en/stable/django.html#instructions-for-amazon-cloudfront) for more information.
* TLS_ENABLED=set true after SSL certificates have been configured in Heroku

**NOTE:** In production, Heroku will automatically provide a DATABASE_URL configuration variable which will be injested by Django in place of the other database configuration variables.

## Deploying to Heroku

### In Heroku Web Console

* Set environment variables using Config Vars in Settings tab.
* Add Heroku Postgres Add-on in Resources tab.

### From Heroku CLI

Add the Heroku remote so you can deploy with git push:

```shell
> heroku git:remote -a your_app_name
```

Set things up so that Heroku uses the Docker container stack:

```shell
> heroku stack:set container
```

Add the Heroku remote to your repository:

```shell
> heroku git:remote -a name-of-your-project
```

Make some changes and then when ready to release:

```shell
git push heroku master
```

After a minute or two you should be able to open your app running in Heroku as such:

```shell
> heroku open
```

If that does not work you'll want check the Resources tab in the Heroku Dashboard to ensure that a dyno is actually running. If it isn't go ahead and start it.

If you wish to view the application logs in realtime, open another shell and do the following:

```shell
> heroku logs --tail
```

The next thing you'll probably want to do is create a superuser so you can access the Django Admin console:

```shell
> heroku run python manage.py createsuperuser
```

You should now be able to access and login to the Django Admin console at /admin.

The next thing you'll want to do is log in to the Admin console, navigate to Sites, and change the existing site Domain Name and Display Name to the URL of your app. This will ensure that Account Confirmation and Password Reset emails contain the correct URLs.

Pull requests and feedback are welcome. Enjoy!
