# Guide Complet : Créer un Parking Lot Diagram dans Excel

## 📋 Vue d'ensemble

Nous allons créer un fichier Excel avec 3 onglets :
1. **Données** - Votre tableau de suivi
2. **Dashboard** - Visualisation type "parking lot"
3. **Paramètres** - Configuration des couleurs et statuts

---

## 🎯 ÉTAPE 1 : Créer l'onglet "Données"

### 1.1 Structure du tableau

1. Créez un nouvel onglet et renommez-le **"Données"**
2. Créez les en-têtes en ligne 1 (A1 à I1) :

| A | B | C | D | E | F | G | H | I |
|---|---|---|---|---|---|---|---|---|
| Zone Fonctionnelle | Epic | Items Complétés | Items Total | % Complété | Statut | Release | Commentaires | Priorité |

3. **Mettez en forme les en-têtes** :
   - Sélectionnez A1:I1
   - Couleur de fond : Bleu foncé (RGB: 68, 84, 106)
   - Texte : Blanc, Gras
   - Alignement : Centré

### 1.2 Ajouter les données d'exemple

Copiez ces données en lignes 2 à 10 :
||||||||||
|--|--|--|--|--|--|--|--|--|
|Gestion Commandes | Créer commande | 8 | 12 | | En cours | v1.2 | Avancement régulier | Haute|
|Gestion Commandes | Valider commande | 5 | 5 | | Terminé | v1.1 | Déployé en prod | Moyenne|
|Gestion Commandes | Annuler commande | 2 | 8 | | À risque | v1.2 | Besoin ressources | Haute|
|Gestion Client | Créer profil client | 10 | 10 | | Terminé | v1.0 | Fonctionnel | Haute|
|Gestion Client | Modifier profil | 3 | 6 | | En cours | v1.2 | | Moyenne|
|Gestion Client | Supprimer compte | 0 | 4 | | Non démarré | v1.3 | Prévu prochain sprint | Basse|
|Facturation | Générer facture | 0 | 7 | | Non démarré | v1.3 | En attente specs | Haute|
|Facturation | Envoyer facture | 0 | 5 | | Non démarré | v1.3 | | Moyenne|
|Reporting | Dashboard analytics | 4 | 10 | | En cours | v1.2 | Phase design OK | Haute|

```
Gestion Commandes | Créer commande | 8 | 12 | | En cours | v1.2 | Avancement régulier | Haute
Gestion Commandes | Valider commande | 5 | 5 | | Terminé | v1.1 | Déployé en prod | Moyenne
Gestion Commandes | Annuler commande | 2 | 8 | | À risque | v1.2 | Besoin ressources | Haute
Gestion Client | Créer profil client | 10 | 10 | | Terminé | v1.0 | Fonctionnel | Haute
Gestion Client | Modifier profil | 3 | 6 | | En cours | v1.2 | | Moyenne
Gestion Client | Supprimer compte | 0 | 4 | | Non démarré | v1.3 | Prévu prochain sprint | Basse
Facturation | Générer facture | 0 | 7 | | Non démarré | v1.3 | En attente specs | Haute
Facturation | Envoyer facture | 0 | 5 | | Non démarré | v1.3 | | Moyenne
Reporting | Dashboard analytics | 4 | 10 | | En cours | v1.2 | Phase design OK | Haute
```

### 1.3 Formule de calcul du pourcentage

**En cellule E2**, entrez cette formule :
```excel
=SI(D2=0;"0%";C2/D2)
```

Puis :
1. Sélectionnez E2
2. Double-cliquez sur le petit carré en bas à droite (poignée de recopie)
3. La formule se copie automatiquement jusqu'à E10
4. **Formatez la colonne E** : Sélectionnez E2:E10 → Format de cellule → Pourcentage → 0 décimale

---

## 🎨 ÉTAPE 2 : Mise en forme conditionnelle

### 2.1 Coloriser selon le statut

1. **Sélectionnez la plage** A2:I100 (pour avoir de la marge)
2. Onglet **Accueil** → **Mise en forme conditionnelle** → **Nouvelle règle**
3. Choisissez : **Utiliser une formule pour déterminer les cellules à formater**

**Créez 4 règles (répétez l'opération 4 fois) :**

#### Règle 1 : Non démarré (Gris)
- Formule : `=$F2="Non démarré"`
- Format : Remplissage gris clair (RGB: 220, 220, 220)

#### Règle 2 : En cours (Bleu)
- Formule : `=$F2="En cours"`
- Format : Remplissage bleu clair (RGB: 173, 216, 230)

#### Règle 3 : Terminé (Vert)
- Formule : `=$F2="Terminé"`
- Format : Remplissage vert clair (RGB: 144, 238, 144)

#### Règle 4 : À risque (Rouge)
- Formule : `=$F2="À risque"`
- Format : Remplissage rouge/rose (RGB: 255, 182, 193)

### 2.2 Créer une liste déroulante pour les statuts

1. Sélectionnez **F2:F100**
2. Onglet **Données** → **Validation des données**
3. Paramètres :
   - Autoriser : **Liste**
   - Source : `Non démarré;En cours;Terminé;À risque`
4. Cochez **Liste déroulante dans la cellule**
5. Cliquez OK

**Répétez pour la colonne Priorité (I2:I100)** :
- Source : `Basse;Moyenne;Haute`

---

## 📊 ÉTAPE 3 : Créer l'onglet "Paramètres"

### 3.1 Créer un tableau de correspondance

1. Créez un nouvel onglet **"Paramètres"**
2. Créez ce tableau :

| A | B | C |
|---|---|---|
| **Statut** | **Couleur** | **Code RGB** |
| Non démarré | [Cellule grise] | 220,220,220 |
| En cours | [Cellule bleue] | 173,216,230 |
| Terminé | [Cellule verte] | 144,238,144 |
| À risque | [Cellule rouge] | 255,182,193 |

3. Colorisez manuellement les cellules de la colonne B selon les codes RGB

### 3.2 Ajouter des formules de statistiques

Plus bas dans le même onglet, créez ce tableau de statistiques :

```
A8: Statistiques Globales
A10: Total Epics:        B10: =NB(Données!B:B)-1
A11: Epics Terminés:     B11: =NB.SI(Données!F:F;"Terminé")
A12: Epics En Cours:     B12: =NB.SI(Données!F:F;"En cours")
A13: Epics À Risque:     B13: =NB.SI(Données!F:F;"À risque")
A14: Epics Non Démarrés: B14: =NB.SI(Données!F:F;"Non démarré")
A16: Avancement Global:  B16: =SOMME(Données!C:C)/SOMME(Données!D:D)
```

Format B16 en pourcentage.

---

## 🎯 ÉTAPE 4 : Créer le Dashboard visuel

### 4.1 Préparer les données par zone

1. Créez un nouvel onglet **"Dashboard"**
2. En A1, créez un titre : **"PARKING LOT DIAGRAM"** (Police 24, Gras, Centré)

### 4.2 Créer un tableau croisé dynamique

1. Retournez sur l'onglet **Données**
2. Cliquez sur une cellule du tableau
3. **Insertion** → **Tableau croisé dynamique**
4. Emplacement : Onglet **Dashboard**, cellule **A5**

**Configuration du TCD :**
- **Lignes** : Zone Fonctionnelle, puis Epic
- **Valeurs** : 
  - Items Complétés (Somme)
  - Items Total (Somme)
- **Filtres** : Statut

5. Cliquez droit sur le TCD → **Options du tableau croisé dynamique**
   - Décochez "Lignes de totaux généraux"
   - Décochez "Colonnes de totaux généraux"

### 4.3 Ajouter une colonne calculée au TCD

À droite du TCD, en colonne D, ajoutez un en-tête **"% Avancement"**

En D6 (première ligne de données), entrez :
```excel
=SI(C6=0;0%;B6/C6)
```

Copiez la formule vers le bas et formatez en pourcentage.

**arrêté là pour le moment**

### 4.4 Mise en forme conditionnelle du Dashboard

1. Sélectionnez toute la zone du TCD (A5:D50 environ)
2. **Mise en forme conditionnelle** → **Nouvelle règle**
3. Créez les mêmes 4 règles que précédemment, mais en vous basant sur les données filtrées

---

## 📈 ÉTAPE 5 : Créer des graphiques visuels

### 5.1 Graphique en barres par zone

1. Sélectionnez les zones et leur avancement (utilisez une plage consolidée)
2. **Insertion** → **Graphique en barres empilées**
3. Personnalisez :
   - Titre : "Avancement par Zone Fonctionnelle"
   - Couleurs : Utilisez les mêmes couleurs que les statuts
   - Retirez le quadrillage

### 5.2 Graphique en anneaux des statuts

1. Sélectionnez la plage des statistiques dans **Paramètres** (A11:B14)
2. **Insertion** → **Graphique en anneau**
3. Personnalisez avec vos 4 couleurs
4. Placez-le en haut du Dashboard

---

## 🚀 ÉTAPE 6 : Automatisation avec VBA (Optionnel)

Si vous voulez automatiser la mise à jour des couleurs, voici une macro simple :

### 6.1 Activer l'onglet Développeur

1. **Fichier** → **Options** → **Personnaliser le ruban**
2. Cochez **Développeur** → OK

### 6.2 Créer la macro de mise à jour

1. Onglet **Développeur** → **Visual Basic**
2. **Insertion** → **Module**
3. Collez ce code :

```vba
Sub MettreAJourCouleurs()
    Dim ws As Worksheet
    Dim lastRow As Long
    Dim i As Long
    
    Set ws = ThisWorkbook.Sheets("Données")
    lastRow = ws.Cells(ws.Rows.Count, "A").End(xlUp).Row
    
    For i = 2 To lastRow
        Select Case ws.Cells(i, 6).Value
            Case "Non démarré"
                ws.Rows(i).Interior.Color = RGB(220, 220, 220)
            Case "En cours"
                ws.Rows(i).Interior.Color = RGB(173, 216, 230)
            Case "Terminé"
                ws.Rows(i).Interior.Color = RGB(144, 238, 144)
            Case "À risque"
                ws.Rows(i).Interior.Color = RGB(255, 182, 193)
        End Select
    Next i
    
    MsgBox "Mise à jour des couleurs terminée!", vbInformation
End Sub
```

4. Fermez l'éditeur VBA
5. Retournez sur Excel → **Développeur** → **Macros**
6. Sélectionnez `MettreAJourCouleurs` → **Exécuter**

### 6.3 Créer un bouton pour la macro

1. Onglet **Données**, en haut à droite
2. **Développeur** → **Insérer** → **Bouton (Contrôle de formulaire)**
3. Dessinez un bouton
4. Associez-le à la macro `MettreAJourCouleurs`
5. Renommez le bouton : **"🔄 Actualiser les couleurs"**

---

## 📱 ÉTAPE 7 : Créer des segments de filtrage

Pour rendre le Dashboard interactif :

1. Cliquez sur le tableau croisé dynamique
2. **Analyse de tableau croisé dynamique** → **Insérer un segment**
3. Cochez : **Statut** et **Zone Fonctionnelle**
4. Positionnez les segments en haut du Dashboard
5. Personnalisez leur style dans **Options de segment**

---

## ✅ ÉTAPE 8 : Touches finales

### 8.1 Protection des formules

1. Sélectionnez les colonnes avec formules (E2:E100)
2. Clic droit → **Format de cellule** → **Protection**
3. Cochez **Verrouillée**
4. **Révision** → **Protéger la feuille**
5. Décochez "Sélectionner les cellules verrouillées"

### 8.2 Figer les volets

Sur l'onglet **Données** :
1. Cliquez sur la cellule **A2**
2. **Affichage** → **Figer les volets** → **Figer les volets**

### 8.3 Ajouter une légende au Dashboard

En haut du Dashboard, créez une zone de légende :

```
🟦 En cours   🟩 Terminé   🟥 À risque   ⬜ Non démarré
```

Utilisez des formes rectangulaires colorées ou simplement des cellules colorées.

---

## 💡 Conseils d'utilisation

### Mise à jour quotidienne
1. Ouvrez l'onglet **Données**
2. Mettez à jour les colonnes C (Items Complétés) et F (Statut)
3. Le % et les couleurs se mettent à jour automatiquement
4. Actualisez le TCD : Clic droit → **Actualiser**

### Partage avec l'équipe
- Enregistrez en **Excel 365** pour la compatibilité
- Ou exportez le Dashboard en **PDF** pour les présentations
- Utilisez **OneDrive** ou **SharePoint** pour la collaboration en temps réel

### Sauvegarde
- Créez une copie hebdomadaire pour historiser l'avancement
- Nommez : `ParkingLot_YYYY-MM-DD.xlsx`

---

## 🎓 Formules utiles supplémentaires

### Compter les jours depuis la dernière mise à jour
Ajoutez une colonne "Dernière MAJ" avec la date, puis :
```excel
=AUJOURDHUI()-J2
```

### Alerte si un epic dépasse 30 jours sans mise à jour
```excel
=SI(AUJOURDHUI()-J2>30;"⚠️ ALERTE";"OK")
```

### Calculer la vélocité (items complétés par semaine)
Si vous avez une colonne "Date de début" :
```excel
=C2/((AUJOURDHUI()-K2)/7)
```

---

## 🔧 Dépannage

**Problème : Les couleurs ne s'appliquent pas**
- Vérifiez que les règles de mise en forme conditionnelle sont dans le bon ordre
- Assurez-vous que la colonne F contient exactement les textes : "Non démarré", "En cours", "Terminé", "À risque"

**Problème : Les formules affichent #DIV/0!**
- C'est normal si Items Total = 0
- La formule SI(D2=0;"0%";C2/D2) gère ce cas

**Problème : Le TCD ne se met pas à jour**
- Clic droit sur le TCD → Actualiser
- Ou créez un bouton avec une macro d'actualisation automatique

---

## 🎯 Résultat final

Vous avez maintenant un outil de Parking Lot Diagram professionnel avec :
- ✅ Suivi en temps réel de vos epics
- ✅ Visualisation colorée automatique
- ✅ Dashboard interactif
- ✅ Statistiques globales
- ✅ Export et partage faciles

**Temps de création estimé : 30-45 minutes**

Bon reporting ! 🚀