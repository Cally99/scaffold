#!/bin/sh

set -e

( exec "./scripts/deployment-tasks.sh" )

gunicorn config.wsgi --bind 0.0.0.0:8000 --log-file=- --worker-tmp-dir /dev/shm --workers=2 --threads=4 --worker-class=gthread
