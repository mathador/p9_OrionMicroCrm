# Veille technologique

## Objectifs:
- les versions pertinentes des outils utilisés,
- les bonnes pratiques actuelles pour les pipelines CI/CD dans un contexte Full-Stack.

## Global

Le projet actuel est un monorepo.
Cette façon de gérer le code source est problématique dans le cadre de projet d'une certaine ampleur (comme l'est d'ailleurs un projet CRM).

La structure actuelle regroupe le front-end et le back-end sans isolation des cycles de vie. Toute modification **déclenche une reconstruction globale**, ce qui est inefficace pour le Lead Time

L'article Wikipédia liste trois inconvénients:

1. Perte d'informations de version
2. Absence de contrôle d'accès par projet
3. Plus d'espace de stockage requis par défaut

Voici les solutions envisageables:
- 1 repo = 1 projet
- 1 repo = 1 µservice

Pour le projet actuel on peut proposer la soluion 1 (un repo = un projet) qui donne un repo por le front et un repo pour le back


## CI/CD
Présence de Dockerfiles basiques. Les sources suggèrent des images potentiellement lourdes ou non optimisées.

Utiliser <node:18-alpine> pour le build Angular et <openjdk:17-slim> ou temurin pour le JAR Spring Boot final.

Automatiser l'analyse statique à chaque Pull Request pour détecter les bugs, vulnerabilities et code smells. Ajout d'un scanneur d'images type Twistlock

Configurer des workflows distincts (front.yml et back.yml) utilisant des triggers spécifiques sur les répertoires /front et /back.

## Front
La majorité des dépôts Angular sont en version 21.
Ce qui correspond à la version actuelle. https://endoflife.date/angular

Angular 17, TypeScript, nécessitant NPM >= 10.2.4


## Back

'org.springframework.boot' version '3.2.5'

'io.spring.dependency-management' version '1.1.4'

'com.adarshr.test-logger' version '4.0.0'

springframework boot
Version 3.5 est conseillée  https://endoflife.date/spring-boot

spring.dependency-management
Version 1.2 est conseillée

Java Spring Boot 3, nécessitant OpenJDK >= 17

