# 🚀 Self-Examination App - Strategische Roadmap

Diese Roadmap definiert den Weg von der Beta zur professionellen Multi-Plattform-Lösung. Sie ist nach Release-Zyklen strukturiert, um einen klaren Fokus auf den Markteintritt und die Nutzererfahrung zu gewährleisten.

---

## 🏁 Release 1: The Multi-Platform Launch
*Ziel: Volle Verfügbarkeit auf iOS, Android und im Web bei maximaler Stabilität.*

### ✅ Bereits abgeschlossen (R1 Progress)
*   **User Onboarding (#47 & #46)**: Vollständiger Einführungsprozess zur Erklärung von Slidern, Notizen und Analyse-Funktionen.
*   **Sprachvielfalt (#24)**: Unterstützung für DE, EN, ES, KO, LT, PL, UK und RU. Inklusive **In-App Sprachwahl** zur Laufzeit.
*   **Performance Profiling (#54)**: Benchmark-Tests für SharedPreferences durchgeführt (1000 Einträge in < 20ms). Optimierung des Chart-Loading (Einmaliges Laden in initState).
*   **Daten-Portabilität (#49)**: CSV-Export mit kontextbezogenen Headern (Fragentexte statt IDs).
*   **Security Foundation**: Implementierung des Biometrie-Lock-Screens und der Security-Services.

### 🔥 Prio 1: Ausstehende Launch-Blocker
- [ ] **iOS Version (#50)**: Konfiguration der Biometrie-Berechtigungen (FaceID), Safe-Area-Anpassungen für moderne iPhones und Hardware-Tests.
- [ ] **Web Version (#53)**: Deployment als Progressive Web App (PWA) inklusive Service-Worker-Konfiguration und Asset-Optimierung.
- [ ] **App Store Release (#52)**: Vorbereitung der Apple-Metadaten, Screenshots (6.5"/5.5") und Einreichung zur Prüfung.
- [ ] **Google Play Release (#51)**: Finalisierung des Store-Listings und Management des Produktions-Tracks in der Play Console.

### ⚡ Prio 2: Qualitätssicherung & UX (Stability Test Suite #55)
*Ziel: 100% Durchlaufquote der Kernfunktionen und Vermeidung von Regressionsfehlern durch Lokalisierung.*

- [x] **Initial Fixes**: Integrationstest-Flow (Onboarding-Skip) und Lokalisierungs-Strings in Widget-Tests korrigiert.
- [ ] **Core Unit Tests**:
    - [ ] `AssessmentCalculator`: Validierung der Scoring-Logik (Edge-Cases 0/100%).
    - [ ] `LocalStorage`: Test der Datenintegrität beim Speichern und Laden großer Mengen.
- [ ] **UI & Widget Testing**:
    - [ ] `Localization Coverage`: Sicherstellen, dass alle 8 Sprachen die korrekten Keys für alle Fragensets liefern.
    - [ ] `Settings & Persistence`: Test der Sprachumstellung und deren Persistenz nach App-Neustart.
    - [ ] `Chart-Interaktion`: Validierung der Filter-Logik und Zeitbereichs-Auswahl.
- [ ] **Cross-Platform Integration**:
    - [ ] Simulation von Biometrie-Fehlern (iOS/Android).
    - [ ] Web-spezifische Tests (Routing & LocalStorage-Fallback).

- [ ] **Navigation: Directional Arrows (#56)**: Implementierung von Pfeil-Navigation für Charts (optimiert für Web/Desktop).

---

## 🛠 Release 2: Modernisierung & Engagement
*Ziel: Technisches Refactoring für Skalierbarkeit und Steigerung der langfristigen Nutzerbindung.*

### ⚡ Prio 2: Architektur & Content
- [ ] **UI Landscape Optimization (#57)**: Refactoring des `ChartControlWidget` und ergonomische Anpassung für Querformat.
- [ ] **Datenbank-Migration (#33)**: Wechsel von SharedPreferences zu SQLite. (Bestätigt als nicht kritisch für R1, aber wichtig für langfristige Skalierbarkeit).
- [ ] **Content Expansion (#48)**: Ausbau der Beschreibungen für John Wesley und William Booth Sets (DE, EN, RU).
- [ ] **Push-Benachrichtigungen (#3)**: Implementierung lokaler Reminder.
- [ ] **Accountability Partner (#45)**: Sicheres Teilen von Fortschritten mit Mentoren (Privacy-Filter für Notizen).

---

## ☁️ Release 3: Connectivity & Vision
*Ziel: Vernetzung und übergeordnetes Reporting.*

- [ ] **Synchronisation (#42)**: Optionaler Login für den Datenabgleich zwischen Web und Mobile.
- [ ] **Heilsarmee Reporting (#43)**: Anonymisierte Übermittlung von Durchschnittswerten für regionale Auswertungen.

---

## 🛡 Leitlinien (Principal Architect Standards)
1.  **Privacy by Design**: Alle Cloud-Funktionen sind "Opt-In". Die Hoheit über die Daten liegt beim Nutzer.
2.  **Performance-Kultur**: Wir raten nicht, wir messen (Profiling). Bottlenecks werden an der Wurzel (Datenbank/Algorithmus) behoben.
3.  **Cross-Platform Consistency**: Die Erfahrung auf iOS, Android und Web muss sich nativ und hochwertig anfühlen.

_Zuletzt aktualisiert am: 04. März 2025_
