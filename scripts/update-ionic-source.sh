#!/bin/bash

# Skrypt do aktualizacji submodułu ionic-source (pliki Vue/TypeScript)
# Użycie: ./scripts/update-ionic-source.sh

set -e

echo "🔄 Aktualizowanie submodułu ionic-source (pliki Vue/TypeScript)..."

# Sprawdź czy jesteśmy w repo android
if [ ! -d "ionic-source" ]; then
    echo "❌ Błąd: Folder ionic-source nie istnieje"
    echo "💡 Uruchom: git submodule update --init --recursive"
    exit 1
fi

# Przejdź do folderu ionic-source
cd ionic-source

# Sprawdź czy jesteśmy w submodule
if [ ! -d ".git" ]; then
    echo "❌ Błąd: Folder ionic-source nie jest submodułem Git"
    exit 1
fi

# Pobierz najnowsze zmiany
echo "📥 Pobieranie najnowszych zmian z repo ionic..."
git fetch origin

# Przełącz na main i zaktualizuj
echo "🔄 Przełączanie na branch main..."
git checkout main
git pull origin main

# Pokaż ostatnie commity
echo ""
echo "📋 Ostatnie 5 commitów w repo ionic:"
git log --oneline -5

# Wróć do głównego katalogu
cd ..

# Sprawdź status submodułu
echo ""
echo "📊 Status submodułu w repo android:"
git status ionic-source

echo ""
echo "✅ Submodule ionic-source zaktualizowany!"
echo ""
echo "💡 Aby zaktualizować referencję w repo android, uruchom:"
echo "   git add ionic-source"
echo "   git commit -m 'Update ionic-source submodule: [opis zmian]'"
echo "   git push"

