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
  @override String get pleasAnswer => 'Bitte beantworten sie alle Fragen.';
  @override String get commit => 'Fertig';
  @override String get saved => 'Daten gespeichert';
  @override String get chartTitle => 'Entwicklungsdiagramm';
  @override String get noHistory => 'Keine Daten gefunden. Bitte füllle die Fragen aus.';
  @override String get warningTitle => 'Warnung';
  @override String warningDel(String autor, Object author) => 'Alle Fortschritte für $autor werden gelöscht. Fortfahren?';
  @override String get settingsTitle => 'Einstellungen';
  @override String get chooseQuestionSet => 'Fragenset wählen';
  @override String get delete => 'Daten löschen';
  @override String get notification => 'Erinnere mich daran';
  @override String get notificationFrequency => 'Häufigkeit';
  @override String get daily => 'täglich';
  @override String get weekly => 'wöchentlich';
  @override String get monthly => 'monatlich';
  @override String get datasecurityDialog => 'Datenschutz & DSGVO';
  @override String get dsgvoNo => 'Zustimmung verweigert';
  @override String get dsgvoNoInfo => 'Die App kann leider nur funktionieren, wenn Sie zustimmen.';
  @override String get ok => 'OK';
  @override String get cancel => 'Abbrechen';
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
  
  @override String get onboarding1Title => "Geistliche Inventur";
  @override String get onboarding1DescriptionTop => "Diese App hilft dir, deinen geistlichen Zustand ehrlich vor Gott zu prüfen. Sie ist ein Werkzeug für dein persönliches Wachstum und tägliche Reflexion.";
  @override String get onboarding1DescriptionBottom => "Hier kannst du zwischen verschiedenen Sets an Selbstprüfungsfragen wählen, die dich heute beschäftigen.";
  
  @override String get onboarding2Title => "Prüfen & Notieren";
  @override String get onboarding2Step1Title => "Bewertung";
  @override String get onboarding2Step1Description => "Bewege den Schieberegler, um zu bewerten, wie du dich heute in diesem Punkt fühlst.";
  @override String get onboarding2Step2Title => "Notizen";
  @override String get onboarding2Step2Description => "Tippe auf das Notiz-Icon (Blatt mit Plus), um einen Gedanken oder ein Gebet festzuhalten.";
  
  @override String get onboarding3Title => "Analyse & Sicherheit";
  @override String get onboarding3Step1Title => "Diagramme";
  @override String get onboarding3Step1Description => "Wische im Diagramm nach links oder rechts, um zwischen verschiedenen Ansichten zu wechseln.";
  @override String get onboarding3Step2Title => "Privatsphäre";
  @override String get onboarding3Step2Description => "Deine Daten bleiben lokal auf deinem Gerät. Exportiere sie bei Bedarf als CSV für Excel.";

  @override
  Map<String, SelfAssessmentQuestionSet> get questionMap {
    return {
      "ten commandments": SelfAssessmentQuestionSet(
        authorName: "Zehn Gebote",
        description: "Fragen basierend auf den zehn Geboten.",
        questions: [
          Question(text: "Inwieweit vermeide ich es, andere Dinge neben Gott zu setzen?", description: "Du sollst keine anderen Götter haben!"),
          Question(text: "Wie konsequent vermeide ich Gottesbilder?", description: "Du sollst dir kein Gottesbild anfertigen!"),
          Question(text: "Gebrauche ich Gottes Namen mit Bedacht?", description: "Du sollst den Namen nicht mißbrauchen!"),
          Question(text: "Nehme ich mir Zeit für Gott?", description: "Der siebte Tag ist ein Feiertag!"),
          Question(text: "Ehre ich meine Eltern?", description: "Ehre deinen Vater und deine Mutter!"),
          Question(text: "Vermeide ich es anderen zu schaden?", description: "Du sollst nicht töten!"),
          Question(text: "Wahre ich die Ehe als heilig?", description: "Du sollst nicht ehebrechen!"),
          Question(text: "Bin ich ehrlich mit fremdem Eigentum?", description: "Du sollst nicht stehlen!"),
          Question(text: "Vermeide ich Lästereien?", description: "Du sollst kein falsches Zeugnis ablegen!"),
          Question(text: "Vermeide ich Neid?", description: "Du sollst nicht begehren deines Nächsten Haus!"),
        ],
      ),
      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description: "Selbstverleugnungsfragen von William Booth",
        questions: [
          Question(text: "Bin ich einer Gewohnheitssünde schuldig?", isPositive: true),
          Question(text: "Habe ich mein körperliches Verlangen unter Kontrolle?"),
          Question(text: "Sind meine Gedanken vor Gott rein?"),
          Question(text: "Verleitet mich weltlicher Einfluss zu Unrecht?", isPositive: true),
          Question(text: "Handle ich stets aus Liebe?"),
          Question(text: "Tue ich alles für die Rettung von Sündern?"),
          Question(text: "Erfülle ich meine Gelübde?"),
          Question(text: "Steht mein Vorbild im Einklang mit meinem Wort?"),
          Question(text: "Bin ich im Wesen und Auftreten stolz oder arrogant?", isPositive: true),
          Question(text: "Habe ich den Mut gegen den Strom zu schwimmen?"),
          Question(text: "Stehe ich in Gefahr reich sein zu wollen?", isPositive: true),
        ],
      ),
      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description: "John Wesleys 22 tägliche Fragen:",
        questions: [
          Question(text: "Bin ich ein Heuchler?", isPositive: true),
          Question(text: "Bin ich ehrlich oder übertreibe ich?", isPositive: true),
          Question(text: "Gebe ich Vertrauliches weiter?", isPositive: true),
          Question(text: "Kann man mir vertrauen?"),
          Question(text: "Bin ich ein Sklave meiner Gewohnheiten?", isPositive: true),
          Question(text: "Bin ich selbstmitleidig?", isPositive: true),
          Question(text: "Hat die Bibel heute in mir gelebt?"),
          Question(text: "Gebe ich der Bibel Zeit?"),
          Question(text: "Genieße ich das Gebet?"),
          Question(text: "Wann sprach ich zuletzt über meinen Glauben?"),
          Question(text: "Bete ich über mein Geld?"),
          Question(text: "Schlafe ich genug?"),
          Question(text: "Widersetze ich mich Gott?", isPositive: true),
          Question(text: "Bestehe ich auf Dingen die mein Gewissen beunruhigen?", isPositive: true),
          Question(text: "Bin ich in einem Teil unterlegen?", isPositive: true),
          Question(text: "Bin ich eifersüchtig oder reizbar?", isPositive: true),
          Question(text: "Wie verbringe ich meine Freizeit?", isPositive: true),
          Question(text: "Bin ich stolz?", isPositive: true),
          Question(text: "Dank ich Gott dass ich nicht wie andere bin?", isPositive: true),
          Question(text: "Groll ich gegen jemanden?", isPositive: true),
          Question(text: "Murre ich ständig?", isPositive: true),
          Question(text: "Ist Christus real für mich?"),
        ],
      ),
    };
  }
}
