# 🚀 Self-Examination App - Strategische Roadmap

Diese Roadmap definiert den Weg von der Beta zur professionellen Multi-Plattform-Lösung. Sie ist nach Release-Zyklen strukturiert, um einen klaren Fokus auf den Markteintritt und die Nutzererfahrung zu gewährleisten.

---

## 🏁 Release 1: The Multi-Platform Launch
*Ziel: Volle Verfügbarkeit auf iOS, Android und im Web bei maximaler Stabilität.*

### ✅ Bereits abgeschlossen (R1 Progress)
*   **User Onboarding (#47 & #46)**: Vollständiger Einführungsprozess zur Erklärung von Slidern, Notizen und Analyse-Funktionen.
*   **Sprachvielfalt (#24)**: Unterstützung für DE, EN, ES, KO, LT, PL, UK und RU (Russisch neu hinzugefügt).
*   **Daten-Portabilität (#49)**: CSV-Export mit kontextbezogenen Headern (Fragentexte statt IDs).
*   **Dynamic Language Support**: Umschalten der App-Sprache unabhängig von den Systemeinstellungen (via `--dart-define`).
*   **Security Foundation**: Implementierung des Biometrie-Lock-Screens und der Security-Services.

### 🔥 Prio 1: Ausstehende Launch-Blocker
- [ ] **iOS Version (#50)**: Konfiguration der Biometrie-Berechtigungen (FaceID), Safe-Area-Anpassungen für moderne iPhones und Hardware-Tests.
- [ ] **Web Version (#53)**: Deployment als Progressive Web App (PWA) inklusive Service-Worker-Konfiguration und Asset-Optimierung.
- [ ] **App Store Release (#52)**: Vorbereitung der Apple-Metadaten, Screenshots (6.5"/5.5") und Einreichung zur Prüfung.
- [ ] **Google Play Release (#51)**: Finalisierung des Store-Listings und Management des Produktions-Tracks in der Play Console.
- [ ] **Performance Profiling (#54)**: Identifikation von Effizienz-Bottlenecks mittels Flutter DevTools (Fokus auf Speicherverbrauch und Chart-Rendering).

### ⚡ Prio 2: Qualitätssicherung
- [ ] **Stability Test Suite (#55)**: Implementierung von Unit-Tests für die Berechnungs-Logik und Integrationstests für die neuen Plattformen.

---

## 🛠 Release 2: Modernisierung & Engagement
*Ziel: Technisches Refactoring für Skalierbarkeit und Steigerung der langfristigen Nutzerbindung.*

### ⚡ Prio 2: Architektur & Content
- [ ] **Datenbank-Migration (#33)**: Wechsel von SharedPreferences zu SQLite. **Fokus Effizienz:** Selektives Laden von Daten (Date-Range Filtering) auf Datenbankebene, um den RAM-Verbrauch zu minimieren.
- [ ] **Content Expansion (#48)**: Ausbau der Beschreibungen für John Wesley und William Booth Sets (DE, EN, RU) für mehr geistliche Tiefe.
- [ ] **Push-Benachrichtigungen (#3)**: Implementierung lokaler Reminder zur Unterstützung der täglichen Reflexions-Routine.
- [ ] **Accountability Partner (#45)**: Sicheres Teilen von Fortschritten mit Mentoren (Privacy-Filter für Notizen).

### ☕ Prio 3: Individualität & Motivation
- [ ] **Eigene Fragen-Sets (#41)**: Werkzeuge für Nutzer, um komplett eigene Reflexions-Strukturen anzulegen.
- [ ] **Gamification (#35)**: Einführung von Streaks und Meilensteinen zur langfristigen Motivation.
- [ ] **Data Cleanup (#37)**: Bereinigung der Beispieldaten im Heilsarmee-Set Chemnitz.

---

## ☁️ Release 3: Connectivity & Vision
*Ziel: Vernetzung und übergeordnetes Reporting.*

- [ ] **Synchronisation (#42)**: Optionaler Login für den Datenabgleich zwischen Web und Mobile.
- [ ] **Heilsarmee Reporting (#43)**: Anonymisierte Übermittlung von Durchschnittswerten für regionale Auswertungen (Privacy by Design).

---

## 🛡 Leitlinien (Principal Architect Standards)
1.  **Privacy by Design**: Alle Cloud-Funktionen sind "Opt-In". Die Hoheit über die Daten liegt beim Nutzer.
2.  **Performance-Kultur**: Wir raten nicht, wir messen (Profiling). Bottlenecks werden an der Wurzel (Datenbank/Algorithmus) behoben.
3.  **Cross-Platform Consistency**: Die Erfahrung auf iOS, Android und Web muss sich nativ und hochwertig anfühlen.

_Zuletzt aktualisiert am: 28. Februar 2025_
