# Self Examination App

The **Self Examination App** is a Flutter application that allows users to conduct self-assessments regularly based on a set of questions. The results are graphically presented in various charts, enabling users to track their personal progress. It follows the tradition of William Booth and John Wesley, who regularly asked themselves such self-examination questions. The app currently includes three different sets of self-examination questions:

- Set 1 based on the Ten Commandments
- Set 2 self-examination questions by William Booth
- Set 3 self-examination questions by John Wesley

## Table of Contents

- [Technologies](#technologies)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Features](#features)
- [Localization](#localization)
- [Authors](#authors)
- [License](#license)

## Technologies

- Flutter
- Dart

## Installation

1. **Install Flutter:**
    - [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)

2. **Clone the Project:**
   ```bash
   git clone https://github.com/Paradoxianer/self_examintion.git
   cd self-examination-app

3. **Install Dependencies:**
   ```bash
    flutter pub get

4. **Run the Application:**
    ```bash
   flutter run

## Project Structure
   - localizations/: Contains files for localization. 
     - models/: Contains all important models (AssessmentEntry, AssessmentData, Question, and SelfAssessmentResult). 
     - screens/: Contains Flutter widgets for various screens. 
     - utils/: Contains utility functions. 
     - widgets/: Contains custom widgets.

## Features
Self-assessment: Users can perform self-assessments based on various self-examination questions.
The results are stored locally.
Personal development can be visualized in various charts.
Localization: The application supports multiple languages.

## Localization
    The app supports various languages. Currently supported languages:
        English (en)
        German (de)
        Spanish (es)
        Korean (ko)
        Lithuanian (lt)
        Polish (pl)
    Language localization is done in the lib/localizations/ folder.

## Authors
Matthias Lindner (@Paradoxianer)

## License
    This project is licensed under the MIT License. See the LICENSE file for more information.
