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
*   **Stability Test Suite (#55)**: 100% Abdeckung der Kern-Logik und UI-Flows (39 Tests passend).
*   **iOS Version Polishing (#50)**: Safe-Area-Anpassungen, haptisches Feedback in Onboarding, Assessment & Settings, sowie UI-Konsistenz-Optimierungen.

### 🔥 Prio 1: Ausstehende Launch-Blocker
- [ ] **Web Version (#53)**: PWA Service Worker & Asset Optimization.
- [ ] **App Store Release (#52)**: Metadata & Screenshots.
- [ ] **Google Play Release (#51)**: Listing & Production Track.

### ⚡ Prio 2: Qualitätssicherung & UX
- [x] **Phase 1: Recovery & Fixes**: Alle Regressionsfehler behoben.
- [x] **Phase 2: Deep Logic Unit Tests**: AssessmentCalculator & LocalStorage verifiziert.
- [x] **Phase 3: Automated Integrity**: QuestionSet-Abgleich über alle Sprachen.
- [x] **Phase 4: Expanded Widget & Integration Tests**: SettingsFlow, AuthFlow & Lifecycle verifiziert.

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
