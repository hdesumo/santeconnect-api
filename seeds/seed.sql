-- ============================================
-- SEED INITIAL : Données de base pour tests
-- ============================================

-- ⚠️ On vide toutes les tables avant d’insérer
TRUNCATE TABLE "_ArticleToCategory" CASCADE;
TRUNCATE TABLE "Article" CASCADE;
TRUNCATE TABLE "ArticleCategory" CASCADE;
TRUNCATE TABLE "Transaction" CASCADE;
TRUNCATE TABLE "Disponibilite" CASCADE;
TRUNCATE TABLE "Candidature" CASCADE;
TRUNCATE TABLE "Offre" CASCADE;
TRUNCATE TABLE "EtablissementAnnuaire" CASCADE;
TRUNCATE TABLE "Etablissement" CASCADE;
TRUNCATE TABLE "Soignant" CASCADE;
TRUNCATE TABLE "User" CASCADE;
TRUNCATE TABLE "VerificationToken" CASCADE;

-- ========================
-- User (Admin pour blog)
-- ========================
INSERT INTO "User" (full_name, email, password_hash, phone, role, created_at, updated_at, email_verified)
VALUES (
  'Admin Test',
  'admin@test.com',
  '$2a$10$ka.mO3MzGResdBxMj5aCNuxyI.p8khaaVn3pHIfjGZp9Jn3fCiDam', -- bcrypt("secret123")
  '0600000000',
  'ADMIN',
  NOW(),
  NOW(),
  TRUE
);

-- ========================
-- Soignant
-- ========================
INSERT INTO "Soignant" (email, prenom, nom, telephone, specialite, created_at, updated_at, email_verified, password_hash)
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

-- ========================
-- Etablissement
-- ========================
INSERT INTO "Etablissement" (email, nom, type, adresse, telephone, created_at, updated_at, email_verified, password_hash)
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

-- ========================
-- Offre (liée à l’établissement)
-- ========================
INSERT INTO "Offre" (titre, description, localisation, date_debut, date_fin, remuneration, statut, etablissement_id, created_at, updated_at)
VALUES (
  'Remplacement infirmier',
  'Mission d’une semaine en service de gériatrie',
  'Rennes',
  NOW(),
  NOW() + INTERVAL '7 days',
  '2500€',
  'active',
  1,
  NOW(),
  NOW()
);

-- ========================
-- Candidature (soignant postule à l’offre)
-- ========================
INSERT INTO "Candidature" (soignant_id, offre_id, statut, created_at, updated_at)
VALUES (
  1,
  1,
  'en_attente',
  NOW(),
  NOW()
);

-- ========================
-- Disponibilité du soignant
-- ========================
INSERT INTO "Disponibilite" (soignant_id, date, est_disponible, created_at, updated_at)
VALUES (
  1,
  NOW() + INTERVAL '1 day',
  TRUE,
  NOW(),
  NOW()
);

-- ========================
-- Transaction associée au soignant
-- ========================
INSERT INTO "Transaction" (soignant_id, montant, type, statut, created_at, updated_at)
VALUES (
  1,
  2500,
  'paiement',
  'validée',
  NOW(),
  NOW()
);

-- ========================
-- Catégories d’articles
-- ========================
INSERT INTO "ArticleCategory" (name)
VALUES
  ('Actualités'),
  ('Conseils santé');

-- ========================
-- Article de blog (par User id=1)
-- ========================
INSERT INTO "Article" (title, slug, content, author_id, created_at, updated_at)
VALUES (
  'Bienvenue sur le blog SantéConnect',
  'bienvenue-blog',
  'Ceci est le premier article du blog.',
  1,
  NOW(),
  NOW()
);

-- Associer l’article à la catégorie "Actualités"
INSERT INTO "_ArticleToCategory" ("A","B") VALUES (1,1);

-- ========================
-- EtablissementAnnuaire
-- ========================
INSERT INTO "EtablissementAnnuaire" (nom, adresse, telephone, departement, type, created_at, updated_at)
VALUES (
  'CHU Rennes',
  '2 rue Henri Le Guilloux, Rennes',
  '0299000000',
  '35',
  'CHU',
  NOW(),
  NOW()
);

-- ========================
-- VerificationToken
-- ========================
INSERT INTO "VerificationToken" (identifier, token, expires)
VALUES (
  'admin@test.com',
  'dummy-token-123',
  NOW() + INTERVAL '1 day'
);

-- ============================================
-- FIN DU SEED
-- ============================================

SELECT '✅ Données de base insérées avec succès.' AS status;
