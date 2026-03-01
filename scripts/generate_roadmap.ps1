# Generiert die issues.md basierend auf GitHub Issues
# Sortiert nach Release (Milestone) und Priorität

# UTF-8 Support sicherstellen
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "Lade Issues von GitHub..." -ForegroundColor Cyan

# Abrufen der Daten über die GitHub CLI
$data = gh issue list --json number,title,body,labels,milestone --limit 100 | ConvertFrom-Json

if (-not $data) {
    Write-Error "Keine Daten von GitHub empfangen. Bist du eingeloggt (gh auth status)?"
    exit
}

# Sortier-Logik: Erst Release (1, 2, 3), dann Priorität (1, 2, 3)
$sorted = $data | Sort-Object {
    if ($_.milestone.title -match 'Release 1') { 1 }
    elseif ($_.milestone.title -match 'Release 2') { 2 }
    elseif ($_.milestone.title -match 'Release 3') { 3 }
    else { 9 }
}, {
    if ($_.labels.name -match 'prio: 1') { 1 }
    elseif ($_.labels.name -match 'prio: 2') { 2 }
    elseif ($_.labels.name -match 'prio: 3') { 3 }
    else { 4 }
}

$lines = @(
    '# 📋 GitHub Issues Roadmap',
    "_Zuletzt aktualisiert am: $(Get-Date -Format 'dd.MM.yyyy HH:mm')",
    '_Sortiert nach Release und Priorität (High > Medium > Low)_',
    ''
)

foreach ($i in $sorted) {
    # Icons für Priorität
    $p = if ($i.labels.name -match 'prio: 1') { '🔥 ' }
         elseif ($i.labels.name -match 'prio: 2') { '⚡ ' }
         elseif ($i.labels.name -match 'prio: 3') { '☕ ' }
         else { '' }

    # Icons für Typ
    $t = if ($i.labels.name -match 'bug|critical') { '🔴 ' }
         elseif ($i.labels.name -match 'enhancement|feature') { '✨ ' }
         else { '' }

    $lbl = if ($i.labels.Count -gt 0) { ' [' + ($i.labels.name -join ', ') + ']' } else { '' }
    $m = if ($i.milestone) { ' 🏁 [' + $i.milestone.title + ']' } else { '' }

    $lines += "## $p$t#$($i.number): $($i.title)$lbl$m"
    $lines += '---'
    $lines += '**Status / Description:**'

    $body = if ($i.body) { $i.body } else { '_Keine Beschreibung_' }
    # Encoding-Fix für Umlaute aus der CLI
    $body = $body -replace '├╝', 'ü' -replace '├ñ', 'ä' -replace '├Â', 'ö' -replace '├ƒ', 'ß'

    $lines += $body
    $lines += ''
    $lines += '---'
    $lines += ''
}

# Datei schreiben im Projektverzeichnis
$targetPath = Join-Path $PSScriptRoot ".." | Join-Path -ChildPath "issues.md"
[System.IO.File]::WriteAllLines($targetPath, $lines, [System.Text.Encoding]::UTF8)

Write-Host "Erfolgreich: issues.md wurde aktualisiert." -ForegroundColor Green
