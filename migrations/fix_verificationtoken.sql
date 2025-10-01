-- 🔄 Correction de la table VerificationToken
ALTER TABLE "VerificationToken" DROP COLUMN IF EXISTS email;

-- ✅ S’assurer que identifier existe et est NOT NULL
ALTER TABLE "VerificationToken"
  ALTER COLUMN identifier SET NOT NULL;

-- Vérification rapide
\d "VerificationToken";
