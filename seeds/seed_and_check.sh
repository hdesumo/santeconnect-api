#!/bin/bash

# 🚀 Exécution du seed et vérification des données
psql "postgresql://postgres:THjAojtBIxmDArsHonsBQRouiHfPDCbr@metro.proxy.rlwy.net:34076/railway" -f seeds/demo_data_fixed.sql

echo " "
echo "==================== Vérification des données ===================="

# Vérifier chaque table
psql "postgresql://postgres:THjAojtBIxmDArsHonsBQRouiHfPDCbr@metro.proxy.rlwy.net:34076/railway" -c 'TABLE "User";'
psql "postgresql://postgres:THjAojtBIxmDArsHonsBQRouiHfPDCbr@metro.proxy.rlwy.net:34076/railway" -c 'TABLE "Soignant";'
psql "postgresql://postgres:THjAojtBIxmDArsHonsBQRouiHfPDCbr@metro.proxy.rlwy.net:34076/railway" -c 'TABLE "Etablissement";'
psql "postgresql://postgres:THjAojtBIxmDArsHonsBQRouiHfPDCbr@metro.proxy.rlwy.net:34076/railway" -c 'TABLE "Offre";'
psql "postgresql://postgres:THjAojtBIxmDArsHonsBQRouiHfPDCbr@metro.proxy.rlwy.net:34076/railway" -c 'TABLE "Candidature";'
psql "postgresql://postgres:THjAojtBIxmDArsHonsBQRouiHfPDCbr@metro.proxy.rlwy.net:34076/railway" -c 'TABLE "Disponibilite";'
psql "postgresql://postgres:THjAojtBIxmDArsHonsBQRouiHfPDCbr@metro.proxy.rlwy.net:34076/railway" -c 'TABLE "Transaction";'
psql "postgresql://postgres:THjAojtBIxmDArsHonsBQRouiHfPDCbr@metro.proxy.rlwy.net:34076/railway" -c 'TABLE "ArticleCategory";'
psql "postgresql://postgres:THjAojtBIxmDArsHonsBQRouiHfPDCbr@metro.proxy.rlwy.net:34076/railway" -c 'TABLE "Article";'
psql "postgresql://postgres:THjAojtBIxmDArsHonsBQRouiHfPDCbr@metro.proxy.rlwy.net:34076/railway" -c 'TABLE "_ArticleToCategory";'
psql "postgresql://postgres:THjAojtBIxmDArsHonsBQRouiHfPDCbr@metro.proxy.rlwy.net:34076/railway" -c 'TABLE "EtablissementAnnuaire";'
psql "postgresql://postgres:THjAojtBIxmDArsHonsBQRouiHfPDCbr@metro.proxy.rlwy.net:34076/railway" -c 'TABLE "VerificationToken";'

echo "================================================================="
echo " ✅ Seed terminé et données affichées."
