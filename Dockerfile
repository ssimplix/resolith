FROM alpine:3.8

# Update system packages
RUN apk update && apk upgrade

# Install Node.js and NPM
RUN apk add --upgrade nodejs \
  nodejs-npm

# Copy git repository files to image
COPY . /var/app

# Build an app
RUN cd /var/app && npm install --only=prod && npm run build
RUN mkdir -p /var/www/html/
RUN mv -f /var/app/dist/* /var/www/html/
RUN rm -rf /var/app

# Clear NPM cache
RUN npm cache clean --force

RUN apk del nodejs \
  nodejs-npm

# Clear APK cache
RUN rm -rf /var/cache/apk
