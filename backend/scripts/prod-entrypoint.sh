#!/bin/sh

set -e

# This has to run with startup, as the release phase runs in a separate dyno
# so all the work would be lost when the application actually starts up.
python manage.py collectstatic --no-input

gunicorn config.wsgi --log-file=- --worker-tmp-dir /dev/shm --workers=2 --threads=4 --worker-class=gthread
