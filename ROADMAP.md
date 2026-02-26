# 🚀 Self-Examination App - Roadmap

Diese Roadmap beschreibt den Weg von der aktuellen Beta-Version hin zu einer stabilen, vernetzten und motivierenden Begleiter-App.

---

## 📅 V1.0 - Das Fundament & Beta-Release (Abgeschlossen / In Arbeit)

### Phase 1 - 7: ✅ Aufbau & Grundfunktionen
*   Implementierung des Datenmodells, UI-Redesign, Diagramme, Security, Export und QA-Tests.

### Phase 8: Beta-Release & Publishing (In Arbeit)
- [x] **8.1 Branding & Visuals**: App-Name "Self-Examination" und adaptive Icons finalisiert.
- [x] **8.2 Store-Präsenz**: Beschreibungen in 6 Sprachen erstellt.
- [x] **8.3 Versionierung**: Auf 1.0.0-beta.1+7 gesetzt.
- [x] **8.4 Security**: ProGuard/R8 Code-Verschleierung aktiv.
- [x] **8.5 Release-Build**: `flutter build appbundle` ausgeführt.
- [x] **8.6 Store-Upload**: AAB in die Play Console hochgeladen.
- [x] **8.7 Chart-Stabilität**: Fehler bei Radar-Chart und "Gesamt"-Index korrigiert.

---

## 🛠 V2.0 - Stabilität, Wachstum & Gemeinschaft

Diese Phase beginnt nach dem erfolgreichen ersten Release der Version 1.0.

### Phase 2.1: Modernisierung & Sicherheit (Architektur-Upgrade)
*Ziel: Die App schneller und bereit für die Cloud machen.*
- [ ] **Modernisierung der Technik (Refactoring)**: Einführung eines "Repository-Patterns", um die App fit für Cloud-Sync und Reporting zu machen.
- [ ] **Sicherer & Schneller (Datenbank-Umstellung) (#33)**: Wechsel von einfachem Speicher zu einer echten, verschlüsselten Datenbank (Isar/SQLite). Ermöglicht flüssiges Suchen ohne Ladezeiten.
- [ ] **Daten-Frühjahrsputz (#37)**: Korrektur der Beispieldaten im Heilsarmee-Set Chemnitz.

### Phase 2.2: Dein persönlicher Begleiter
*Ziel: Mehr Individualität und bessere tägliche Unterstützung.*
- [ ] **Eigene Fragen-Sets erstellen (#41)**: Ermögliche es Nutzern, komplett eigene Reflexions-Sets anzulegen.
- [ ] **Erinnerungen & Impulse (#3)**: 
    - Sanfte Erinnerungen per Push-Benachrichtigung (einstellbar), um die regelmäßige Selbstprüfung zu unterstützen.
- [ ] **Sprachvielfalt (#24)**: Übersetzung in Ukrainisch und Russisch.
- [ ] **Inhaltliche Erweiterung (#17)**: Integration weiterer Sets (z.B. Wesley, DiscipleBuilding, 30 Fragen zur Reflexion).

### Phase 2.3: Motivation & Belohnung (Gamification)
*Ziel: Dranbleiben belohnen.*
- [ ] **Dranbleiben-Zähler (#35)**: Visualisierung von "Streaks" (Serien) bei regelmäßiger Nutzung.
- [ ] **Meilensteine**: Kleine Auszeichnungen und Medaillen für erreichte Ziele.

### Phase 2.4: Vernetzung & Gemeinsames Wachstum (Optional)
*Ziel: Cloud-Sync und anonymisierter Austausch.*
- [ ] **Deine Daten überall (Cloud-Sync) (#42)**: Optionaler Login, um Daten zwischen Web und Mobile zu synchronisieren (Datenschutz bleibt priorisiert).
- [ ] **Gemeinsam wachsen (Heilsarmee-Reporting) (#43)**: 
    - Entwicklung einer Funktion, um anonymisierte Durchschnittswerte an ein Korps oder die Heilsarmee Deutschland zu senden.
    - Fokus auf strikte Anonymisierung und Datenschutz ("Privacy by Design").

---

## 💡 Unsere Leitlinien (nach Principal Flutter Architect)
*   **Datenschutz zuerst**: Alle Cloud-Funktionen bleiben optional. Lokale Speicherung ist der Standard.
*   **Sauberer Code**: Keine "Quick & Dirty"-Lösungen für Version 2.0.
*   **Einfachheit**: Die Bedienung muss trotz neuer Funktionen intuitiv bleiben.
