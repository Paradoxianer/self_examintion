# 🚀 Self-Examination App - Strategische Roadmap

Diese Roadmap definiert den Weg von der Beta zur professionellen Multi-Plattform-Lösung. Sie ist nach Release-Zyklen strukturiert, um einen klaren Fokus auf den Markteintritt und die Nutzererfahrung zu gewährleisten.

---

## 🏁 Release 1: The Multi-Platform Launch
*Ziel: Volle Verfügbarkeit auf iOS, Android und im Web bei maximaler Stabilität.*

### ✅ Bereits abgeschlossen (R1 Progress)
*   **User Onboarding (#47 & #46)**: Einführungsprozess für Slider, Notizen und Analyse.
*   **Sprachvielfalt (#24)**: Support für 8 Sprachen inkl. In-App Switcher.
*   **Performance Profiling (#54)**: Benchmarks für SharedPreferences (< 70ms bei 1000 Einträgen).
*   **Daten-Portabilität (#49)**: CSV-Export mit dynamischen Headern.
*   **Security Foundation**: Biometrie-Logik und Auth-Wrapper.
*   **Navigation: Directional Arrows (#56)**: Pfeil-Navigation in den Charts implementiert.
*   **UI Resilience**: Fix von RenderFlex Overflows in der Chart-Steuerung.

### 🔥 Prio 1: Ausstehende Launch-Blocker
- [ ] **iOS Version (#50)**: FaceID Permissions & Safe-Area Polishing.
- [ ] **Web Version (#53)**: PWA Service Worker & Asset Optimization.
- [ ] **App Store Release (#52)**: Metadata & Screenshots.
- [ ] **Google Play Release (#51)**: Listing & Production Track.

### ⚡ Prio 2: Finalisierung Stability Test Suite (#55)
*Ziel: 100% Test-Abdeckung der kritischen Business-Logik und UI-Flows.*

- [x] **Phase 1: Recovery & Fixes**:
    - [x] Integrationstest: Onboarding-Skip Logik.
    - [x] Widget-Tests: Lokalisierungs-Strings (Zehn Gebote vs. Heilsarmee).
    - [x] UI-Stability: Scrollable TimeRange Selector (Fix Overflow).
- [x] **Phase 2: Deep Logic Unit Tests**:
    - [x] `AssessmentCalculator`: Inversions-Logik (Sünde vs. Tugend), CSV-Escaping von Sonderzeichen, ISO-Wochenberechnung.
    - [x] `LocalStorage`: Mocking SharedPreferences, Serialisierung von Notizen, Author-Filtering.
- [x] **Phase 3: Automated Integrity**:
    - [x] `QuestionSetIntegrity`: Automatisierter Abgleich der Fragen-Anzahl über alle 8 Sprachen.
- [ ] **Phase 4: Expanded Widget & Integration Tests**:
    - [ ] `SettingsFlow`: Validierung der Sprachumstellung (Rebuild-Trigger) und Biometrie-Toggle Persistenz.
    - [ ] `AuthFlow Integration`: Simulation von Biometrie-Erfolg/Fehler im `AuthWrapper` (Mocking `local_auth`).
    - [ ] `Full Lifecycle Test`: Vollständiger Durchlauf: Start -> Slider -> Notiz -> Speichern -> Chart-Filterung.

---

## 🛠 Release 2: Modernisierung & Engagement
*Ziel: Refactoring & User Retention.*

- [ ] **UI Landscape Optimization (#57)**: Ergonomie für Querformat (Tablet/Web).
- [ ] **Datenbank-Migration (#33)**: SharedPreferences -> SQLite.
- [ ] **Content Expansion (#48)**: Deep-Dive Beschreibungen (DE/EN/RU).
- [ ] **Push-Benachrichtigungen (#3)**: Lokale Reminder-Engine.
- [ ] **Accountability Partner (#45)**: Progress Sharing (Privacy-First).

---

## ☁️ Release 3: Connectivity & Vision
- [ ] **Synchronisation (#42)**: Cross-Device Sync.
- [ ] **Heilsarmee Reporting (#43)**: Anonymisierte regionale Statistiken.

---

## 🛡 Leitlinien
1. **Privacy by Design**: Daten bleiben lokal, Cloud ist Opt-In.
2. **Performance**: Keine Ruckler bei > 500 Einträgen (Profiling-Pflicht).
3. **Nativ-Feeling**: Anpassung an iOS/Android/Web Standards.

_Zuletzt aktualisiert am: 04. März 2025_
