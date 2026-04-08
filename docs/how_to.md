
#### Configuration du déploiement CI/CD

##### Création d'un Personal Access Token (PAT)

Pour permettre au workflow GitHub Actions de publier des images Docker sur GitHub Container Registry, vous devez créer un Personal Access Token avec les permissions appropriées :

1. **Allez sur GitHub** : Paramètres → Developer settings → Personal access tokens → Tokens (classic)
2. **Cliquez** : "Generate new token (classic)"
3. **Nom du token** : `CR_PAT` (ou similaire)
4. **Permissions requises** :
   - ✅ `write:packages` - Permet de publier des packages
   - ✅ `read:packages` - Permet de lire les packages
   - ✅ `delete:packages` - Permet de supprimer des packages (optionnel)
5. **Expiration** : Choisissez une durée appropriée (recommandé : 30 jours ou plus)
6. **Cliquez** : "Generate token"
7. **⚠️ Important** : Copiez immédiatement le token généré (vous ne pourrez plus le voir après)

##### Configuration du secret dans le repository

1. **Allez dans votre repository** : Settings → Secrets and variables → Actions
2. **Cliquez** : "New repository secret"
3. **Nom** : `CR_PAT`
4. **Valeur** : Collez le token généré précédemment
5. **Cliquez** : "Add secret"

Le workflow utilisera automatiquement ce token pour s'authentifier auprès de GitHub Container Registry et publier les images Docker.