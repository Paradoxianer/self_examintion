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
- [x] **3.1 ChartControlWidget**: Universelles Panel zur Filterung und Notiz-Einsicht (Carousel).
- [x] **3.2 Landscape-Fix**: Side-by-Side Layout für alle Charts im Querformat.
- [x] **3.3 Color-Coding**: Systemweite Fragen-Farben in Balken, Linien und Labels.

## Phase 4: Spezifische Chart-Optimierung
- [x] **4.1 Comparison Chart**: Beliebiger Perioden-Vergleich (Woche vs. Woche, etc.) mit Dropdowns.
- [x] **4.2 Time Chart**: Kalender-orientierte Fenster (Woche, Monat, Jahr) mit Navigation.
- [x] **4.3 Radar Chart**: Achsen-Beschriftung mit Prozentwerten und Average-Referenz-Kreis.

## Phase 5: Neue Screens & Sicherheit
- [x] **5.1 Ergebnis-Overview Screen**: (Gestrichen, da durch Phasen 3/4 ersetzt).
- [x] **5.2 Privacy-Schutz**: Biometrie / PIN-Schutz.

## Phase 6: Export & Finalisierung
- [x] **6.1 Export-Manager**: CSV Export Varianten (Alles, Werte+Schnitt, Nur Schnitt).
- [ ] **6.2 Dokumentation & Cleanup**: Finaler Code-Review und Update der README.md.

## Phase 7: Qualitätssicherung & Testing (QA)
- [ ] **7.1 Unit-Tests**: Validierung der Berechnungslogik (Durchschnitte, Zeitfenster, Konvertierungen).
- [ ] **7.2 Widget-Tests**: Überprüfung der UI-Komponenten (Slider-Funktion, Card-States, Dropdowns).
- [ ] **7.3 Integration-Tests**: Durchlauf eines kompletten Assessments bis hin zum Export.
- [ ] **7.4 Lokalisierungs-Check**: Vollständigkeitsprüfung aller unterstützten Sprachen (de, en, es, ko, lt, pl).

## Phase 8: Beta-Release & Publishing
- [ ] **8.1 Branding**: Finalisierung des App-Namens und der Launcher-Icons (Android/iOS).
- [ ] **8.2 Store-Präsenz**: Erstellung von Screenshots und Store-Beschreibungen (lokalisiert).
- [ ] **8.3 Versionierung**: Umstellung auf Version 1.0.0-beta.1 und Konfiguration der Build-Nummern.
- [ ] **8.4 ProGuard & Obfuscation**: Konfiguration für Android (Schutz des Codes).
- [ ] **8.5 Release-Build Test**: Erstellung einer APK/App Bundle und Test auf echtem Endgerät.
