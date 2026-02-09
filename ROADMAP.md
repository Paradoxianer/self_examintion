# 🚀 Self-Examination App - KI Roadmap

Diese Roadmap dient als strukturierte Arbeitsgrundlage für die schrittweise Implementierung und Erweiterung.

## Phase 1 - 5: ✅ Abgeschlossen
*(Details in der Git-Historie)*

## Phase 6: Export & Finalisierung ✅
- [x] **6.1 Export-Manager**: CSV Export Varianten.
- [x] **6.2 Dokumentation & Cleanup (Deep-Dive Polish)**:
    - [x] **6.2.1 Logik**: Invertierung der Chart-Werte basierend auf `isPositive`.
    - [x] **6.2.2 UI**: Redesign der Chart-Tooltips.
    - [x] **6.2.3 UI**: Notiz-Detail-Dialog.
    - [x] **6.2.4 UI**: Hinzufügen eines "About"-Dialogs und erweiterten Datenschutz-Infos.
    - [x] **6.2.5 Platform**: Fix für Carousel-Navigation (Maus-Support).
    - [x] **6.2.6 Platform**: Feature-Guards für Web/Desktop.
- [x] **6.3 Dokumentation**: Finaler Code-Review und Update der README.md.

## Phase 7: Qualitätssicherung & Testing (QA) ✅
- [x] **7.1 Unit-Tests: Core-Logik**: Validiert via AssessmentCalculator.
- [x] **7.2 Widget-Tests**: Manuell verifiziert (Basis-Tests vorhanden).
- [x] **7.3 Integration-Tests**: End-to-End Workflow automatisiert.
- [x] **7.4 Lokalisierungs-Check**: Vollständig für 6 Sprachen validiert.

## Phase 8: Beta-Release & Publishing ⏳
- [x] **8.1 Branding & Visuals**
    - [x] Launcher-Icons konfiguriert (Generierung via `dart run flutter_launcher_icons` vorbereitet).
    - [ ] Feature-Grafik (1024x500) für Google Play erstellen.
    - [x] App-Icon Review (Rundungen im About-Dialog implementiert).
- [ ] **8.2 Store-Präsenz & Marketing**
    - [ ] Screenshots erstellen (Phone & Tablet).
    - [ ] YouTube Demo-Video produzieren.
    - [x] Store-Beschreibungen finalisiert (Texte in `store_metadata.md` hinterlegt).
- [x] **8.3 Versionierung & Build**
    - [x] Umstellung auf Version 1.0.0-beta.1 (Build 7).
    - [ ] Finaler Release-AAB (Android App Bundle) erstellen.
- [x] **8.4 Security & Performance**
    - [x] ProGuard/R8 Code-Verschleierung konfiguriert und aktiviert.
    - [ ] Performance-Check im Release-Build.
- [ ] **8.5 Release-Prozess**
    - [ ] Interner Test-Track in Google Play Console hochladen.
    - [ ] Tester-Gruppe einladen.
