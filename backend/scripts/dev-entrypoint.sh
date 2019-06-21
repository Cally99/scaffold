#!/bin/sh

set -e

echo "Waiting for PostgreSQL..."
while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
    sleep 0.25
done
echo "PostgreSQL started."

( exec "./scripts/deployment-tasks.sh" )

python manage.py runserver 0.0.0.0:8000 --nostatic
