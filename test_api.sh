#!/bin/bash

# ==============================
# Script de test SantéConnect API
# ==============================

# URLs
API_URL_LOCAL="http://localhost:8080"
API_URL_PROD="https://api.santeconnect.live"

# Par défaut : prod
API_URL=$API_URL_PROD

echo "🌍 Test API SantéConnect sur $API_URL"

# ----------- HEALTH CHECK -----------
echo -e "\n🩺 Vérification de l'API..."
curl -s $API_URL/health
echo ""
curl -s $API_URL/health/db
echo ""

# ----------- REGISTER -----------
echo -e "\n👤 Création utilisateur (register)..."
REGISTER_RESPONSE=$(curl -s -X POST $API_URL/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"testuser@example.com","password":"secret123","fullName":"Test User"}')

echo $REGISTER_RESPONSE

# ----------- LOGIN -----------
echo -e "\n🔑 Connexion utilisateur (login)..."
LOGIN_RESPONSE=$(curl -s -X POST $API_URL/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"testuser@example.com","password":"secret123"}')

echo $LOGIN_RESPONSE

# Extraire rapidement le token par grep
TOKEN=$(echo $LOGIN_RESPONSE | grep -o '"token":"[^"]*' | cut -d'"' -f4)

if [ -z "$TOKEN" ]; then
  echo "❌ Impossible de récupérer le token"
else
  echo "✅ Token récupéré :"
  echo $TOKEN
fi

# ----------- SOIGNANTS -----------
if [ ! -z "$TOKEN" ]; then
  echo -e "\n👩‍⚕️ Liste des soignants..."
  curl -s -H "Authorization: Bearer $TOKEN" $API_URL/api/soignants
  echo ""
fi

# ----------- ETABLISSEMENTS -----------
if [ ! -z "$TOKEN" ]; then
  echo -e "\n🏥 Liste des établissements..."
  curl -s -H "Authorization: Bearer $TOKEN" $API_URL/api/etablissements
  echo ""
fi

# ----------- ARTICLES -----------
echo -e "\n📰 Liste des articles (public)..."
curl -s $API_URL/api/articles
echo ""

if [ ! -z "$TOKEN" ]; then
  echo -e "\n📰 Création d’un article (protégé)..."
  curl -s -X POST $API_URL/api/articles \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"title":"Article test","content":"Contenu de test","author_id":5}'
  echo ""
fi

# ----------- MISSIONS -----------
if [ ! -z "$TOKEN" ]; then
  echo -e "\n📌 Liste des missions..."
  curl -s -H "Authorization: Bearer $TOKEN" $API_URL/api/missions
  echo ""
fi

# ----------- CANDIDATURES -----------
if [ ! -z "$TOKEN" ]; then
  echo -e "\n📝 Liste des candidatures..."
  curl -s -H "Authorization: Bearer $TOKEN" $API_URL/api/applications
  echo ""

  echo -e "\n📝 Postuler à une mission (id=1)..."
  curl -s -X POST $API_URL/api/applications \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"mission_id":1}'
  echo ""
fi

# ----------- TRANSACTIONS -----------
if [ ! -z "$TOKEN" ]; then
  echo -e "\n💳 Liste des transactions..."
  curl -s -H "Authorization: Bearer $TOKEN" $API_URL/api/transactions
  echo ""

  echo -e "\n💳 Création d’une transaction..."
  curl -s -X POST $API_URL/api/transactions \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"amount":2500,"description":"Paiement test"}'
  echo ""
fi

echo -e "\n✅ Tests terminés."
