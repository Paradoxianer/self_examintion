# 🚀 Self-Examination App - KI Roadmap
​
Diese Roadmap dient als strukturierte Arbeitsgrundlage für die schrittweise Implementierung und Erweiterung.
​
## Phase 1: Datenmodell & Grundlagen (Infrastruktur)
- [ ] **1.1 Erweiterung Question-Model**: Umstellung von `int answer` (1-4) auf `double value` (0.0 - 1.0 für 0-100%) und Hinzufügen eines optionalen `String note` Feldes pro Frage.
- [ ] **1.2 Migration LocalStorage**: Anpassung der Speicher- und Lademechanik für das neue Format (AssessmentEntry).
- [ ] **1.3 Globales UI-Setup**: Hinzufügen des Settings-Icons in die AppBars von `AssessmentScreen` und `ChartScreen`.
  ​
## Phase 2: Assessment Screen (Eingabe-Logik)
- [ ] **2.1 QuestionCard Upgrade (Slider)**: Umstellung auf 0-100% Slider mit kontinuierlicher Skala.
- [ ] **2.2 QuestionCard Upgrade (Notizen)**: Implementierung eines dezenten Notiz-Icons/Feldes pro Frage (z.B. ausklappbar).
- [ ] **2.3 UI-Cleaning**: Entfernen des globalen Notizfeldes.
- [ ] **2.4 Floating Action Button (FAB)**: Implementierung des "Fertig"-Buttons als FAB im Scaffold (löst das Verschwinden im Landscape).
- [ ] **2.5 Unbeantwortet-Status**: Visuelle Kennzeichnung (z.B. Graustufen oder Opacity), wenn ein Slider noch nicht bewegt wurde.
  ​
## Phase 3: Chart-Infrastruktur & Shared Widgets
- [ ] **3.1 ChartControlWidget**: Entwicklung eines universellen Widgets unterhalb der Charts zur Auswahl/Abwahl einzelner Fragen (Checkboxen mit Farben).
- [ ] **3.2 Landscape-Fix**: Refactoring des Layouts mittels `LayoutBuilder` / `OrientationBuilder`, damit Charts im Landscape die volle Breite nutzen und nicht schrumpfen.
- [ ] **3.3 Color-Coding**: Systemweite Verknüpfung der Fragen-Farben mit den Chart-Elementen.
  ​
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
- [ ] **5.1 Ergebnis-Overview Screen**: Neue Ansicht mit allen Antworten als `LinearProgressIndicator` (color-coded).
- [ ] **5.2 Privacy-Schutz**: Implementierung von Biometrie (Fingerabdruck/FaceID) oder PIN-Schutz beim App-Start/Screen-Wechsel.
  ​
## Phase 6: Export & Finalisierung
- [ ] **6.1 Export-Manager**: Implementierung der drei Export-Varianten (Alles, Werte+Schnitt, Nur Schnitt) als CSV/PDF.
- [ ] **6.2 Dokumentation & Cleanup**: Finaler Code-Review und Update der README.md.
  Das ist ein ambitionierter und sehr strukturierter Plan! Um das Projekt stabil zu halten und die von dir beschriebenen Probleme (wie den Landscape-Fehler oder die Zeitbereichs-Bugs) systematisch zu lösen, habe ich eine "KI-Ready Roadmap" erstellt.
  Ich werde diese Roadmap jetzt als ROADMAP.md in dein Projektverzeichnis schreiben. So können wir beide (du und ich) uns bei jedem Schritt darauf beziehen und die "Todos" abarbeiten.
  Strategie
  Wir gehen von der Datenstruktur über die UI-Logik hin zu den Features. Das verhindert, dass wir die Charts reparieren müssen, bevor die neuen 0-100% Daten überhaupt existieren.
  Hier ist die detaillierte Roadmap:
  ROADMAP.md
  +40