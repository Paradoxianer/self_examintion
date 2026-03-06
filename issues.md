# 📋 GitHub Issues Roadmap
_Sortiert nach Release und Priorität (High > Medium > Low)_

## 🔥 ✨ #50: need to create a iOS Version [prio: 1, feature] 🏁 [Release 1]
---
**Status / Description:**
Crucial for multi-platform launch. Task: Verify local_auth and share_plus configurations for iOS, fix safe area issues on iPhones with notches, and test on physical iOS hardware.

---

## 🔥 🔴 #51: Release Process: Google Play Store [prio: 1, critical] 🏁 [Release 1]
---
**Status / Description:**
Prepare Store Listing (Short/Long description), generate production app bundle (AAB), and manage the closed testing track.

---

## 🔥 🔴 #54: Performance Profiling & Bottleneck Analysis [bug, prio: 1] 🏁 [Release 1]
---
**Status / Description:**
Use the Flutter DevTools Profiler to identify efficiency bottlenecks. Focus: 1. Memory footprint when scaling history. 2. CPU spikes during chart rendering. 3. Startup time optimization.

---

## 🔥 🔴 #52: Release Process: Apple App Store [prio: 1, critical] 🏁 [Release 1]
---
**Status / Description:**
High Priority. Task: Setup Apple Developer Account, create App ID and provisioning profiles, prepare store metadata, and generate 6.5-inch and 5.5-inch screenshots.

---

## ⚡ ✨ #55: Test Suite: Stability & Regression [enhancement, prio: 2] 🏁 [Release 1]
---
**Status / Description:**
Ensure core features dont break. Task: Implement Unit Tests for data processing and Integration Tests for the new iOS/Web platforms.

---

## 🔥 #48: Expand descriptions for self-examination questions [documentation, prio: 1, prio: 2] 🏁 [Release 2]
---
**Status / Description:**
Content is the soul of the app. Task: Expand descriptions for John Wesley and William Booth sets to provide spiritual depth. Add small biblical context where appropriate (DE, EN, RU).

---

## ⚡ #42: Add the feature to log in .. so to syncronise your data across diffenten plattforms (website... mobile data) [prio: 2] 🏁 [Release 2]
---
**Status / Description:**
Its important to make this feature "optional" so people can choos to only store it localy

---

## ⚡ ✨ #33: Add a better way to store / handle data [enhancement, prio: 2] 🏁 [Release 2]
---
**Status / Description:**
Architectural Shift: Replace SharedPreferences with a database (sqflite). Goal: Efficiency. We must be able to filter by date range at the query level to avoid loading thousands of entries into RAM. Essential for long-term performance.

---

## ⚡ ✨ #3: Add the posibility to Push message [prio: 2, feature] 🏁 [Release 2]
---
**Status / Description:**
Daily reminders are key for engagement. Implement local notifications that respect user-defined timespans.

---

## ⚡ ✨ #57: UI Optimization: Landscape Mode & Widget Refactoring [enhancement, prio: 2] 🏁 [Release 2]
---
**Status / Description:**
Improve ergonomics in landscape mode. Architectural Task: Decouple ChartControlWidget into two standalone widgets: 1. TimeSelectionBar (to be placed under charts in landscape) 2. QuestionFilterPanel (modular placement). Goal: Better use of horizontal space and clearer hierarchy.

---

## ☕ ✨ #35: Add Gamification  [enhancement, prio: 3] 🏁 [Release 2]
---
**Status / Description:**
* Streak (finished in your given time)
* Medals / Achivements

---

## ☕ #37: Rework question Data [prio: 3] 🏁 [Release 2]
---
**Status / Description:**
Eg. Question 1 for salvation Army Chemnitz contains dummy data for information this need to be fixed.

---

## ☕ ✨ #41: Add the posibility that the userr can create there own questionsets [enhancement, prio: 3] 🏁 [Release 2]
---
**Status / Description:**
_Keine Beschreibung_

---

## ☕ ✨ #17: Add more Sets of selfexaminations Questions [enhancement, prio: 3] 🏁 [Release 2]
---
**Status / Description:**
For example
https://www.disciplebuilding.org/2022/07/28/30-questions-for-reflection/
https://www.larissamarks.com/blog/6-simple-questions-for-self-reflection-plus-a-free-worksheet-for-you
https://outreachmagazine.com/features/discipleship/63117-12-self-reflective-questions-to-ask-ourselves-every-month.html


---

## ⚡ #45: Add a possibilty to add a accountable party [prio: 2] 🏁 [Release 3]
---
**Status / Description:**
As a user, I want to invite an Accountability Partner to view my self-assessment data so that I stay motivated and honest. I need to be able to control exactly what information is shared to protect my privacy.

**Proposed Terminology:**

- [ ] - Role: Accountability Partner / Guardian
- [ ] - Settings: Transparency Levels

**Requirements / Scope:**

- [ ] - Invitation System: Invite a partner via email or link.
  - [ ] - Visibility Toggles (The "Privacy Filter"):
  - [ ] - Aggregate Data: Show only averages and trends (High-level).
  - [ ] - Raw Scores: Show individual answers/values for each question.
  - [ ] - Notes/Comments: Optional toggle to show or hide personal reflections.
- [ ] - Status Indicators: Partner can see if an assessment was completed (Streaks) or missed.

**Acceptance Criteria:**

- [ ] User can revoke access at any time.
- [ ] The partner view must strictly respect the selected "Visibility Level".
- [ ] Notes must be hidden by default unless explicitly shared.

---

## ☕ #43: Add a feature to "report" (only) average data to a server from salvation army... [question, prio: 3] 🏁 [Release 3]
---
**Status / Description:**
This would help to check the development eg. from the whole salvation army germany.. or / also from some salvation army korps.. but then you need a way to "group" data and also make shure that only anoymized data is transmitted

---

