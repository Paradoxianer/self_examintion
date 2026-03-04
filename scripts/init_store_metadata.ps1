# Initialisiert die Store-Metadaten Struktur für alle Sprachen
# Basierend auf dem Fastlane Standard

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

$basePath = "metadata/android"

Write-Host "Erstelle Metadaten-Struktur für Android..." -ForegroundColor Cyan

foreach ($lang in $languages.Keys) {
    $path = Join-Path $ProjectFileDir$ "$basePath/$lang"
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Force -Path $path

        # Standard-Dateien für Google Play
        New-Item "$path/title.txt" -Value "Self-Examination ($($languages[$lang]))"
        New-Item "$path/short_description.txt" -Value "Spiritual and personal growth tool."
        New-Item "$path/full_description.txt" -Value "Structured self-reflection based on the traditions of William Booth and John Wesley."
        New-Item "$path/whats_new.txt" -Value "Initial release with 8 languages and onboarding."

        Write-Host "  [+] $lang ($($languages[$lang])) angelegt." -ForegroundColor Green
    } else {
        Write-Host "  [.] $lang existiert bereits." -ForegroundColor Yellow
    }
}

Write-Host "`nFertig! Du kannst die Texte jetzt in den jeweiligen .txt Dateien anpassen." -ForegroundColor Cyan
Write-Host "Nutze 'fastlane supply' (Android) oder 'fastlane deliver' (iOS) zum Hochladen."
