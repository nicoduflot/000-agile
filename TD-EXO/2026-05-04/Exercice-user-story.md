# Atelier : User stories

## Pitch

La communauté de communes souhaite doter sa médiathèque inter-communale d’une plateforme moderne, simple d’accès et pensée pour tous les habitants des cinq communes.  

Ce site web doit centraliser l’accès au catalogue, permettre la réservation et le retrait des œuvres, et devenir un véritable espace d’échanges culturels entre citoyens.  

À terme, il offrira des services adaptés à chacun, comme le click and collect, la procuration de collecte pour les personnes à mobilité réduite, et l’accès à des bornes en mairie pour faciliter l’inclusion numérique.  

L’objectif : créer un service public culturel fluide, collaboratif et accessible, renforçant le lien entre les habitants et leur médiathèque.

En reprenant l’exemple de la médiathèque, il faut créer 6 user stories sur les points suivants : 
* Connexion d’un utilisateur
* Liste des dernières œuvre et accès fiche d’une œuvre
* Fiche d’œuvre (Type d’œuvre, Titre, auteur(s), résumé, catégorie(s), et galerie de médias associés.)
* Réservation d’une œuvre si disponible
* Recherche d’œuvre par titre
* Recherche d’œuvre par auteur

Sous la forme : 

Titre

Description 
>En tant que...
>
>je peux / je dois...
>
>Afin de...

Test(s) fonctionnel(s)

**ÉTANT DONNÉ QUE**

    Description parcours utilisateur pour un résultat
    exemple : 
    un utlisateur Duflot Nicolas renseigne
    Son numéro de carte **********
    ET Le détenteur de la carte : DUFLOT
    ET Le trigramme de la carte : ***

**QUAND**

    Action(s) utilisateur
    Exemple : 
    il clique sur "valider le paiement"
    il reçoit une notification sur son smartphone pour la vérification en deux étapes
    et qu'il réussi la certification

**ALORS**

    Résultat et post condition(s)
    Exemple : 
    il est redirigé vers la page de résumé de la transaction 
    où figure le lien vers une facture pdf téléchargeable

## Corrections proposées

### Connexion d’un utilisateur

**Description**
**EN TANT QUE** 

    visiteur possédant un compte 
**JE DOIS** 
    
    renseigner mes identifiants
**AFIN DE**

    pouvoir accéder à mon compte
---

**Test(s) d’acceptation**

**ÉTANT DONNÉ QUE**

    un visiteur possédant un compte avec l’identifiant superBernard59
    et le mot de passe loulou59LePhalampin!
**QUAND**

	il se trompe sur son identifiant
	OU il se trompe sur son mot de passe
	OU il tente la connexion sans identifiant
	OU il tente la connexion sans mot de passe
        
    ET Qu’il clique sur le bouton « connexion »
    OU la touche « Entrée » du clavier
**ALORS**

    On refuse la connexion 
    ET un message d’alerte s’affiche indiquant 
    « Un problème lié aux identifiants empêche la connexion »

---

**ÉTANT DONNÉ QUE**

    un visiteur possédant un compte avec l’identifiant superBernard59 
    ET le mot de passe loulou59LePhalampin!
**QUAND**

    Il renseigne l’identifiant superBernard59 
    ET le mot de passe loulou59LePhalampin!

    ET Qu’il clique sur le bouton « connexion »
    OU la touche « Entrée » du clavier
**ALORS**

	Un message s’affiche durant 2 secondes 
    indiquant la réussite de connexion « Bienvenue superBernard59 »

### Liste des dernières œuvres et accès fiche d’une œuvre

**Description**
**EN TANT QUE**

    visiteur avec ou sans compte 
**JE DOIS**

    voir apparaître sur la page d’accueil de la médiathèque
    une liste des dernières œuvres enregistrées
**AFIN DE** 

    voir les nouveautés 
    ET de pouvoir accéder rapidement à la fiche d’œuvre d’une des œuvres présentées

---

**Test(s) d’acceptation**
**ÉTANT DONNÉ QUE**

    un visiteur avec ou sans compte
**QUAND** 
    
    il arrive sur la page d’accueil
**ALORS**
    
    est affiché la liste des 5 dernières œuvres enregistrées dans le fond d’œuvres : 
	- Le magicien d’oz (DVD)
	- Désolation (Livre)
	- Superunknown (CD)
	- L’attaque des titans (n°50)
	- JuJu tsu Kaizen (n°20)

---

**ÉTANT DONNÉ QUE**

    un visiteur avec ou sans compte
**QUAND** 

    il clique sur un élément de la liste
**ALORS**
    
    on le redirige vers la fiche d’œuvre nommée de la liste.

### Fiche d’œuvre (Type d’œuvre, Titre, auteur(s), résumé, catégorie(s), et galerie de médias associés.)

**Description **

**EN TANT QUE**
    
    visiteur avec ou sans compte 
**JE DOIS**
    
    voir les détails d’une œuvre sur la fiche d’œuvre
**AFIN DE**
    
    pouvoir accéder aux informations suivantes : 
        - Type d’œuvre
        - Titre, 
        - auteur(s), 
        - résumé, 
        - catégorie(s), 
        - galerie de médias associés 

---

**Test(s) d’acceptation**

**ÉTANT DONNÉ QUE**
    
    un visiteur avec ou sans compte
**QUAND**
    
    il est sur la fiche de l’œuvre : « le manuscrit inachevé »
**ALORS**

    il doit voir les informations suivantes :
        - Titre : « Le manuscrit inachevé »
        - Catégorie : « Polar »
        - Type d’œuvre : « Roman »
        - Résumé : « Lorem… »
        - Auteur : « Frank thilliez »
        - mais pas la galerie de média associée (pas de média associé)

---

**ÉTANT DONNÉ QUE**

    un visiteur avec ou sans compte
**QUAND**
    
    il est sur la fiche de l’œuvre : « Au-revoir là-haut »
**ALORS**
    
    il doit voir les informations suivantes :
        - Titre : « Au-revoir là-haut »
        - Catégorie : « Comédie dramatique »
        - Type d’œuvre : « Dvd »
        - Résumé : « Lorem… »
        - Auteur : « Albert Dupontel »
        - Galerie de média associée : bande-annonce et trois photos de tournage

### Réservation d’une œuvre si disponible

**Description**

**EN TANT QUE**
    utilisateur connecté
**JE DOIS**
    pouvoir connaître la disponibilité d’une œuvre 
**AFIN DE**
    pouvoir la réserver depuis sa fiche d’œuvre

---

**Test(s) d’acceptation**

**ÉTANT DONNÉ QUE**
    
    un utilisateur connecté voit le bouton de réservation de 
    l’œuvre « Nevermind the bollocks » des Sex Pistols sur la fiche d’œuvre
**QUAND**

    il clique sur le bouton de réservation
**ALORS**

    on confirme la disponibilité de l’œuvre 
    ET on la réserve pour enlèvement

---

**ÉTANT DONNÉ QUE**

    un utilisateur connecté sur la fiche de l’œuvre 
    Narnia « La sorcière, le lion et l’armoire » 

**QUAND**
    
    il ne voit pas le bouton de réservation

**ALORS**

    il voit à la place un message indiquant que l’œuvre n’est pas disponible

### Recherche d’œuvre par titre

**Description**

**EN TANT QUE**
    
    visiteur avec ou sans compte
**JE DOIS**
    
    pouvoir rechercher par titre la présence d’une œuvre dans le fond d’œuvre
**AFIN DE**
    
    voir une liste d’œuvres correspondant à ma recherche

---

**Test(s) d’acceptation**

**ÉTANT DONNÉ QUE**

    je recherche le titre « magicien d’Oz » 
**QUAND**

    je lance la recherche
**ALORS**
    
    on me propose la liste des œuvres ayant ce titre
    - deux livres 
    - deux films

---

**ÉTANT DONNÉ** 
    
    Que je cherche le titre « Les cent meilleures blagues de toto »
**QUAND**
    
    je lance la recherche
**ALORS**
    
    on m’indique qu’aucune œuvre n’est référencée avec ce titre

### Recherche d’œuvre par créateur

**Description**

**EN TANT QUE**
    
    visiteur avec ou sans compte
**JE DOIS**

    pouvoir rechercher par créateur la présence d’une œuvre dans le fond d’œuvre
**AFIN DE**
    
    voir une liste d’œuvres correspondant à ma recherche

---

**Test(s) d’acceptation**

**ÉTANT DONNÉ QUE**
    
    je recherche le créateur « Terry Pratchett » 
**QUAND**
    
    je lance la recherche
**ALORS**
    
    on me propose la liste des œuvres ayant ce titre
    (20 romans, un roman graphique et deux guides)

---

**ÉTANT DONNÉ**
    
    Que je cherche le créateur « Big Flo »
**QUAND**
    
    je lance la recherche
**ALORS**
    
    on m’indique qu’aucune œuvre n’est référencée avec ce créateur
