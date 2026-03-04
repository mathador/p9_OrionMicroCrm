FROM node as front-build

COPY ./front /src

WORKDIR /src

RUN npm ci \
    && npx @angular/cli build --optimization
FROM gradle:8.7-jdk17 as back-build

USER root

WORKDIR /src

COPY ./back /src

RUN gradle -v
RUN ls -la /src
RUN gradle build -x test --info --no-daemon
FROM alpine:3.19 as front

COPY --from=front-build /src/dist/microcrm/browser /app/front
COPY misc/docker/Caddyfile /app/Caddyfile

RUN apk add caddy

WORKDIR /app

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/caddy", "run"]

FROM alpine:3.19 as back

COPY --from=back-build /src/build/libs/microcrm-0.0.1-SNAPSHOT.jar /app/back/microcrm-0.0.1-SNAPSHOT.jar

RUN apk add openjdk21-jre-headless

WORKDIR /app

EXPOSE 8080

CMD ["java", "-jar", "/app/back/microcrm-0.0.1-SNAPSHOT.jar"]

FROM alpine:3.19 as standalone

RUN apk add openjdk21-jre-headless supervisor caddy

COPY --from=front /app/front /app/front
COPY --from=front /app/Caddyfile /app/Caddyfile
COPY --from=back /app/back /app/back
COPY misc/docker/supervisor.ini /app/supervisor.ini

WORKDIR /app

EXPOSE 80
EXPOSE 443
EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/app/supervisor.ini"]



