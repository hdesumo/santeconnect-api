-- Nettoyage
TRUNCATE TABLE "_ArticleToCategory" CASCADE;
TRUNCATE TABLE "Candidature" CASCADE;
TRUNCATE TABLE "Disponibilite" CASCADE;
TRUNCATE TABLE "Transaction" CASCADE;
TRUNCATE TABLE "Offre" CASCADE;
TRUNCATE TABLE "Article" CASCADE;
TRUNCATE TABLE "ArticleCategory" CASCADE;
TRUNCATE TABLE "EtablissementAnnuaire" CASCADE;
TRUNCATE TABLE "Soignant" CASCADE;
TRUNCATE TABLE "Etablissement" CASCADE;
TRUNCATE TABLE "User" CASCADE;
TRUNCATE TABLE "VerificationToken" CASCADE;

-- Utilisateur (admin)
INSERT INTO "User" (full_name, email, password_hash, phone, role, created_at, updated_at, email_verified)
VALUES ('Admin Test', 'admin@test.com', '$2a$10$ka.mO3MzGResdBxMj5aCNuxyI.p8khaaVn3pHIfjGZp9Jn3fCiDam',
        '0600000000', 'ADMIN', NOW(), NOW(), TRUE);

-- Soignant
INSERT INTO "Soignant" (email, prenom, nom, telephone, specialite, createdat, updatedat, emailverified, password_hash)
VALUES ('soignant@test.com', 'Jean', 'Dupont', '0612345678', 'Infirmier', NOW(), NOW(), TRUE,
        '$2a$10$ka.mO3MzGResdBxMj5aCNuxyI.p8khaaVn3pHIfjGZp9Jn3fCiDam');

-- Etablissement
INSERT INTO "Etablissement" (email, nom, type, adresse, telephone, createdat, updatedat, emailverified, password_hash)
VALUES ('etab@test.com', 'Clinique Demo', 'CLINIQUE', '12 rue de la Santé, Rennes', '0299123456',
        NOW(), NOW(), TRUE, '$2a$10$ka.mO3MzGResdBxMj5aCNuxyI.p8khaaVn3pHIfjGZp9Jn3fCiDam');

-- Offres (attention : etablissementid en snake_case)
INSERT INTO "Offre" (titre, description, localisation, date_debut, date_fin, remuneration, statut, etablissementid, createdat, updatedat)
VALUES 
('Remplacement infirmier', 'Mission d’une semaine en service de gériatrie', 'Rennes',
 NOW(), NOW() + interval '7 days', '2500', 'active', 1, NOW(), NOW()),
('Vacataire urgences', '2 gardes de nuit aux urgences', 'Nantes',
 NOW(), NOW() + interval '2 days', '800', 'active', 1, NOW(), NOW());

-- Candidatures (soignantid en snake_case)
INSERT INTO "Candidature" (soignantid, offreid, statut, createdat, updatedat)
VALUES 
(1, 1, 'en_attente', NOW(), NOW()),
(1, 2, 'validée', NOW(), NOW());

-- Disponibilités
INSERT INTO "Disponibilite" (soignantid, date, creneau, createdat, updatedat)
VALUES 
(1, NOW() + interval '1 day', 'matin', NOW(), NOW()),
(1, NOW() + interval '2 days', 'après-midi', NOW(), NOW()),
(1, NOW() + interval '3 days', 'nuit', NOW(), NOW());

-- Transactions
INSERT INTO "Transaction" (soignant_id, montant, type, statut, createdat, updatedat)
VALUES 
(1, 2500.00, 'paiement', 'validée', NOW(), NOW()),
(1, 200.00, 'remboursement', 'validée', NOW(), NOW());

-- Catégories d’articles
INSERT INTO "ArticleCategory" (name) VALUES ('Santé'), ('Conseils'), ('Annonces');

-- Articles
INSERT INTO "Article" (title, slug, content, author_id, createdat, updatedat)
VALUES 
('Bienvenue sur le blog', 'bienvenue-blog', 'Contenu de test…', 1, NOW(), NOW()),
('Préparer sa garde de nuit', 'garde-de-nuit', 'Quelques conseils utiles…', 1, NOW(), NOW());

-- Relations Article - Category
INSERT INTO "_ArticleToCategory" ("A", "B") VALUES (1, 1), (2, 2);

-- Etablissements annuaire
INSERT INTO "EtablissementAnnuaire" (nom, adresse, telephone, departement, type, createdat, updatedat)
VALUES 
('Hôpital Général', '1 rue de Paris, Lyon', '0411223344', '69', 'HOPITAL', NOW(), NOW());

-- Tokens
INSERT INTO "VerificationToken" (email, token, expires)
VALUES ('admin@test.com', 'randomtoken123', NOW() + interval '1 day');
