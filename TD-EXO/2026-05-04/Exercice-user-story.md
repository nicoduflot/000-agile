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
    il est redirigé vers la page de résumé de la transaction où figure le lien vers une facture pdf téléchargeable