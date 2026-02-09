# 🚀 Self-Examination App - KI Roadmap

Diese Roadmap dient als strukturierte Arbeitsgrundlage für die schrittweise Implementierung und Erweiterung.

## Phase 1 - 5: ✅ Abgeschlossen
*(Details in der Git-Historie)*

## Phase 6: Export & Finalisierung ✅
- [x] **6.1 Export-Manager**: CSV Export Varianten.
- [x] **6.2 Dokumentation & Cleanup (Deep-Dive Polish)**:
    - [x] **6.2.1 Logik**: Invertierung der Chart-Werte basierend auf `isPositive` (Sünden vs. Tugenden).
    - [x] **6.2.2 UI**: Redesign der Chart-Tooltips (bessere Lesbarkeit).
    - [x] **6.2.3 UI**: Notiz-Detail-Dialog beim Antippen im Carousel.
    - [ ] **6.2.4 UI**: Hinzufügen eines "About"-Dialogs und erweiterten Datenschutz-Infos.
    - [x] **6.2.5 Platform**: Fix für Carousel-Navigation auf Web/Desktop (Maus-Support).
    - [x] **6.2.6 Platform**: Feature-Guards für Web/Desktop (Biometrie/Export Deaktivierung).
- [x] **6.3 Dokumentation**: Finaler Code-Review und Update der README.md.

## Phase 7: Qualitätssicherung & Testing (QA) ⏳
- [x] **7.1 Unit-Tests: Core-Logik**
    - [x] Test der Invertierungs-Logik (`isPositive`) für verschiedene Fragen-Typen.
    - [x] Validierung der Durchschnittsberechnung (Tageswert vs. Periodendurchschnitt).
    - [ ] Korrektheit der Zeitfenster-Berechnung (ISO-Wochen, Monatsgrenzen).
    - [ ] Validierung der CSV-String-Generierung (Maskierung von Sonderzeichen).
- [ ] **7.2 Widget-Tests: UI-Komponenten**
- [ ] **7.3 Integration-Tests: End-to-End Workflows**
- [ ] **7.4 Lokalisierungs-Check**

## Phase 8: Beta-Release & Publishing
- [ ] **8.1 Branding**: App-Name und Launcher-Icons.
- [ ] **8.2 Store-Präsenz**: Screenshots und Beschreibungen.
- [ ] **8.3 Versionierung**: Umstellung auf Version 1.0.0-beta.1.
- [ ] **8.4 ProGuard**: Android-Code-Schutz.
- [ ] **8.5 Release-Build**: Finaler Test auf Hardware.
