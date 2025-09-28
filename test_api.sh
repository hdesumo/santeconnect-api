#!/bin/bash

# API publique sur Railway
BASE_URL="https://santeconnect-api-production.up.railway.app/api"

echo "===================================="
echo "🔑 Login Admin"
echo "===================================="
ADMIN_TOKEN=$(curl -s -X POST $BASE_URL/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email": "admin@santeconnect.live", "password": "admin123"}' | jq -r '.token')

echo "Admin token: $ADMIN_TOKEN"
echo

echo "===================================="
echo "👩‍⚕️ Lister les soignants"
echo "===================================="
curl -s -X GET $BASE_URL/soignants \
  -H "Authorization: Bearer $ADMIN_TOKEN" | jq
echo

echo "===================================="
echo "🏥 Lister les établissements"
echo "===================================="
curl -s -X GET $BASE_URL/etablissements \
  -H "Authorization: Bearer $ADMIN_TOKEN" | jq
echo

echo "===================================="
echo "📋 Lister les missions"
echo "===================================="
curl -s -X GET $BASE_URL/missions \
  -H "Authorization: Bearer $ADMIN_TOKEN" | jq
echo

echo "===================================="
echo "🔑 Login Soignant"
echo "===================================="
SOIGNANT_TOKEN=$(curl -s -X POST $BASE_URL/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email": "soignant1@santeconnect.live", "password": "soignant123"}' | jq -r '.token')

echo "Soignant token: $SOIGNANT_TOKEN"
echo

echo "===================================="
echo "✍️ Postuler à une mission (id=1)"
echo "===================================="
curl -s -X POST $BASE_URL/missions/1/apply \
  -H "Authorization: Bearer $SOIGNANT_TOKEN" | jq
echo

echo "===================================="
echo "📌 Voir les candidatures (Admin)"
echo "===================================="
curl -s -X GET $BASE_URL/applications \
  -H "Authorization: Bearer $ADMIN_TOKEN" | jq
echo

echo "===================================="
echo "📌 Voir les candidatures (Soignant)"
echo "===================================="
curl -s -X GET $BASE_URL/applications \
  -H "Authorization: Bearer $SOIGNANT_TOKEN" | jq
echo
