# Generates issues.md using the exact logic of the working one-liner
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
& chcp 65001 | Out-Null

Write-Host "Loading Issues from GitHub..." -ForegroundColor Cyan

# 1. Fetch Data
$data = gh issue list --json number,title,body,labels,milestone --limit 100 | ConvertFrom-Json
if (-not $data) { Write-Warning "No data from GitHub."; exit }

# 2. Sort Data (Release then Priority)
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

# 3. Define Symbols (Safe-Codes)
$i_roadmap = [char]::ConvertFromUtf32(0x1F4CB) # 📋
$i_fire    = [char]::ConvertFromUtf32(0x1F525) # 🔥
$i_bolt    = [char]::ConvertFromUtf32(0x26A1)   # ⚡
$i_coffee  = [char]::ConvertFromUtf32(0x2615)   # ☕
$i_sparkle = [char]::ConvertFromUtf32(0x2728)   # ✨
$i_check   = [char]::ConvertFromUtf32(0x1F3C1) # 🏁
$i_red     = [char]::ConvertFromUtf32(0x1F534) # 🔴

# Mangled sequence definitions (Safe-Codes for ├╝, ├ñ, etc.)
$m_ue = [char]0x251C + [char]0x255D # ├╝
$m_ae = [char]0x251C + [char]0x00F1 # ├ñ
$m_oe = [char]0x251C + [char]0x00C2 # ├Â
$m_ss = [char]0x251C + [char]0x0192 # ├ƒ

$lines = @()
$lines += "# $i_roadmap GitHub Issues Roadmap"
$lines += "_Last updated: $((Get-Date).ToString('dd.MM.yyyy HH:mm'))_"
$lines += "_Sorted by Release and Priority (High > Medium > Low)_"
$lines += ""

foreach ($i in $sorted) {
    # Icons
    $p = if ($i.labels.name -match 'prio: 1') { "$i_fire " }
         elseif ($i.labels.name -match 'prio: 2') { "$i_bolt " }
         elseif ($i.labels.name -match 'prio: 3') { "$i_coffee " }
         else { '' }

    $t_icon = if ($i.labels.name -match 'bug|critical') { "$i_red " }
              elseif ($i.labels.name -match 'enhancement|feature') { "$i_sparkle " }
              else { '' }

    $lbl = if ($i.labels.Count -gt 0) { ' [' + ($i.labels.name -join ', ') + ']' } else { '' }
    $m = if ($i.milestone) { " $i_check [" + $i.milestone.title + "]" } else { '' }

    # Content with exact -replace logic from your one-liner
    $title = $i.title
    $body = if ($i.body) { $i.body } else { '_Keine Beschreibung_' }

    # Applying the replacement logic
    $title = $title -replace $m_ue, 'ü' -replace $m_ae, 'ä' -replace $m_oe, 'ö' -replace $m_ss, 'ß'
    $body = $body -replace $m_ue, 'ü' -replace $m_ae, 'ä' -replace $m_oe, 'ö' -replace $m_ss, 'ß'

    $lines += "## $p$t_icon#$($i.number): $title$lbl$m"
    $lines += '---'
    $lines += '**Status / Description:**'
    $lines += ''
    $lines += $body
    $lines += ''
    $lines += '---'
    $lines += ''
}

# 4. Target Path
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$projectRoot = Split-Path -Parent $scriptDir
$targetPath = Join-Path $projectRoot "docs\engineering\issues.md"

# 5. Save with UTF8 (BOM)
[System.IO.File]::WriteAllLines($targetPath, $lines, [System.Text.Encoding]::UTF8)

Write-Host "Success: docs/engineering/issues.md updated using One-Liner logic." -ForegroundColor Green
