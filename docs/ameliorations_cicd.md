### 1. **Job Backend** 
   - Compile maintenant les tests ✓
   - **Compile le JAR** (nouveau) 
   - Upload le JAR comme artifact (nouveau) 

### 2. **Job Frontend**
   - Compile maintenant les tests ✓
   - **Compile la dist Angular** (nouveau)
   - Upload la dist comme artifact (nouveau)

### 3. **Job Deploy** (nouveau workflow)
   - **Télécharge les artifacts précompilés** (au lieu de les jeter)
   - Prépare le contexte Docker avec les binaires
   - Utilise le nouveau Dockerfile.deploy (sans étapes de build)

### 4. **Dockerfile.deploy** (nouveau fichier)
   - Image **ultra-légère** : juste assemble les artifacts précompilés
   - Aucune recompilation Java/Node.js
   - Utilise seulement le runtime (Temurin JRE + Caddy)

## 🎯 Avantages

| Critère | Avant | Après |
|---------|-------|-------|
| **Temps de déploiement** | ⏱️⏱️⏱️ (recompile tout) | ⏱️ (juste assemblage) |
| **Cohérence** | ❌ Code testé ≠ code déployé | ✅ Code testé = code déployé |
| **Traçabilité** | 🔴 Aucune | 🟢 Tests → Artifacts → Image |
| **Fiabilité** | 🟡 Risque de divergence | 🟢 Immuable |


