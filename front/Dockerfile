FROM node:20-alpine AS build

WORKDIR /src

COPY package*.json ./
COPY . .

RUN npm ci \
    && npx @angular/cli build --optimization

FROM alpine:3.19 AS runtime

RUN apk add --no-cache caddy

WORKDIR /app

COPY --from=build /src/dist/microcrm/browser /app/front
COPY Caddyfile /app/Caddyfile

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/caddy", "run", "--config", "/app/Caddyfile", "--adapter", "caddyfile"]
