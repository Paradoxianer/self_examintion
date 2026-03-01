#!/bin/bash

# Generiert die issues.md unter macOS/Linux
# Sortiert nach Release (Milestone) und Priorität

echo "Lade Issues von GitHub..."

# Prüfen ob gh installiert ist
if ! command -v gh &> /dev/null; then
    echo "Fehler: gh (GitHub CLI) ist nicht installiert."
    exit 1
fi
¨
# Daten von GitHub laden
export DATA=$(gh issue list --json number,title,body,labels,milestone --limit 100)

if [ -z "$DATA" ] || [ "$DATA" == "[]" ]; then
    echo "Keine Daten empfangen. Bist du eingeloggt (gh auth status)?"
    exit 1
fi

# Wir nutzen Python, übergeben die Daten aber sicher via Environment Variable
python3 - <<'EOF'
import json
import os
from datetime import datetime

# Daten sicher aus der Umgebungsvariable laden
raw_data = os.environ.get('DATA', '[]')
try:
    data = json.loads(raw_data)
except Exception as e:
    print(f"Fehler beim Parsen der Daten: {e}")
    exit(1)

def get_milestone_order(m):
    if not m: return 9
    title = m.get('title', '')
    if 'Release 1' in title: return 1
    if 'Release 2' in title: return 2
    if 'Release 3' in title: return 3
    return 9

def get_prio_order(labels):
    names = [l['name'] for l in labels]
    if any('prio: 1' in n for n in names): return 1
    if any('prio: 2' in n for n in names): return 2
    if any('prio: 3' in n for n in names): return 3
    return 4

# Sortierung: Meilenstein (Release), dann Priorität
sorted_data = sorted(data, key=lambda i: (get_milestone_order(i.get('milestone')), get_prio_order(i.get('labels'))))

lines = [
    '# 📋 GitHub Issues Roadmap',
    f"_Zuletzt aktualisiert am: {datetime.now().strftime('%d.%m.%Y %H:%M')}_",
    '_Sortiert nach Release und Priorität (High > Medium > Low)_',
    ''
]

for i in sorted_data:
    labels = [l['name'] for l in i['labels']]

    # Prioritäts-Icons
    p = ''
    if any('prio: 1' in n for n in labels): p = '🔥 '
    elif any('prio: 2' in n for n in labels): p = '⚡ '
    elif any('prio: 3' in n for n in labels): p = '☕ '

    # Typ-Icons
    t = ''
    if any(n in ['bug', 'critical'] for n in labels): t = '🔴 '
    elif any(n in ['enhancement', 'feature'] for n in labels): t = '✨ '

    lbl_str = f" [{', '.join(labels)}]" if labels else ""
    m_str = f" 🏁 [{i['milestone']['title']}]" if i.get('milestone') else ""

    lines.append(f"## {p}{t}#{i['number']}: {i['title']}{lbl_str}{m_str}")
    lines.append('---')
    lines.append('**Status / Description:**')

    body = i.get('body') or '_Keine Beschreibung_'
    lines.append(body)
    lines.append('')
    lines.append('---')
    lines.append('')

# Speichern im Hauptverzeichnis des Projekts
target_path = os.path.join(os.getcwd(), 'issues.md')

with open(target_path, 'w', encoding='utf-8') as f:
    f.write('\n'.join(lines))

print(f"Erfolgreich: {target_path} wurde aktualisiert.")
EOF
