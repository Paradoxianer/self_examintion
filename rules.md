# Flutter Development Rules & Best Practices

## 1. Code-Architektur & Qualität
* **Modularität:** Lagere wiederkehrende UI-Elemente konsequent in eigene Widgets aus. Vermeide "Monster-Build-Methoden".
* **DRY-Prinzip:** Vermeide Code-Duplizierung. Wenn Logik oder UI mehrfach erscheint, überführe sie in Helper-Klassen oder Shared Widgets.
* **Maßvolle Abstraktion:** Unterteile Code sinnvoll zur Lesbarkeit, aber vermeide "Over-Engineering" (keine unnötigen Schichten für triviale Aufgaben).
* **Framework-First:** Nutze primär Flutter Built-in Widgets und etablierte Packages (pub.dev), bevor du komplexe Eigenlösungen (Bikeshedding) entwickelst.

## 2. Struktur gegen Spaghetti-Code
* **Logic Separation:** Trenne UI (Widgets) strikt von der Geschäftslogik. Die `build`-Methode sollte rein deklarativ sein.
* **State Management:** Nutze ein konsistentes State Management. Keine komplexen Zustandsänderungen direkt im UI-Baum.
* **Small Files:** Versuche, Dateien übersichtlich zu halten. Eine Datei pro Widget-Klasse ist der Standard.

## 3. Coding Style & Dokumentation
* **Kommentierung:** Kommentiere das "Warum", nicht das "Was". Erkläre komplexe Logik kurz und präzise. Selbsterklärender Code benötigt keine Kommentare.
* **Naming:** Nutze sprechende Variablen- und Methodennamen. Ein Name wie `calculateUserTotal()` ist besser als `calc()`.
* **Immutability:** Bevorzuge `final` und nutze `const` Konstruktoren, wo immer möglich, um die Performance zu optimieren.

## 4. Sicherheit & Fehlerbehandlung
* **Null Safety:** Nutze Darts Type-System konsequent. Vermeide den Force-Unwrap Operator `!`, außer es ist absolut sicher.
* **Async/Await:** Nutze `try-catch` bei API-Calls oder asynchronen Operationen, um App-Crashes zu verhindern.

## 5. Deployment & Commit-Disziplin
* **Commit-Messages:** Erzeuge nach jeder relevanten Codeänderung oder Lösung eines Problems automatisch einen Vorschlag für eine aussagekräftige Commit-Nachricht.
* **Format:** Die Nachricht sollte kurz und präzise sein (maximal 1–4 Zeilen).
* **Struktur:** Nutze idealerweise das "Conventional Commits" Format (z.B. `feat: ...`, `fix: ...`, `refactor: ...`), um die Art der Änderung sofort erkennbar zu machen.