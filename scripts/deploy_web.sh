#!/bin/bash

# Deployment Script für die Self-Examination Web Version (PWA)
# Erstellt von deinem Principal Flutter Architect

echo "🚀 Starte Web-Deployment Prozess..."

# 1. Bereinigen alter Builds
echo "🧹 Bereinige alte Build-Dateien..."
flutter clean

# 2. Dependencies laden
echo "📦 Lade Packages..."
flutter pub get

# 3. Flutter Web Build ausführen
# --base-href legt fest, unter welchem Pfad die App läuft.
# Für GitHub Pages meist /projektname/
echo "🏗️ Erstelle optimierten Web-Build (PWA)..."
flutter build web --release --base-href "/self_examintion/" --web-renderer canvaskit

echo "✅ Build abgeschlossen!"
echo "------------------------------------------------------"
echo "Die fertigen Dateien liegen im Ordner: build/web"
echo "Du kannst diesen Ordner nun auf deinen Webserver oder zu GitHub Pages hochladen."
echo "------------------------------------------------------"
