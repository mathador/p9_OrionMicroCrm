# Analyse de la Couverture de Tests - MicroCRM

Ce document présente l'état actuel des tests du projet ainsi que les recommandations pour atteindre un niveau de qualité logicielle professionnel.

## 1. Inventaire des tests actuels (État des lieux)

L'analyse montre une couverture de test principalement composée de "squelettes" générés automatiquement qui vérifient l'instanciation mais peu de logique métier.

| Module | Fichier / Cible | Type de test | Statut / Qualité | Couverture (est.) |
| :--- | :--- | :--- | :--- | :--- |
| **Backend** | `MicroCRMApplicationTests` | Intégration | Vérifie uniquement le chargement du contexte Spring. | ~5% |
| **Backend** | `PersonRepositoryIntegrationTest` | Intégration (Repo) | Test réel sur la méthode `findByEmail` de `PersonRepository`. | ~15% |
| **Backend** | Entités / Services | Unitaire | Aucun test sur la logique métier ou les contraintes JPA. | 0% |
| **Frontend** | `*.component.spec.ts` | Unitaire (UI) | Vérifie uniquement que le composant est "créé". | ~10% |
| **Frontend** | `*.service.spec.ts` | Unitaire (Logic) | Vérifie uniquement que le service est "créé". | ~10% |
| **Frontend** | Parcours critiques | E2E | Aucun test de bout en bout implémenté. | 0% |

---

## 2. Recommandations pour un Niveau Professionnel

Pour garantir la fiabilité d'un CRM en production, les tests suivants doivent être implémentés :

| Type de Test | Cible / Objectif | Outils / Librairies | Priorité |
| :--- | :--- | :--- | :--- |
| **Backend : Unitaires** | Validation des entités, calculs dans les services et gestion des exceptions métiers. | JUnit 5, AssertJ, Mockito | Haute |
| **Backend : API (Slice)** | Test des endpoints (Spring Data Rest) : codes HTTP, format JSON et pagination. | `@WebMvcTest`, MockMvc | Haute |
| **Backend : Intégration** | Flux complets (Service -> Repo -> DB) pour les scénarios de suppression en cascade. | `@SpringBootTest`, H2 | Moyenne |
| **Frontend : Unitaires** | Logique de filtrage du dashboard et validation des formulaires. | Jasmine, Karma | Haute |
| **Frontend : Intégration** | Simulation des appels API pour vérifier la gestion des erreurs (404, 500). | `HttpClientTestingModule` | Moyenne |
| **E2E (Bout en bout)** | Parcours utilisateur complet : "Création -> Edition -> Suppression d'un contact". | Cypress ou Playwright | Critique |
| **Sécurité** | Validation des permissions et protection contre les injections. | Spring Security Test | Haute |
| **Performance** | Temps de réponse des API sous charge. | k6 ou JMeter | Basse |

### Conclusion
La priorité immédiate est l'implémentation de **tests E2E** pour sécuriser les fonctionnalités critiques et de **tests unitaires sur les services** pour valider la manipulation des données.
