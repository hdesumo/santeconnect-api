-- ========================================
-- RESET : Vidage des tables dans le bon ordre
-- ========================================
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

-- ========================================
-- USER (Admin auteur blog)
-- ========================================
INSERT INTO "User" (
  full_name, email, password_hash, phone, role, created_at, updated_at, email_verified
) VALUES (
  'Admin Test',
  'admin@test.com',
  '$2a$10$ka.mO3MzGResdBxMj5aCNuxyI.p8khaaVn3pHIfjGZp9Jn3fCiDam', -- bcrypt: secret123
  '0600000000',
  'ADMIN',
  NOW(), NOW(),
  TRUE
);

-- ========================================
-- SOIGNANT
-- ========================================
INSERT INTO "Soignant" (
  email, prenom, nom, telephone, specialite,
  created_at, updated_at, email_verified, password_hash
) VALUES (
  'soignant@test.com',
  'Jean',
  'Dupont',
  '0612345678',
  'Infirmier',
  NOW(), NOW(),
  TRUE,
  '$2a$10$ka.mO3MzGResdBxMj5aCNuxyI.p8khaaVn3pHIfjGZp9Jn3fCiDam'
);

-- ========================================
-- ETABLISSEMENT
-- ========================================
INSERT INTO "Etablissement" (
  email, nom, type, adresse, telephone,
  created_at, updated_at, email_verified, password_hash
) VALUES (
  'etab@test.com',
  'Clinique Demo',
  'CLINIQUE',
  '12 rue de la Santé, Rennes',
  '0299123456',
  NOW(), NOW(),
  TRUE,
  '$2a$10$ka.mO3MzGResdBxMj5aCNuxyI.p8khaaVn3pHIfjGZp9Jn3fCiDam'
);

-- ========================================
-- OFFRE
-- ========================================
INSERT INTO "Offre" (
  titre, description, localisation, date_debut, date_fin,
  remuneration, statut, etablissement_id, created_at, updated_at
) VALUES (
  'Remplacement infirmier',
  'Mission d’une semaine en service de gériatrie',
  'Rennes',
  NOW(),
  NOW() + INTERVAL '7 days',
  '2500',
  'active',
  1, -- Clinique Demo
  NOW(), NOW()
);

-- ========================================
-- CANDIDATURE
-- ========================================
INSERT INTO "Candidature" (
  soignant_id, offre_id, statut, created_at, updated_at
) VALUES (
  1, 1, 'en_attente', NOW(), NOW()
);

-- ========================================
-- DISPONIBILITE
-- ========================================
INSERT INTO "Disponibilite" (
  soignant_id, date_debut, date_fin, created_at, updated_at
) VALUES (
  1,
  NOW() + INTERVAL '10 days',
  NOW() + INTERVAL '15 days',
  NOW(), NOW()
);

-- ========================================
-- TRANSACTION
-- ========================================
INSERT INTO "Transaction" (
  soignant_id, montant, type, statut, created_at, updated_at
) VALUES (
  1, 150.75, 'Paiement', 'Terminé', NOW(), NOW()
);

-- ========================================
-- ARTICLE CATEGORY
-- ========================================
INSERT INTO "ArticleCategory" (name)
VALUES ('Santé');

-- ========================================
-- ARTICLE
-- ========================================
INSERT INTO "Article" (
  title, slug, content, author_id, created_at, updated_at
) VALUES (
  'Les bienfaits de la prévention',
  'prevention-sante',
  'La prévention joue un rôle clé dans la santé publique...',
  1, NOW(), NOW()
);

-- ========================================
-- _ArticleToCategory (liaison article ↔ catégorie)
-- ========================================
INSERT INTO "_ArticleToCategory" ("A", "B")
VALUES (1, 1);

-- ========================================
-- ETABLISSEMENT ANNUAIRE
-- ========================================
INSERT INTO "EtablissementAnnuaire" (
  nom, adresse, telephone, departement, type, created_at, updated_at
) VALUES (
  'Hôpital Général',
  '45 rue Nationale, Lyon',
  '0472001122',
  'Rhône',
  'HOPITAL',
  NOW(), NOW()
);

-- ========================================
-- VERIFICATION TOKEN
-- ========================================
INSERT INTO "VerificationToken" (
  identifier, token, expires
) VALUES (
  'admin@test.com',
  'verification-token-123456',
  NOW() + INTERVAL '1 day'
);

-- ========================================
-- STATUS
-- ========================================
SELECT '✅ Jeu de données complet inséré avec succès.' AS status;
