# Exemple : User Story  

## User Story  
En tant qu’utilisateur de l’application mobile,  
je veux enregistrer la quantité d’eau que je bois chaque jour,  
afin de suivre ma consommation quotidienne.  

## Critères d’acceptation  
- [ ] Je peux ajouter une quantité d’eau (en cl ou en ml).  
- [ ] Je vois un total journalier qui se met à jour automatiquement.  
- [ ] Je peux modifier ou supprimer une entrée.  

### Modèle possible pour les critères : Synthaxe Gherkin
GIVEN : étant donné que ... Contexte utilisateur
WHEN : Quand ... Action utilisateur
THEN : Alors... Résultat de l'action

**Exemple : Payer par carte**

**ÉTANT DONNÉ QU**'un utlisateur Duflot Nicolas renseigne

    Son numéro de carte **********
    ET Le détenteur de la carte : DUFLOT
    ET Le trigramme de la carte : ***

**QUAND**

    il clique sur "valider le paiement"
    il reçoit une notification sur son smartphone pour la vérification en deux étapes
    et qu'il réussi la certification

**ALORS**

    il est redirigé vers la page de résumé de la transaction où figure le lien vers une facture pdf téléchargeable

## Notes / Contexte  
Cette fonctionnalité correspond au besoin principal identifié lors de la définition de la vision produit : **suivi basique de l’hydratation**.  
