# Description des exigences

Plusieurs méthodes peuvent être employées pour exprimer les exigences, la plus généralement utilisée en Agile est la User Story

Les user Stories sont tout d'abord découvertes par le Product Owner selon les contenus des livraisons qu'il a identifié dans la vision, sont ensuite conjointement affiné avec l'équipe de développement, tout d'abord lors d'un atelier de présentation du projet à l'équipe de développement, puis réaffiné durant le sprint planning.

## User Story

Description simplifiée d'une exigence par un tritre, un besoin fonctionnels et une série de tests d'acceptation fonctionnels.

### Description de l'exigence

Le formalisme de la description de l'exigence n'est pas imposé mais prend généralement la forme suivante :

>En tant que <rôle> ...
je veux <besoin traité par l'exigence> ...
afin de <résultat du besoin traité par l'exigence qui apporte de la valeur> ...

Cette phrase à trous à le mérite de permettre d'atteindre la granularité suffisante pour que l'exigence puisse être implémentée en un sprint

### Tests d'acceptation

Il s'agit des tests fonctionnels que le Product Owner écrit et qu'il utilisera pour valider ou non la validité de la fonctionnalité qui répond à l'exigence décrite.

**ATTENTION**
Les tests nécessitent des données tests qui seront véritablement utilisées, qui serviront et resserviront à l'avenir.
Les données peuvent être associées aux personna utilisateurs-utilisatrices utilisés par le Product Owner àfin d'établir la vision

Le formalisme n'est pas imposé mais la synthaxe Gherkin (utilisée par des frameworks qui permettent l'automatisation des tests fonctionnels) est de plus en plus utilisée et à l'avantage d'avoir une norme lisible et compréhensible par toutes et tous.

La synthaxe Gherkin peut se résumer à la suivante : 

> Given / When / Then (BDD)
>
> Given (Étant donné) / When (Quand ou lorsque) / Then (Alors)

Il est possible de compléter avec des opérateur logique AND (Et) / OR (Ou) / Not (Non)

Enfin il arrive parfois d'établir le Background (contexte de l'exigence) avec un G/W/T qui précise l'état des données ou de la situation utilisateur en entré.

```
Given <un contexte>
  AND <une condition du contexte ou une règle>
When <une action est faîte>
  AND <une autra action>
  OR <ou une autre condition>
Then <le résultat / réaction attendu>
```

Un exemple sur le github de l'application [Easybacklog](https://github.com/mattheworiordan/easybacklog) : 

```Gherkin
Feature: Backlog
  In order to manage my themes and stories
  A visitor
  Should be able to set up and edit a backlog

  Background:
    Given the database has the necessary lookup tables
      And a user named "John" is registered
      And I am signed in as "John"
      And an account called "Acme" is set up for "John"
      And a standard backlog named "Acme Backlog" is set up for "Acme"
    When I am on the accounts page
      Then I should see the page title "Acme"

  Scenario: Create a new backlog
    When I follow "Create a new backlog"
      And I press "Create new backlog"
    Then I should see the following error messages:
      | Name can't be blank             |
      # Check that default values are being used from Account
      And the "Use the 50/90 estimation method" checkbox should be checked
      And the "Rate" field should contain "800"
      And the "Velocity" field should contain "3"
      And the "Modified Fibonacci" checkbox should be checked
    When I fill in "Name the backlog" with "Project X"
      And I press "Create new backlog"
    Then I should see the notice "Backlog was successfully created."

    When I follow "← Back to dashboard"
      And I should see "Project X" within the "backlog list"
```

Ici les données sont réelles et le résultat attendu attend des données précises.