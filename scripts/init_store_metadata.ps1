# Cross-Platform Metadata Initializer (Android & iOS)
# Erstellt und synchronisiert die Store-Metadaten Struktur

$languages = @{
    "en-US" = "English";
    "de-DE" = "German";
    "es-ES" = "Spanish";
    "pl-PL" = "Polish";
    "lt-LT" = "Lithuanian";
    "ko-KR" = "Korean";
    "ru-RU" = "Russian";
    "uk-UA" = "Ukrainian"
}

# Pfade definieren
$androidBase = "android/fastlane/metadata/android"
$iosBase = "ios/fastlane/metadata"

Write-Host "--- Metadata Architect ---" -ForegroundColor Cyan

foreach ($lang in $languages.Keys) {
    # 1. Android Pfad prüfen/erstellen
    $aPath = "$androidBase/$lang"
    if (-not (Test-Path $aPath)) {
        New-Item -ItemType Directory -Force -Path $aPath
        Write-Host "  [+] Android: $lang angelegt." -ForegroundColor Green
    }

    # 2. iOS Pfad prüfen/erstellen (Fastlane Deliver Standard)
    $iPath = "$iosBase/$lang"
    if (-not (Test-Path $iPath)) {
        New-Item -ItemType Directory -Force -Path $iPath
        Write-Host "  [+] iOS: $lang angelegt." -ForegroundColor Green
    }

    # 3. Basis-Dateien (wenn noch nicht vorhanden)
    $files = @("title.txt", "short_description.txt", "full_description.txt")
    foreach ($file in $files) {
        $aFile = "$aPath/$file"
        $iFile = "$iPath/$file"

        # Wenn Android die Datei hat, aber iOS nicht -> Kopieren (Synchronisation)
        if ((Test-Path $aFile) -and (-not (Test-Path $iFile))) {
            Copy-Item $aFile $iFile
            Write-Host "    [Synced] $file -> iOS" -ForegroundColor Gray
        }
    }
}

Write-Host "`nFertig! Android und iOS Metadaten sind jetzt synchronisiert." -ForegroundColor Cyan
