# Base Nginx configuration.
FROM nginx:1.17-alpine as base
RUN rm /etc/nginx/conf.d/default.conf

# Development configuration. No build dependencies as they are
# being served directly by Node in a separate container.
# Production will build over top of this but it's irrelevant.
# We also pass the command in docker-compose.yml rather than here
# since we're short-circuiting out.
FROM base as dev
COPY ./nginx/nginx.dev.conf /etc/nginx/nginx.conf

# Build dependencies in a separate stage.
FROM node:10-alpine as build-deps
WORKDIR /app

# Build Javascript.
COPY ./frontend /app/
RUN npm install && npm run build

# Production configuration.
FROM base as prod
COPY ./nginx/nginx.prod.conf /etc/nginx/nginx.conf

COPY --from=build-deps /app/dist/ /dist/
