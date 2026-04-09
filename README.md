<p Align="center">
   <img src="./front/src/favicon.png" width="192px" />
</p>

# MicroCRM ~~(P7 - Développeur Full-Stack - Java et Angular - Mettez en œuvre l'intégration et le déploiement continu d'une application Full-Stack)~~ Projet 9 - Gérez un projet d'intégration et de déploiement continue

MicroCRM est une application de démonstration basique ayant pour ~~être~~ objectif de servir de socle pour le module ~~"P7 - Développeur Full-Stack"~~ "Projet 9 - Gérez un projet d'intégration et de déploiement continue".

L'application MicroCRM est une implémentation simplifiée d'un ["CRM" (Customer Relationship Management)](https://fr.wikipedia.org/wiki/Gestion_de_la_relation_client). Les fonctionnalités sont limitées à la création, édition et la visualisations des individus liés à des organisations.

![Page d'accueil](./misc/screenshots/screenshot_1.png)
![Édition de la fiche d'un individu](./misc/screenshots/screenshot_2.png)

## Code source

### Organisation

Ce [monorepo](https://en.wikipedia.org/wiki/Monorepo) contient les 2 composantes du projet "MicroCRM":

- La partie serveur (ou "backend"), en Java SpringBoot 3;
- La partie cliente (ou "frontend"), en Angular 17.

### Démarrer avec les sources

#### Serveur

##### Dépendances

- [OpenJDK >= 17](https://openjdk.org/)

##### Procédure

1. Se positionner dans le répertoire `back` avec une invite de commande:

   ```shell
   cd back
   ```

2. Construire le JAR:

   ```shell
   # Sur Linux
   ./gradlew build

   # Sur Windows
   gradlew.bat build
   ```

3. Démarrer le service:

   ```shell
   java -jar build/libs/microcrm-0.0.1-SNAPSHOT.jar
   ```

Puis ouvrir l'URL http://localhost:8080 dans votre navigateur.

#### Client

##### Dépendances

- [NPM >= 10.2.4](https://www.npmjs.com/)

##### Procédure

1. Se positionner dans le répertoire `front` avec une invite de commande:

   ```shell
   cd front
   ```

2. (La première fois seulement) Installer les dépendances NodeJS:

   ```shell
   npm install
   ```

3. Démarrer le service de développement:

   ```shell
   npx @angular/cli serve
   ```

Puis ouvrir l'URL http://localhost:4200 dans votre navigateur.

### Exécution des tests

#### Client

**Dépendances**

- Google Chrome ou Chromium

Dans votre terminal:

```shell
cd front
CHROME_BIN=</path/to/google/chrome> 
npm test
```
Le navigateur s'ouvre et affiche les résultats

#### Serveur

Dans votre terminal:

```shell
cd back
.\gradlew.bat test
```
Le résultat du test sont situé dans:
```
back\build\reports\tests\test\index.html
```

### Images Docker

#### Client

##### Construire l'image

```shell
cd front
docker build -t orion-microcrm-front:latest .
```

##### Exécuter l'image

```shell
docker run -it --rm -p 80:80 -p 443:443 orion-microcrm-front:latest
```

L'application sera disponible sur https://localhost.

#### Serveur

##### Construire l'image

```shell
cd back
docker build -t orion-microcrm-back:latest .
```

##### Exécuter l'image

```shell
docker run -it --rm -p 8080:8080 orion-microcrm-back:latest
```

L'API sera disponible sur http://localhost:8080.

#### Application complète (Front + Back)

##### Récupérer l'image depuis GitHub Container Registry

L'image combinée est automatiquement construite et publiée via le CI/CD GitHub Actions lors des pushes sur la branche `main`.

**Note** : Par défaut, l'image est créée comme privée. Suivez les instructions dans `docs/how_to.md` pour la rendre publique.

```shell
# Pour une image publique (aucune authentification requise)
docker pull ghcr.io/mathador/p9_orionmicrocrm/microcrm:latest

# Pour une image privée (authentification requise)
echo $CR_PAT | docker login ghcr.io -u <votre-utilisateur> --password-stdin
docker pull ghcr.io/mathador/p9_orionmicrocrm/microcrm:latest
```

##### Lancer l'application complète

```shell
# Lancer l'application sur les ports 80 (HTTP) et 443 (HTTPS)
docker run -d \
  --name microcrm-app \
  -p 80:80 \
  -p 443:443 \
  ghcr.io/mathador/p9_orionmicrocrm/microcrm:latest
```

L'application sera alors accessible :
- **Frontend** : http://localhost (ou https://localhost pour HTTPS)
- **API Backend** : http://localhost:8080/api (accessible via le proxy du frontend)

##### Arrêter l'application

```shell
# Arrêter le conteneur
docker stop microcrm-app

# Supprimer le conteneur
docker rm microcrm-app
```

##### Logs et débogage

```shell
# Voir les logs des deux services (backend + frontend)
docker logs microcrm-app

# Accéder au conteneur en cours d'exécution
docker exec -it microcrm-app /bin/bash
```

#### Déploiement séparé

Les images frontend et backend peuvent être construites dans leurs projets respectifs (`front/` et `back/`).

#### Déploiement avec Docker Compose

Ce dépôt fournit un `docker-compose.yml` qui orchestre le build et le lancement des services frontend et backend.

##### Démarrer les services

```shell
docker-compose up --build
```

ou si le build a déjà été effectué:
```shell
docker-compose up -d
```

L'application sera disponible sur https://localhost et l'API sur http://localhost:8080.

##### Arrêter les services

```shell
docker-compose down
```

### Image en production

# Récupérer l'image
```shell
docker pull ghcr.io/mathador/p9_orionmicrocrm/microcrm:latest
```

# Lancer l'application
```shell
docker run -d --name microcrm-app -p 80:80 -p 443:443 ghcr.io/mathador/p9_orionmicrocrm/microcrm:latest
```