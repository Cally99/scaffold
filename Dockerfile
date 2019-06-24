# --------------------
# Base backend configuration which is used in development.
FROM python:3.7-slim-stretch AS base

LABEL Name=backend

# Don't write .pyc files.
ENV PYTHONDONTWRITEBYTECODE 1

# Don't buffer stdin and stdout.
ENV PYTHONUNBUFFERED 1

# Set the work directory.
WORKDIR /app

# Install system dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        netcat \
        curl \
        openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Install project dependencies.
RUN pip install --upgrade pip
RUN pip install pipenv
COPY ./backend/Pipfile ./backend/Pipfile.lock /app/
RUN pipenv install --system --deploy

# Copy backend code.
COPY ./backend /app/

# Run initialization script.
ENTRYPOINT ["./scripts/dev-entrypoint.sh"]

# --------------------
# Build Javascript for test in a separate stage.
FROM node:10-alpine as build-deps
WORKDIR /app

# Build Javascript.
COPY ./frontend /app/
RUN npm install && npm run build

# --------------------
# Prod configuration, also used for local testing.
FROM base as prod

# Copy over compiled Javascript.
COPY --from=build-deps /app/dist/ /app/dist/

# Add a non-root user.
RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser

# In production we will need to change ownership of the files to our
# non-root user since we won't be using a volume
RUN chown -R appuser /app/ && \
    chgrp -R appuser /app/

# Run as non-root user.
USER appuser
