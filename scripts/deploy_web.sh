#!/bin/bash

# Deployment Script für die Self-Examination Web Version (PWA)
# Optimiert für moderne Flutter Versionen (3.27+)

echo "🚀 Starte Web-Deployment Prozess..."

# 1. Bereinigen alter Builds
echo "🧹 Bereinige alte Build-Dateien..."
flutter clean

# 2. Dependencies laden
echo "📦 Lade Packages..."
flutter pub get

# 3. Flutter Web Build ausführen
# Wir lassen --web-renderer weg, da Flutter (3.27+) dies automatisch optimiert.
echo "🏗️ Erstelle optimierten Web-Build (PWA)..."
flutter build web --release --base-href "/self_examintion/"

echo "✅ Build abgeschlossen!"
echo "------------------------------------------------------"
echo "Die fertigen Dateien liegen im Ordner: build/web"
echo "------------------------------------------------------"
