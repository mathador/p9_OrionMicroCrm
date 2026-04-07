FROM node:20-alpine AS front-build

WORKDIR /src

COPY ./front/package*.json ./
COPY ./front ./

RUN npm ci \
    && npx @angular/cli build --configuration production

FROM gradle:8.7-jdk17 AS back-build

WORKDIR /src

COPY ./back ./

RUN gradle build -x test --no-daemon

FROM alpine:3.19 AS standalone

RUN apk add --no-cache openjdk21-jre-headless supervisor caddy

WORKDIR /app

COPY --from=front-build /src/dist/microcrm/browser /app/front
COPY --from=front-build /src/Caddyfile /app/Caddyfile
COPY --from=back-build /src/build/libs/microcrm-0.0.1-SNAPSHOT.jar /app/back/microcrm-0.0.1-SNAPSHOT.jar
COPY misc/docker/supervisor.ini /app/supervisor.ini

EXPOSE 80
EXPOSE 443
EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/app/supervisor.ini"]
