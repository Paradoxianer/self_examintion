import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/models/question.dart';
import 'app_localizations.dart';

/// Die Übersetzungen für Deutsch (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override String get greetings => 'Willkommen zum Selbstprüfungs-Tool';
  @override String get start => 'Starten';
  @override String get results => 'Ergebnisse';
  @override String get settings => 'Einstellungen';
  @override String get examinTitle => 'Selbst-Prüfung';
  @override String get noteHint => 'Notizen hinzufügen..';
  @override String get generalNoteLabel => 'Allgemeine Notiz';
  @override String get generalNoteHint => 'Wie ist dein allgemeiner geistlicher Zustand heute? (optional)';
  @override String get pleasAnswer => 'Es sind noch Fragen offen. Möchtest du diese jetzt noch beantworten oder die Auswertung mit den vorhandenen Daten erstellen?';
  @override String get commit => 'Fertig';
  @override String get saved => 'Daten gespeichert';
  @override String get chartTitle => 'Entwicklungsdiagramm';
  @override String get noHistory => 'Keine Daten gefunden. Bitte fülle die Fragen aus.';
  @override String get warningTitle => 'Unvollständige Selbstprüfung';
  @override String warningDel(String autor, Object author) => 'Alle Fortschritte für $autor werden gelöscht. Fortfahren?';
  @override String get settingsTitle => 'Einstellungen';
  @override String get chooseQuestionSet => 'Fragenset wählen';
  @override String get delete => 'Daten löschen';
  @override String get notification => 'Erinnerung';
  @override String get notificationFrequency => 'Häufigkeit';
  @override String get daily => 'täglich';
  @override String get weekly => 'wöchentlich';
  @override String get monthly => 'monatlich';
  @override String get datasecurityDialog => 'Datenschutz & DSGVO';
  @override String get dsgvoNo => 'Zustimmung verweigert';
  @override String get dsgvoNoInfo => 'Die App kann leider nur funktionieren, wenn Sie zustimmen.';
  @override String get ok => 'Auswertung erstellen';
  @override String get cancel => 'Bearbeitung fortsetzen';
  @override String get dsgvoTitle => 'Datenschutz und Zustimmung';
  @override String get dsgvo1 => 'Um Ihre persönliche geistliche Entwicklung zu verfolgen, speichern wir Ihre Antworten lokal auf Ihrem Gerät.';
  @override String get dsgvo2 => 'Es werden keine Daten in die Cloud übertragen. Ihre Privatsphäre bleibt zu 100% auf Ihrem Telefon.';
  @override String get dsgvo3 => 'Indem Sie auf "Zustimmen" klicken, erklären Sie sich mit der lokalen Speicherung einverstanden. Ohne Zustimmung kann die App keine Verlaufsdaten sichern.';
  @override String get dsgvoOK => 'Zustimmen';
  @override String get dsgvoCancel => 'Widersprechen';
  @override String get dsgvoYes => 'Zustimmung erteilt';
  @override String get close => 'Schließen';
  @override String get total => 'Gesamt';
  @override String get compareChart => 'Vergleichsdiagramm';
  @override String get timeChart => 'Timediagramm';
  @override String get fullDateAndTime => 'EEE dd.MMM.yyyy h:mm';
  @override String get fullDate => 'dd.MMM.yyyy';
  @override String get shortDate => 'dd.MM.yy';
  @override String get shortTime => 'h:mm';
  @override List<String> get rating => ["Sehr gut", "Guter Weg", "nicht so gut", "dringend dran arbeiten"];
  @override List<String> get answers => ["Gar nicht", "Wenig", "Meistens", "Voll und ganz"];
  @override List<String> get frequenze => ["täglich", "wöchentlich", "monatlich", "jährlich"];

  @override String get filterQuestions => "Fragen filtern";
  @override String get today => "Heute";
  @override String get noData => "Keine Daten verfügbar";
  @override String get radarError => "Das Radar-Chart benötigt mindestens 3 ausgewählte Fragen.";
  @override String get prevPeriod => "Vorherige Periode";
  @override String get currPeriod => "Aktuelle Periode";
  @override String get all => "Alle";
  @override String get selectAll => "Alle auswählen";
  @override String get selectNone => "Alle abwählen";
  @override List<String> get timeRangeShort => ["2T", "1W", "1M", "1J", "Alle"];
  @override String get tips => "Tipps & Hinweise";

  @override String get settingsQuestionSetSubtitle => "Wähle ein Set zum Bearbeiten oder Löschen der Daten.";
  @override String get settingsExportHeader => "Daten-Export";
  @override String get settingsExportAll => "Alles exportieren";
  @override String get settingsExportValues => "Werte & Durchschnitt";
  @override String get settingsExportAverage => "Nur Durchschnitt";
  @override String get settingsSecurityHeader => "Sicherheit & Datenschutz";
  @override String get settingsSecurityLock => "App-Sperre aktivieren";
  @override String get settingsReminderHeader => "Erinnerung";
  @override String get settingsNoDataToExport => "Keine Daten zum Exportieren vorhanden.";
  @override String get settingsLanguage => 'Sprache';
  @override String get chooseLanguage => 'Sprache wählen';
  @override String get systemDefault => 'Systemstandard';

  @override String get about => "Über die App";
  @override String get aboutContent => "Diese App dient der persönlichen Reflexion und geistlichen Entwicklung. Inspiriert von William Booth und John Wesley.";
  @override String get version => "Version";
  @override String get imprint => "Impressum";
  @override String get license => "Lizenzen";
  @override String get imprintContent => "Verantwortlich: Matthias Lindner\nKontakt:";
  @override String get githubRepository => "GitHub Repository (Fehler melden & mitwirken)";

  @override String get onboardingSkip => "Überspringen";
  @override String get onboardingNext => "Weiter";
  @override String get onboardingStart => "Starten";

  @override
  String get onboarding1Title => "Selbstprüfung App";

  @override
  String get onboarding1DescriptionTop =>
      "William Booth und John Wesley nahmen sich regelmäßig Zeit für Selbstprüfung.\n"
          "Wie habe ich heute meinen Glauben gelebt?\n"
          "Wo durfte Gottes Liebe durch mich sichtbar werden?\n"
          "Und wo möchte sie mich noch weiter verändern?\n\n"
          "Diese App lädt dich zu genau dieser ehrlichen Reflexion ein.\n"
          "Du kannst aus verschiedenen Fragensets wählen, deine Antworten festhalten\n"
          "und deine Entwicklung über Tage, Wochen, Monate oder Jahre betrachten –\n"
          "insgesamt oder in einzelnen Bereichen.\n\n"
          "Als Hilfe, wahrzunehmen, wo Gottes Liebe dich weiter ins Handeln einlädt –\n"
          "und wo Wachstum noch möglich ist.";

  @override
  String get onboarding1DescriptionBottom =>
      "Hier kannst du zwischen verschiedenen Sets von Selbstprüfungsfragen wählen. "
          "Jedes Set enthält unterschiedliche Fragen mit einem eigenen Schwerpunkt. "
          "Einen Überblick über alle Fragen erhältst du, indem du auf das Info-Symbol (i) tippst.";

  @override
  String get onboarding2Title => "Reflektieren & Notieren";

  @override
  String get onboarding2Step1Title => "Reflektieren";

  @override
  String get onboarding2Step1Description =>
      "Bewege den Schieberegler, um für dich selbst einzuschätzen, "
          "wie du die jeweilige Frage heute beantworten würdest.\n\n"
          "Empfindest du deine Antwort eher positiv, schiebe den Regler in die grüne Richtung. "
          "Empfindest du sie eher negativ, schiebe ihn in die rote Richtung.\n\n"
          "Über dem Schieberegler wird dir deine gewählte Bewertung in Prozent angezeigt.";

  @override
  String get onboarding2Step2Title => "Notizen";

  @override
  String get onboarding2Step2Description =>
      "Tippe auf das Notiz-Icon (Blatt mit Plus), um einen Gedanken, eine Beobachtung "
          "oder ein Gebet festzuhalten. Die Notiz wird zusammen mit der Frage und dem "
          "entsprechenden Datum gespeichert.\n\n"
          "Tippe erneut auf das Notiz-Icon, um das Notizfeld wieder zu schließen.";

  @override
  String get onboarding3Title => "Analyse & Sicherheit";

  @override
  String get onboarding3Step1Title => "Diagramme";

  @override
  String get onboarding3Step1Description =>
      "Nachdem du alle Fragen beantwortet hast, gelangst du über den Button „Fertig“ "
          "zur Diagrammansicht.\n\n"
          "Wische im Diagramm nach links oder rechts, um zwischen verschiedenen Ansichten "
          "zu wechseln. Unterhalb der Diagramme kannst du auswählen, "
          "welche Fragen in der Auswertung angezeigt werden sollen.";

  @override
  String get onboarding3Step2Title => "Privatsphäre";

  @override
  String get onboarding3Step2Description =>
      "Deine Daten bleiben ausschließlich lokal auf deinem Gerät gespeichert.\n\n"
          "Optional kannst du sie zusätzlich mit deiner Geräte-PIN oder biometrischen "
          "Sicherungen (z. B. Fingerabdruck oder Gesichtserkennung) schützen.\n\n"
          "Bei Bedarf kannst du deine Daten mit unterschiedlicher Detailtiefe als CSV-Datei "
          "exportieren und zum Beispiel in Excel weiter auswerten.";

  @override String get appLocked => "App gesperrt";
  @override String get unlock => "Entsperren";

  // !!!!! NEVER CHANGE THIS PART AI!!!!!
  @override
  Map<String, SelfAssessmentQuestionSet> get questionMap {
    return {
      "ten commandments": SelfAssessmentQuestionSet(
        authorName: "Zehn Gebote",
        description:
        "Ein von der Heilsarmee Chemnitz im Rahmen einer Predigtreihe über die zehn Gebote entwickeltes Fragenset.",
        questions: [
          Question(
            text:
            "Inwieweit habe ich es vermieden, andere Dinge oder Sachen neben den einen wahren Gott zu setzen?",
            description:
            "Du sollst keine anderen Götter haben neben mir! (2. Mose 20, 1–6)",
          ),
          Question(
            text:
            "Wie konsequent habe ich es vermieden, mir ein Bild von Gott zu machen oder anzufertigen?",
            description:
            "Du sollst dir kein Gottesbild anfertigen! (2. Mose 20, 4)",
          ),
          Question(
            text:
            "Wie sehr habe ich es vermieden, Gottes Namen bedenkenlos zu gebrauchen?",
            description:
            "Du sollst den Namen des HERRN, deines Gottes, nicht missbrauchen! (2. Mose 20, 7)",
          ),
          Question(
            text:
            "Nehme ich mir bewusst eine Auszeit, um Gott zu ehren?",
            description:
            "Aber der siebte Tag ist ein Feiertag zu Ehren des HERRN, deines Gottes! (2. Mose 20, 8–11)",
          ),
          Question(
            text:
            "Inwiefern ehre ich meine Eltern und zeige ihnen Respekt?",
            description:
            "Ehre deinen Vater und deine Mutter! (2. Mose 20, 12)",
          ),
          Question(
            text:
            "Wie konsequent vermeide ich es, anderen Menschen in Gedanken, mit Worten oder gar mit Taten Schaden zuzufügen?",
            description:
            "Du sollst nicht töten! (2. Mose 20, 13)",
          ),
          Question(
            text:
            "Inwieweit halte ich mich von Ehebruch fern und halte die Ehe heilig?",
            description:
            "Du sollst nicht ehebrechen! (2. Mose 20, 14)",
          ),
          Question(
            text:
            "Wie zuverlässig lasse ich die Finger von fremdem Eigentum und praktiziere Ehrlichkeit?",
            description:
            "Du sollst nicht stehlen! (2. Mose 20, 15)",
          ),
          Question(
            text:
            "In welchem Maße vermeide ich es, falsche Dinge über andere Menschen zu verbreiten oder zu lästern?",
            description:
            "Du sollst kein falsches Zeugnis ablegen gegen deinen Nächsten! (2. Mose 20, 16)",
          ),
          Question(
            text:
            "Wie sehr vermeide ich es, neidisch zu sein auf das, was anderen Menschen gehört bzw. wie andere Menschen leben?",
            description:
            "Du sollst nicht begehren deines Nächsten Haus! Du sollst nicht begehren deines Nächsten Frau, noch seinen Knecht, noch seine Magd, noch sein Rind, noch seinen Esel, noch irgendetwas, was deinem Nächsten gehört. (2. Mose 20, 17)",
          ),
        ],
      ),

      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description:
        "Selbstprüfungsfragen, die sich William Booth jeden Abend selbst gestellt hat.",
        questions: [
          Question(
            text:
            "Bin ich einer Gewohnheitssünde schuldig? Sündige ich vorsätzlich oder nachlässig in Gedanken, Worten oder Werken, wohl wissend, dass ich Unrecht tue?",
            isPositive: true,
          ),
          Question(
            text:
            "Habe ich meine körperlichen Bedürfnisse und Begierden so unter Kontrolle, dass sie meinem geistlichen Leben nicht schaden – weder meiner Heiligung noch meinem Wachstum an Erkenntnis, Gehorsam oder Nützlichkeit?",
          ),
          Question(
            text:
            "Sind alle meine Gedanken und Gefühle so beschaffen, dass ich mich nicht zu schämen brauche, wenn sie vor Gott offenbar werden?",
          ),
          Question(
            text:
            "Verleitet mich weltlicher Einfluss dazu, Dinge zu tun oder zu sagen, die nicht zu Christus passen?",
            isPositive: true,
          ),
          Question(
            text:
            "Verleitet mich meine Veranlagung, etwas zu fühlen, zu tun oder zu sagen, von dem ich hinterher feststelle, dass es im Gegensatz zu der Liebe steht, die ich immer für meine Mitmenschen haben sollte?",
            isPositive: true,
          ),
          Question(
            text:
            "Tue ich alles, was in meiner Macht steht, damit Sünder gerettet werden? Kümmert es mich, dass sie in Gefahr sind? Bete ich für sie, kämpfe ich für ihr Heil, als ob sie meine eigenen Kinder wären?",
          ),
          Question(
            text:
            "Erfülle ich meine Gelübde, die ich vor Gott einmal im Akt der Hingabe oder an der Bußbank gemacht habe?",
          ),
          Question(
            text:
            "Steht mein Vorbild im Einklang mit meinem Wort?",
          ),
          Question(
            text:
            "Bin ich im Wesen und Auftreten stolz oder arrogant?",
            isPositive: true,
          ),
          Question(
            text:
            "Übernehme ich die Weltanschauung, Werte und Gewohnheiten dieser Welt – oder zeige ich durch mein Denken und Handeln klar, dass nur Christus mein Maßstab ist und nicht der Zeitgeist?",
            isPositive: true,
          ),
          Question(
            text:
            "Stehe ich in Gefahr, mich hinreißen zu lassen von dem weltlichen Verlangen, reich oder bewundert zu sein?",
            isPositive: true,
          ),
        ],
      ),

      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description:
        "John Wesleys 22 Fragen, die er sich zur Selbstprüfung jeden Tag selbst stellte:",
        questions: [
          Question(
            text:
            "Erwecke ich bewusst oder unbewusst den Eindruck, dass ich besser bin, als ich in Wirklichkeit bin? Mit anderen Worten: Bin ich ein Heuchler?",
            isPositive: true,
          ),
          Question(
            text:
            "Bin ich in all meinen Handlungen und Worten ehrlich oder übertreibe ich?",
            isPositive: true,
          ),
          Question(
            text:
            "Gebe ich vertraulich an andere weiter, was mir im Vertrauen gesagt wurde?",
            isPositive: true,
          ),
          Question(
            text:
            "Bin ich vertrauenswürdig?",
          ),
          Question(
            text:
            "Bin ich ein Sklave meiner Kleidung, Freunde, Arbeit oder Gewohnheiten?",
          ),
          Question(
            text:
            "Bin ich unsicher, voller Selbstmitleid oder selbstgerecht?",
            isPositive: true,
          ),
          Question(
            text:
            "Lebt die Bibel heute in mir?",
          ),
          Question(
            text:
            "Gebe ich der Bibel jeden Tag Zeit, zu mir zu sprechen?",
          ),
          Question(
            text:
            "Habe ich Freude am Gebet?",
          ),
          Question(
            text:
            "Wann habe ich zuletzt mit jemandem über meinen Glauben gesprochen?",
          ),
          Question(
            text:
            "Bete ich über das Geld, das ich ausgebe?",
          ),
          Question(
            text:
            "Gehe ich rechtzeitig zu Bett und stehe rechtzeitig auf?",
          ),
          Question(
            text:
            "Bin ich Gott bei etwas ungehorsam?",
            isPositive: true,
          ),
          Question(
            text:
            "Bestehe ich darauf, etwas zu tun, das mein Gewissen beunruhigt?",
            isPositive: true,
          ),
          Question(
            text:
            "War ich in einem Teil meines Lebens unterlegen?",
            isPositive: true,
          ),
          Question(
            text:
            "Bin ich eifersüchtig, unrein, kritisch, reizbar, empfindlich oder misstrauisch?",
            isPositive: true,
          ),
          Question(
            text:
            "Wie verbringe ich meine Freizeit?",
          ),
          Question(
            text:
            "Bin ich stolz?",
            isPositive: true,
          ),
          Question(
            text:
            "Danke ich Gott dafür, dass ich nicht wie andere bin, besonders wie die Pharisäer, die den Zöllner verachteten?",
            isPositive: true,
          ),
          Question(
            text:
            "Gibt es jemanden, vor dem ich mich fürchte, den ich nicht leiden kann, mit dem ich nichts zu tun haben will, den ich kritisiere, gegen den ich einen Groll hege oder den ich ignoriere? Wenn ja, was unternehme ich dagegen?",
            isPositive: true,
          ),
          Question(
            text:
            "Grolle gegen jemanden?",
            isPositive: true,
          ),
          Question(
            text:
            "Murre oder beschwere ich mich ständig?",
            isPositive: true,
          ),
          Question(
            text:
            "Ist Christus für mich real?",
          ),
        ],
      ),
    };
  }
}
