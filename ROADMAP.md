# 🚀 Self-Examination App - KI Roadmap

Diese Roadmap dient als strukturierte Arbeitsgrundlage für die schrittweise Implementierung und Erweiterung.

## Phase 1: Datenmodell & Grundlagen (Infrastruktur)
- [x] **1.1 Erweiterung Question-Model**: Umstellung auf `double value` (0.0-1.0) und Hinzufügen von `note`.
- [x] **1.2 Migration LocalStorage**: Anpassung der Speicher- und Lademechanik für das neue Format.
- [x] **1.3 Globales UI-Setup**: Settings-Icon in allen AppBars integriert.

## Phase 2: Assessment Screen (Eingabe-Logik)
- [x] **2.1 QuestionCard Upgrade (Slider)**: Kontinuierlicher 0-100% Slider mit lokalisierten Labels.
- [x] **2.2 QuestionCard Upgrade (Notizen)**: Dezent ausklappbare Notizfelder pro Frage.
- [x] **2.3 UI-Cleaning**: Globales Notizfeld entfernt.
- [x] **2.4 Floating Action Button (FAB)**: "Fertig"-Button als FAB im Scaffold (Landscape-sicher).
- [x] **2.5 Unbeantwortet-Status**: Visuelle Kennzeichnung (Grau) und Validierungs-Dialog mit Auto-Set auf 0.0.

## Phase 3: Chart-Infrastruktur & Shared Widgets
- [ ] **3.1 ChartControlWidget**: Entwicklung eines universellen Widgets unterhalb der Charts zur Auswahl/Abwahl einzelner Fragen (Checkboxen mit Farben).
- [ ] **3.2 Landscape-Fix**: Refactoring des Layouts mittels `LayoutBuilder` / `OrientationBuilder`, damit Charts im Landscape die volle Breite nutzen.
- [ ] **3.3 Color-Coding**: Systemweite Verknüpfung der Fragen-Farben mit den Chart-Elementen.

## Phase 4: Spezifische Chart-Optimierung
- [ ] **4.1 Comparison Chart**:
    - [ ] Auswahl der Vergleichs-Daten (Datum A vs. Datum B).
    - [ ] Legende mit Fragen-Texten statt nur Nummern.
- [ ] **4.2 Time Chart**:
    - [ ] Fix: Clipping-Fehler bei Zeitbereichen > 1 Monat.
    - [ ] Zeitbereichs-QuickButtons (2T, 1W, 1M, 1J, 5J).
    - [ ] Navigations-Buttons (Vor/Zurück) für den Zeitbereich.
- [ ] **4.3 Radar Chart**:
    - [ ] Beschriftung der Achsen mit Fragen-Kurztexten.
    - [ ] Farbliche Füllung entsprechend der Durchschnittswerte.
      ​
## Phase 5: Neue Screens & Sicherheit
- [ ] **5.1 Ergebnis-Overview Screen**: Neue Ansicht mit `LinearProgressIndicator`.
- [ ] **5.2 Privacy-Schutz**: Biometrie / PIN-Schutz.

## Phase 6: Export & Finalisierung
- [ ] **6.1 Export-Manager**: CSV/PDF Export Varianten.
- [ ] **6.2 Dokumentation & Cleanup**.
