FROM node:15.4.0-alpine as build

WORKDIR /var/www/html

# Copy git repository files to image
COPY . /var/www/html

ARG GOOGLE_ANALYTICS_ID
ARG YANDEX_METRIKA_ID
ARG GOOGLE_SITE_VERIFICATION_TOKEN
ARG YANDEX_SITE_VERIFICATION_TOKEN
ARG SENTRY_DSN

RUN npm ci --production && npm run build && npm cache clean --force

FROM alpine:3.14.0

ARG GIT_SHA
ENV GIT_SHA $GIT_SHA
LABEL git_sha="$GIT_SHA"

COPY --from=build /var/www/html/dist /var/www/html
