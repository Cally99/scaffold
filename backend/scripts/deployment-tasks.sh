#!/bin/sh

set -e

echo "Running database migrations..."
python manage.py migrate --no-input
echo "Finished running database migrations."

echo "Collecting static files..."
python manage.py collectstatic --no-input
echo "Finished collecting static files."

exit 0
