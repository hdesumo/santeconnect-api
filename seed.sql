-- ======================================
-- SEED INITIAL POUR SANTECONNECT
-- ======================================

-- 🔄 Nettoyer les tables (ordre important à cause des FK)
TRUNCATE TABLE "_ArticleToCategory" CASCADE;
TRUNCATE TABLE "Transaction" CASCADE;
TRUNCATE TABLE "Candidature" CASCADE;
TRUNCATE TABLE "Offre" CASCADE;
TRUNCATE TABLE "EtablissementAnnuaire" CASCADE;
TRUNCATE TABLE "Article" CASCADE;
TRUNCATE TABLE "ArticleCategory" CASCADE;
TRUNCATE TABLE "Soignant" CASCADE;
TRUNCATE TABLE "Etablissement" CASCADE;
TRUNCATE TABLE "User" CASCADE;

-- ======================================
-- 👤 UTILISATEUR (Auteur blog)
-- ======================================
INSERT INTO "User" (full_name, email, password_hash, phone, role, createdat, updatedat, emailverified)
VALUES (
  'Admin Test',
  'admin@test.com',
  '$2a$10$ka.mO3MzGResdBxMj5aCNuxyI.p8khaaVn3pHIfjGZp9Jn3fCiDam', -- hash de "secret123"
  '0600000000',
  'ADMIN',
  NOW(),
  NOW(),
  TRUE
);

-- ======================================
-- 🧑‍⚕️ SOIGNANT
-- ======================================
INSERT INTO "Soignant" (email, prenom, nom, telephone, specialite, createdat, updatedat, emailverified, password_hash)
VALUES (
  'soignant@test.com',
  'Jean',
  'Dupont',
  '0612345678',
  'Infirmier',
  NOW(),
  NOW(),
  TRUE,
  '$2a$10$ka.mO3MzGResdBxMj5aCNuxyI.p8khaaVn3pHIfjGZp9Jn3fCiDam'
);

-- ======================================
-- 🏥 ETABLISSEMENT
-- ======================================
INSERT INTO "Etablissement" (email, nom, type, adresse, telephone, createdat, updatedat, emailverified, password_hash)
VALUES (
  'etab@test.com',
  'Clinique Demo',
  'CLINIQUE',
  '12 rue de la Santé, Rennes',
  '0299123456',
  NOW(),
  NOW(),
  TRUE,
  '$2a$10$ka.mO3MzGResdBxMj5aCNuxyI.p8khaaVn3pHIfjGZp9Jn3fCiDam'
);

-- ======================================
-- 📌 OFFRES
-- ======================================
INSERT INTO "Offre" (titre, description, localisation, datedebut, datefin, remuneration, statut, etablissementid, createdat, updatedat)
VALUES
(
  'Remplacement infirmier',
  'Mission d’une semaine en service de gériatrie',
  'Rennes - CHU',
  NOW(),
  NOW() + interval '7 days',
  '2500€',
  'active',
  1,
  NOW(),
  NOW()
),
(
  'Aide-soignant de nuit',
  'Mission de 3 nuits en EHPAD',
  'Nantes - EHPAD Les Jardins',
  NOW(),
  NOW() + interval '3 days',
  '800€',
  'active',
  1,
  NOW(),
  NOW()
);

-- ======================================
-- 📑 CANDIDATURES
-- ======================================
INSERT INTO "Candidature" (soignantid, offreid, statut, createdat, updatedat)
VALUES
  (1, 1, 'en_attente', NOW(), NOW()),
  (1, 2, 'confirmee', NOW(), NOW());

-- ======================================
-- 📰 CATEGORIES ARTICLES
-- ======================================
INSERT INTO "ArticleCategory" (name)
VALUES
  ('Actualités'),
  ('Conseils Santé');

-- ======================================
-- 📰 ARTICLES
-- ======================================
INSERT INTO "Article" (title, slug, content, author_id, createdat, updatedat)
VALUES
(
  'Bienvenue sur SanteConnect',
  'bienvenue-santeconnect',
  'Ceci est le premier article du blog de SanteConnect.',
  1,
  NOW(),
  NOW()
);

-- Lier l’article à une catégorie
INSERT INTO "_ArticleToCategory" ("A", "B") VALUES (1, 1);

-- ======================================
-- 📖 ETABLISSEMENT ANNUAIRE
-- ======================================
INSERT INTO "EtablissementAnnuaire" (nom, adresse, telephone, departement, type, createdat, updatedat)
VALUES
('CHU de Rennes', '2 Rue Henri Le Guilloux, Rennes', '0299284343', '35', 'CHU', NOW(), NOW()),
('Clinique Saint-Grégoire', '6 Bd de la Boutière, Saint-Grégoire', '0299235555', '35', 'CLINIQUE', NOW(), NOW()),
('EHPAD Les Jardins', '15 Rue de Nantes, Nantes', '0240474747', '44', 'EHPAD', NOW(), NOW());

-- ======================================
-- 💳 TRANSACTIONS
-- ======================================
INSERT INTO "Transaction" (soignant_id, montant, type, statut, createdat, updatedat)
VALUES
(1, 2500, 'paiement', 'validée', NOW(), NOW()),
(1, 800, 'paiement', 'en_attente', NOW(), NOW());

-- ======================================
-- ✅ VÉRIFICATION RAPIDE
-- ======================================
SELECT * FROM "User";
SELECT * FROM "Soignant";
SELECT * FROM "Etablissement";
SELECT * FROM "Offre";
SELECT * FROM "Candidature";
SELECT * FROM "Article";
SELECT * FROM "ArticleCategory";
SELECT * FROM "EtablissementAnnuaire";
SELECT * FROM "Transaction";
