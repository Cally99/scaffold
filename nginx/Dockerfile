# --------------------
# Base Nginx configuration which is used for development.
FROM nginx:1.17-alpine as base
RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx/nginx.dev.conf /etc/nginx/nginx.conf

# --------------------
# Test configuration.
FROM base as test
COPY ./nginx/nginx.test.conf /etc/nginx/nginx.conf
