-- ============================================
-- MIGRATION INITIALE : Création du schéma complet
-- ============================================

-- ========================
-- Table User
-- ========================
CREATE TABLE "User" (
    id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    phone TEXT,
    role TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW() NOT NULL,
    email_verified BOOLEAN DEFAULT FALSE NOT NULL
);

-- ========================
-- Table Soignant
-- ========================
CREATE TABLE "Soignant" (
    id SERIAL PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    prenom TEXT NOT NULL,
    nom TEXT NOT NULL,
    telephone TEXT,
    adresse TEXT,
    date_naissance TIMESTAMP,
    photo_url TEXT,
    specialite TEXT,
    experience TEXT,
    competences TEXT,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW() NOT NULL,
    email_verified BOOLEAN DEFAULT FALSE NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

-- ========================
-- Table Etablissement
-- ========================
CREATE TABLE "Etablissement" (
    id SERIAL PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    nom TEXT NOT NULL,
    type TEXT,
    adresse TEXT,
    telephone TEXT,
    logo_url TEXT,
    contact_nom TEXT,
    contact_fonction TEXT,
    contact_tel TEXT,
    contact_email TEXT,
    siret TEXT,
    rib TEXT,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW() NOT NULL,
    email_verified BOOLEAN DEFAULT FALSE NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

-- ========================
-- Table Offre
-- ========================
CREATE TABLE "Offre" (
    id SERIAL PRIMARY KEY,
    titre TEXT NOT NULL,
    description TEXT NOT NULL,
    localisation TEXT NOT NULL,
    date_debut TIMESTAMP NOT NULL,
    date_fin TIMESTAMP NOT NULL,
    remuneration TEXT NOT NULL,
    statut TEXT DEFAULT 'active' NOT NULL,
    etablissement_id INT NOT NULL REFERENCES "Etablissement"(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW() NOT NULL
);

-- ========================
-- Table Candidature
-- ========================
CREATE TABLE "Candidature" (
    id SERIAL PRIMARY KEY,
    statut TEXT DEFAULT 'en_attente' NOT NULL,
    soignant_id INT NOT NULL REFERENCES "Soignant"(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    offre_id INT NOT NULL REFERENCES "Offre"(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW() NOT NULL
);

-- ========================
-- Table Disponibilite
-- ========================
CREATE TABLE "Disponibilite" (
    id SERIAL PRIMARY KEY,
    soignant_id INT NOT NULL REFERENCES "Soignant"(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    date TIMESTAMP NOT NULL,
    est_disponible BOOLEAN DEFAULT TRUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW() NOT NULL
);

-- ========================
-- Table Transaction
-- ========================
CREATE TABLE "Transaction" (
    id SERIAL PRIMARY KEY,
    soignant_id INT NOT NULL REFERENCES "Soignant"(id) ON DELETE CASCADE,
    montant DOUBLE PRECISION NOT NULL,
    type VARCHAR(255) NOT NULL,
    statut VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW() NOT NULL
);

-- ========================
-- Table ArticleCategory
-- ========================
CREATE TABLE "ArticleCategory" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

-- ========================
-- Table Article
-- ========================
CREATE TABLE "Article" (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    content TEXT NOT NULL,
    author_id INT NOT NULL REFERENCES "User"(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW() NOT NULL
);

-- ========================
-- Table relation Article <-> Category
-- ========================
CREATE TABLE "_ArticleToCategory" (
    "A" INT NOT NULL REFERENCES "Article"(id) ON DELETE CASCADE,
    "B" INT NOT NULL REFERENCES "ArticleCategory"(id) ON DELETE CASCADE,
    PRIMARY KEY ("A","B")
);

-- ========================
-- Table EtablissementAnnuaire
-- ========================
CREATE TABLE "EtablissementAnnuaire" (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    telephone VARCHAR(255) NOT NULL,
    departement VARCHAR(50) NOT NULL,
    type VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW() NOT NULL
);

-- ========================
-- Table VerificationToken
-- ========================
CREATE TABLE "VerificationToken" (
    id SERIAL PRIMARY KEY,
    identifier TEXT NOT NULL,
    token TEXT UNIQUE NOT NULL,
    expires TIMESTAMP NOT NULL
);

-- ============================================
-- FIN DU FICHIER 001_init.sql
-- ============================================
