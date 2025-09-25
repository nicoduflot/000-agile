# Syntaxe Gherkin

## Définition
La **syntaxe Gherkin** est un langage structuré en texte simple permettant de décrire des scénarios de test lisibles par tous (métier et technique).  
Elle est utilisée pour formaliser les **tests d’acceptation** d’une user story, en décrivant le **parcours utilisateur attendu**.

## Objectifs
- Fournir une **description claire et partagée** du comportement attendu.  
- Relier directement les **user stories** aux **tests d’acceptation**.  
- Faciliter la collaboration entre métier, testeurs et développeurs.  
- Permettre une **automatisation des tests** grâce à des outils comme Cucumber.  

## Participants
- **Product Owner** : définit les critères d’acceptation métier.  
- **Équipe de développement** : formalise et automatise les scénarios.  
- **Testeurs / QA** : valident la couverture et la pertinence des cas.  
- **Parties prenantes** : peuvent lire et comprendre les scénarios car le langage est naturel.  

## Livrables
- Un ensemble de scénarios Gherkin décrivant les **comportements attendus** pour une user story.  
- Des tests automatisés (optionnel) validant ces scénarios.  

## Bonnes pratiques
- Rédiger les scénarios en suivant la structure :  
  ```gherkin
  Fonctionnalité: Connexion utilisateur
    Scénario: Connexion réussie avec des identifiants valides
      Étant donné un utilisateur enregistré avec l’email "test@mail.com"
      Quand il saisit son email et son mot de passe correct
      Alors il accède à son tableau de bord

* Utiliser les mots-clés :
    * Étant donné (Given) → contexte initial
    * Quand (When) → action de l’utilisateur
    * Alors (Then) → résultat attendu
* Employer des données réalistes pour refléter les vrais parcours utilisateurs.
* Couvrir à la fois les scénarios positifs et les cas limites (erreurs, exceptions).
* Limiter chaque scénario à un comportement clair et lisible.

## Anti-patterns
* Rédiger des scénarios trop techniques, incompréhensibles pour le métier.
* Multiplier les scénarios trop proches, au lieu de factoriser les comportements communs.
* Écrire des tests d’acceptation sans données réalistes (perte de pertinence).
* Détacher les scénarios de leur user story d’origine.
* Transformer Gherkin en documentation exhaustive plutôt qu’un outil d’exemple et de validation.