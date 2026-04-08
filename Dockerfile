# Multi-stage build pour l'application complète MicroCRM
# Stage 1: Build du backend Java/Spring Boot
FROM gradle:8.7-jdk17 AS backend-build
WORKDIR /src
COPY back/ .
RUN gradle build -x test --no-daemon

# Stage 2: Build du frontend Angular
FROM node:20-alpine AS frontend-build
WORKDIR /src
COPY front/ .
RUN npm ci && npx @angular/cli build --optimization

# Stage 3: Image de production combinée
FROM eclipse-temurin:17-jre-jammy AS runtime

# Installation de Caddy pour servir le frontend
RUN apt-get update && apt-get install -y curl && \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg && \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list && \
    apt-get update && apt-get install -y caddy && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Création des répertoires de travail
WORKDIR /app

# Copie du JAR backend depuis le stage de build
COPY --from=backend-build /src/build/libs/microcrm-0.0.1-SNAPSHOT.jar /app/backend.jar

# Copie du frontend compilé depuis le stage de build
COPY --from=frontend-build /src/dist/microcrm/browser /app/front

# Configuration Caddy pour servir le frontend et proxy vers le backend
COPY front/Caddyfile /etc/caddy/Caddyfile

# Script de démarrage pour lancer les deux services
COPY docker/supervisor.ini /etc/supervisor/conf.d/microcrm.conf
RUN apt-get update && apt-get install -y supervisor && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Exposition des ports
EXPOSE 80 443 8080

# Commande de démarrage avec supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]