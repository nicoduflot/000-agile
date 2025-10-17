-- =====================================================
-- SCRIPT DE CRÉATION BASE DE DONNÉES PARKING LOT
-- Version MySQL 8.0+
-- =====================================================

-- Création de la base de données
CREATE DATABASE IF NOT EXISTS parking_lot_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE parking_lot_db;

-- =====================================================
-- TABLE : UTILISATEUR
-- =====================================================
CREATE TABLE utilisateur (
    id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    mot_de_passe_hash VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Manager', 'Developpeur', 'Observateur') NOT NULL DEFAULT 'Observateur',
    actif BOOLEAN NOT NULL DEFAULT TRUE,
    derniere_connexion DATETIME NULL,
    date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_modification DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_email (email),
    INDEX idx_role (role),
    INDEX idx_actif (actif)
) ENGINE=InnoDB;

-- =====================================================
-- TABLE : RELEASE
-- =====================================================
CREATE TABLE `release` (
    id_release INT AUTO_INCREMENT PRIMARY KEY,
    nom_release VARCHAR(100) NOT NULL UNIQUE,
    version VARCHAR(50) NOT NULL,
    date_prevue DATE NULL,
    date_effective DATE NULL,
    statut ENUM('Planifiee', 'En_cours', 'Terminee', 'Annulee') NOT NULL DEFAULT 'Planifiee',
    notes TEXT NULL,
    date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_modification DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_statut (statut),
    INDEX idx_date_prevue (date_prevue)
) ENGINE=InnoDB;

-- =====================================================
-- TABLE : ZONE_FONCTIONNELLE
-- =====================================================
CREATE TABLE zone_fonctionnelle (
    id_zone INT AUTO_INCREMENT PRIMARY KEY,
    nom_zone VARCHAR(150) NOT NULL UNIQUE,
    description TEXT NULL,
    ordre_affichage INT NOT NULL DEFAULT 0,
    couleur_hex VARCHAR(7) NOT NULL DEFAULT '#667eea',
    actif BOOLEAN NOT NULL DEFAULT TRUE,
    date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_modification DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_ordre (ordre_affichage),
    INDEX idx_actif (actif)
) ENGINE=InnoDB;

-- =====================================================
-- TABLE : EPIC
-- =====================================================
CREATE TABLE epic (
    id_epic INT AUTO_INCREMENT PRIMARY KEY,
    id_zone INT NOT NULL,
    id_release INT NULL,
    nom_epic VARCHAR(200) NOT NULL,
    description TEXT NULL,
    items_completes INT NOT NULL DEFAULT 0,
    items_total INT NOT NULL DEFAULT 0,
    statut ENUM('Non_demarre', 'En_cours', 'Termine', 'A_risque') NOT NULL DEFAULT 'Non_demarre',
    priorite ENUM('Basse', 'Moyenne', 'Haute', 'Critique') NOT NULL DEFAULT 'Moyenne',
    date_debut DATE NULL,
    date_fin_prevue DATE NULL,
    date_fin_reelle DATE NULL,
    objectif_metier TEXT NULL,
    actif BOOLEAN NOT NULL DEFAULT TRUE,
    date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_modification DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_zone) REFERENCES zone_fonctionnelle(id_zone) ON DELETE CASCADE,
    FOREIGN KEY (id_release) REFERENCES `release`(id_release) ON DELETE SET NULL,
    
    INDEX idx_zone (id_zone),
    INDEX idx_release (id_release),
    INDEX idx_statut (statut),
    INDEX idx_priorite (priorite),
    INDEX idx_actif (actif),
    
    UNIQUE KEY uk_zone_epic (id_zone, nom_epic),
    
    -- Contrainte : items_completes <= items_total
    CHECK (items_completes <= items_total),
    CHECK (items_completes >= 0),
    CHECK (items_total >= 0)
) ENGINE=InnoDB;

-- =====================================================
-- TABLE : ITEM
-- =====================================================
CREATE TABLE item (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_epic INT NOT NULL,
    id_assignee INT NULL,
    titre VARCHAR(255) NOT NULL,
    description TEXT NULL,
    statut ENUM('A_faire', 'En_cours', 'Termine', 'Bloque') NOT NULL DEFAULT 'A_faire',
    estimation_heures INT NULL,
    temps_passe INT NULL DEFAULT 0,
    date_debut DATE NULL,
    date_fin DATE NULL,
    date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_modification DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_epic) REFERENCES epic(id_epic) ON DELETE CASCADE,
    FOREIGN KEY (id_assignee) REFERENCES utilisateur(id_utilisateur) ON DELETE SET NULL,
    
    INDEX idx_epic (id_epic),
    INDEX idx_assignee (id_assignee),
    INDEX idx_statut (statut)
) ENGINE=InnoDB;

-- =====================================================
-- TABLE : HISTORIQUE_EPIC
-- =====================================================
CREATE TABLE historique_epic (
    id_historique INT AUTO_INCREMENT PRIMARY KEY,
    id_epic INT NOT NULL,
    id_utilisateur INT NULL,
    champ_modifie VARCHAR(100) NOT NULL,
    ancienne_valeur TEXT NULL,
    nouvelle_valeur TEXT NULL,
    commentaire TEXT NULL,
    date_modification DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_epic) REFERENCES epic(id_epic) ON DELETE CASCADE,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE SET NULL,
    
    INDEX idx_epic (id_epic),
    INDEX idx_utilisateur (id_utilisateur),
    INDEX idx_date (date_modification)
) ENGINE=InnoDB;

-- =====================================================
-- TABLE : COMMENTAIRE
-- =====================================================
CREATE TABLE commentaire (
    id_commentaire INT AUTO_INCREMENT PRIMARY KEY,
    id_epic INT NOT NULL,
    id_utilisateur INT NOT NULL,
    contenu TEXT NOT NULL,
    important BOOLEAN NOT NULL DEFAULT FALSE,
    date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_modification DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_epic) REFERENCES epic(id_epic) ON DELETE CASCADE,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE,
    
    INDEX idx_epic (id_epic),
    INDEX idx_utilisateur (id_utilisateur),
    INDEX idx_important (important)
) ENGINE=InnoDB;

-- =====================================================
-- TRIGGERS
-- =====================================================

-- Trigger pour mettre à jour items_completes automatiquement
DELIMITER //

CREATE TRIGGER trg_update_epic_items_after_insert
AFTER INSERT ON item
FOR EACH ROW
BEGIN
    UPDATE epic
    SET items_total = items_total + 1
    WHERE id_epic = NEW.id_epic;
    
    IF NEW.statut = 'Termine' THEN
        UPDATE epic
        SET items_completes = items_completes + 1
        WHERE id_epic = NEW.id_epic;
    END IF;
END//

CREATE TRIGGER trg_update_epic_items_after_update
AFTER UPDATE ON item
FOR EACH ROW
BEGIN
    -- Si le statut passe à Terminé
    IF OLD.statut != 'Termine' AND NEW.statut = 'Termine' THEN
        UPDATE epic
        SET items_completes = items_completes + 1
        WHERE id_epic = NEW.id_epic;
    END IF;
    
    -- Si le statut était Terminé et ne l'est plus
    IF OLD.statut = 'Termine' AND NEW.statut != 'Termine' THEN
        UPDATE epic
        SET items_completes = items_completes - 1
        WHERE id_epic = NEW.id_epic;
    END IF;
END//

CREATE TRIGGER trg_update_epic_items_after_delete
AFTER DELETE ON item
FOR EACH ROW
BEGIN
    UPDATE epic
    SET items_total = items_total - 1
    WHERE id_epic = OLD.id_epic;
    
    IF OLD.statut = 'Termine' THEN
        UPDATE epic
        SET items_completes = items_completes - 1
        WHERE id_epic = OLD.id_epic;
    END IF;
END//

-- Trigger pour historiser les modifications d'epic
CREATE TRIGGER trg_historique_epic_update
AFTER UPDATE ON epic
FOR EACH ROW
BEGIN
    IF OLD.statut != NEW.statut THEN
        INSERT INTO historique_epic (id_epic, champ_modifie, ancienne_valeur, nouvelle_valeur)
        VALUES (NEW.id_epic, 'statut', OLD.statut, NEW.statut);
    END IF;
    
    IF OLD.items_completes != NEW.items_completes THEN
        INSERT INTO historique_epic (id_epic, champ_modifie, ancienne_valeur, nouvelle_valeur)
        VALUES (NEW.id_epic, 'items_completes', OLD.items_completes, NEW.items_completes);
    END IF;
    
    IF OLD.items_total != NEW.items_total THEN
        INSERT INTO historique_epic (id_epic, champ_modifie, ancienne_valeur, nouvelle_valeur)
        VALUES (NEW.id_epic, 'items_total', OLD.items_total, NEW.items_total);
    END IF;
END//

DELIMITER ;

-- =====================================================
-- VUES UTILES
-- =====================================================

-- Vue : Statistiques par zone
CREATE VIEW v_stats_par_zone AS
SELECT 
    z.id_zone,
    z.nom_zone,
    COUNT(e.id_epic) as nb_epics,
    SUM(CASE WHEN e.statut = 'Termine' THEN 1 ELSE 0 END) as epics_termines,
    SUM(CASE WHEN e.statut = 'En_cours' THEN 1 ELSE 0 END) as epics_en_cours,
    SUM(CASE WHEN e.statut = 'A_risque' THEN 1 ELSE 0 END) as epics_a_risque,
    SUM(CASE WHEN e.statut = 'Non_demarre' THEN 1 ELSE 0 END) as epics_non_demarres,
    SUM(e.items_completes) as total_items_completes,
    SUM(e.items_total) as total_items,
    CASE 
        WHEN SUM(e.items_total) > 0 
        THEN ROUND((SUM(e.items_completes) / SUM(e.items_total)) * 100, 2)
        ELSE 0
    END as pourcentage_avancement
FROM zone_fonctionnelle z
LEFT JOIN epic e ON z.id_zone = e.id_zone AND e.actif = TRUE
WHERE z.actif = TRUE
GROUP BY z.id_zone, z.nom_zone;

-- Vue : Détail complet des epics
CREATE VIEW v_epics_detail AS
SELECT 
    e.id_epic,
    e.nom_epic,
    z.nom_zone,
    r.nom_release,
    r.version,
    e.statut,
    e.priorite,
    e.items_completes,
    e.items_total,
    CASE 
        WHEN e.items_total > 0 
        THEN ROUND((e.items_completes / e.items_total) * 100, 2)
        ELSE 0
    END as pourcentage_completion,
    e.date_debut,
    e.date_fin_prevue,
    e.date_fin_reelle,
    DATEDIFF(COALESCE(e.date_fin_reelle, CURDATE()), e.date_debut) as jours_en_cours,
    (SELECT COUNT(*) FROM commentaire c WHERE c.id_epic = e.id_epic) as nb_commentaires
FROM epic e
INNER JOIN zone_fonctionnelle z ON e.id_zone = z.id_zone
LEFT JOIN `release` r ON e.id_release = r.id_release
WHERE e.actif = TRUE;

-- Vue : Dashboard global
CREATE VIEW v_dashboard_global AS
SELECT 
    COUNT(*) as total_epics,
    SUM(CASE WHEN statut = 'Termine' THEN 1 ELSE 0 END) as epics_termines,
    SUM(CASE WHEN statut = 'En_cours' THEN 1 ELSE 0 END) as epics_en_cours,
    SUM(CASE WHEN statut = 'A_risque' THEN 1 ELSE 0 END) as epics_a_risque,
    SUM(CASE WHEN statut = 'Non_demarre' THEN 1 ELSE 0 END) as epics_non_demarres,
    SUM(items_completes) as total_items_completes,
    SUM(items_total) as total_items,
    CASE 
        WHEN SUM(items_total) > 0 
        THEN ROUND((SUM(items_completes) / SUM(items_total)) * 100, 2)
        ELSE 0
    END as pourcentage_global
FROM epic
WHERE actif = TRUE;

-- =====================================================
-- DONNÉES DE TEST
-- =====================================================

-- Utilisateurs
INSERT INTO utilisateur (email, nom, prenom, mot_de_passe_hash, role) VALUES
('admin@parkinglot.com', 'Admin', 'Système', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Admin'),
('manager@parkinglot.com', 'Dupont', 'Jean', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Manager'),
('dev1@parkinglot.com', 'Martin', 'Marie', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Developpeur');

-- Releases
INSERT INTO `release` (nom_release, version, date_prevue, statut) VALUES
('Release 1.0', '1.0.0', '2025-01-15', 'Terminee'),
('Release 1.1', '1.1.0', '2025-03-01', 'Terminee'),
('Release 1.2', '1.2.0', '2025-06-15', 'En_cours'),
('Release 1.3', '1.3.0', '2025-09-30', 'Planifiee');

-- Zones fonctionnelles
INSERT INTO zone_fonctionnelle (nom_zone, description, ordre_affichage, couleur_hex) VALUES
('Gestion Commandes', 'Module de gestion des commandes clients', 1, '#667eea'),
('Gestion Client', 'Module de gestion des profils clients', 2, '#764ba2'),
('Facturation', 'Module de facturation et paiement', 3, '#f093fb'),
('Reporting', 'Tableaux de bord et analytics', 4, '#4facfe');

-- Epics
INSERT INTO epic (id_zone, id_release, nom_epic, description, items_completes, items_total, statut, priorite, date_debut) VALUES
(1, 3, 'Créer commande', 'Permettre la création de nouvelles commandes', 8, 12, 'En_cours', 'Haute', '2025-05-01'),
(1, 2, 'Valider commande', 'Workflow de validation des commandes', 5, 5, 'Termine', 'Moyenne', '2025-02-15'),
(1, 3, 'Annuler commande', 'Gestion des annulations', 2, 8, 'A_risque', 'Haute', '2025-05-15'),
(2, 1, 'Créer profil client', 'Inscription et création de profil', 10, 10, 'Termine', 'Haute', '2024-12-01'),
(2, 3, 'Modifier profil', 'Édition des informations client', 3, 6, 'En_cours', 'Moyenne', '2025-05-10'),
(2, 4, 'Supprimer compte', 'RGPD - Suppression de compte', 0, 4, 'Non_demarre', 'Basse', NULL),
(3, 4, 'Générer facture', 'Création automatique de factures', 0, 7, 'Non_demarre', 'Haute', NULL),
(3, 4, 'Envoyer facture', 'Envoi automatique par email', 0, 5, 'Non_demarre', 'Moyenne', NULL),
(4, 3, 'Dashboard analytics', 'Tableaux de bord temps réel', 4, 10, 'En_cours', 'Haute', '2025-06-01');

-- Items (exemples pour quelques epics)
INSERT INTO item (id_epic, titre, statut, id_assignee) VALUES
(1, 'Interface de création', 'Termine', 3),
(1, 'Validation des données', 'Termine', 3),
(1, 'Intégration API paiement', 'En_cours', 3),
(1, 'Tests unitaires', 'A_faire', NULL),
(2, 'Workflow validation manager', 'Termine', 2),
(2, 'Notifications email', 'Termine', 3),
(5, 'Form édition profil', 'Termine', 3),
(5, 'Upload photo profil', 'En_cours', 3),
(5, 'Historique modifications', 'A_faire', NULL);

-- Commentaires
INSERT INTO commentaire (id_epic, id_utilisateur, contenu, important) VALUES
(3, 2, 'Epic bloqué par manque de ressources backend', TRUE),
(1, 3, 'Intégration Stripe en cours, livraison prévue fin de semaine', FALSE),
(9, 2, 'Phase de design terminée, validation client OK', FALSE);

-- =====================================================
-- REQUÊTES UTILES POUR L'APPLICATION
-- =====================================================

-- Récupérer toutes les données pour le parking lot diagram
-- SELECT * FROM v_epics_detail ORDER BY nom_zone, nom_epic;

-- Statistiques globales
-- SELECT * FROM v_dashboard_global;

-- Statistiques par zone
-- SELECT * FROM v_stats_par_zone ORDER BY nom_zone;

-- Epics à risque nécessitant une attention
-- SELECT * FROM v_epics_detail WHERE statut = 'A_risque' ORDER BY priorite DESC;

-- Historique des modifications d'un epic
-- SELECT h.*, u.nom, u.prenom 
-- FROM historique_epic h
-- LEFT JOIN utilisateur u ON h.id_utilisateur = u.id_utilisateur
-- WHERE h.id_epic = 1
-- ORDER BY h.date_modification DESC;