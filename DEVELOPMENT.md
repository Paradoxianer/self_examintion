# 🛠 Development & Workflow Guidelines

## 🏷 GitHub Labels
These are the official labels used in this repository.

| Name | Description | Color | Icon |
| :--- | :--- | :--- | :--- |
| `critical` | Critical issue that blocks progress | #b60205 | 🔥 |
| `bug` | Something isn't working | #d73a4a | 🔴 |
| `prio: 1` | High priority - needs immediate attention | #d73a4a | 🔥 |
| `prio: 2` | Medium priority | #e99695 | ⚡ |
| `prio: 3` | Low priority / Coffee time | #c5def5 | ☕ |
| `feature` | New feature request | #a2eeef | ✨ |
| `enhancement` | New feature or request | #a2eeef | ⚡ |
| `documentation` | Improvements or additions to documentation | #0075ca | ☕ |
| `question` | Further information is requested | #d876e3 | ❓ |
| `help wanted` | Extra attention is needed | #008672 | 🙋‍♂️ |
| `good first issue` | Good for newcomers | #7057ff | 👶 |
| `invalid` | This doesn't seem right | #e4e669 | 🚫 |
| `duplicate` | This issue or pull request already exists | #cfd3d7 | 👯 |
| `wontfix` | This will not be worked on | #ffffff | 🙅 |

## 🏁 Milestones (Release Cycles)
To list all milestones via CLI, use the GitHub API:
`gh api repos/Paradoxianer/self_examintion/milestones --jq ".[] | {title: .title, number: .number, state: .state}"`

| ID | Title | Strategic Goal |
| :--- | :--- | :--- |
| **4** | **Release 1** | **The Multi-Platform Launch** (Stability, Store Presence, R1 Launch-Blockers) |
| **5** | **Release 2** | **Engagement & Architecture** (SQLite Migration, Gamification, Push Notifications) |
| **6** | **Release 3** | **Connectivity & Vision** (Optional Cloud Sync, Regional Reporting) |

## 🛠 Useful Commands
- `.\scripts\init_store_metadata.ps1`: Syncs Android & iOS metadata.
- `fastlane supply init`: Fetch metadata from Google Play.
- `gh issue list --milestone 4`: List all issues for Release 1.
- `gh issue list --milestone 5`: List all issues for Release 2.

## 📦 Play Store Update Checklist (on the machine with the release keystore)
Der Store-Eintrag ist bereits live ("Erster Beta-Release", Stand 12.02.2026, 6 Sprachen).
Der lokale Code-Stand ist weiter (8 Sprachen, Radar-Chart-Fix #58, Onboarding, Directional Arrows #56).
Vorbereitet in diesem Repo, noch auszuführen auf dem Rechner mit `key.properties`/Keystore:
1. `flutter build appbundle --release`
2. `cd android && fastlane deploy` (nutzt `android/fastlane/metadata/android/*`, inkl. neuem Changelog `changelogs/8.txt` für de-DE & en-US — Versionscode ggf. anpassen, falls sich `pubspec.yaml` bis dahin geändert hat)
3. Screenshots prüfen: `en-US/images/phoneScreenshots/` ist aktuell **leer** — die bisherigen "en-US"-Screenshots zeigten fälschlich deutsche UI-Texte und wurden nach `de-DE/images/phoneScreenshots/` verschoben. Für einen sauberen en-US-Eintrag auf einem Gerät mit englischer App-Sprache neue Screenshots derselben 7 Ansichten aufnehmen (Home, Radar-Chart, Fragenset-Info-Dialog, Balkendiagramm-Vergleich, Einstellungen, Notiz-Eingabe, Fragenliste).
4. Für die restlichen 6 Sprachen (es, ko, lt, pl, uk, ru) gibt es keine eigenen Screenshots — Play Store zeigt dort automatisch die Standard-Listing-Bilder (kein Launch-Blocker, optional nachrüstbar).
