import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/models/question.dart';

import 'app_localizations.dart';

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get greetings => 'Willkommen zum Selbstprüfungs-Tool';

  @override
  String get start => 'Starten';

  @override
  String get results => 'Ergebnisse';

  @override
  String get settings => 'Einstellungen';

  @override
  String get examinTitle => 'Selbst-Prüfung';

  @override
  String get noteHint => 'Notizen hinzufügen..';

  @override
  String get pleasAnswer => 'Bitte beantworten sie alle Fragen.';

  @override
  String get commit => 'Fertig';

  @override
  String get saved => 'Daten gespeichert';

  @override
  String get chartTitle => 'Entwicklungsdiagramm';

  @override
  String get noHistory =>
      'Keine Daten von vergangenen Selbstprüfungfragen gefunden. Bitte wähle ein anderes Fragenset aus oder füllle die Fragen aus.';

  @override
  String get warningTitle => 'Warnung';

  @override
  String warningDel(String autor, Object author) {
    return 'Alle gespeicherten Fortschritte für $autor werden gelöscht und für immer verloren gehen. Möchten Sie fortfahren?';
  }

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get chooseQuestionSet => 'Fragenset wählen';

  @override
  String get delete => 'Daten löschen';

  @override
  String get notification => 'Erinnere mich daran';

  @override
  String get notificationFrequency => 'Häufigkeit';

  @override
  String get daily => 'täglich';

  @override
  String get weekly => 'wöchentlich';

  @override
  String get monthly => 'monatlich';

  @override
  String get datasecurityDialog => 'DSGVO Dialog';

  @override
  String get dsgvoNo => 'Zustimmung verweigert';

  @override
  String get dsgvoNoInfo =>
      'Die App kann leider nur funktionieren, wenn Sie zustimmen.';

  @override
  String get ok => 'ok';

  @override
  String get cancel => 'cancel';

  @override
  String get dsgvoTitle => 'Datenschutz und Zustimmung';

  @override
  String get dsgvo1 =>
      'Um Ihre persönliche geistliche Entwicklung zu verfolgen, speichern wir Ihre Antworten auf die gestellten Fragen. Diese Daten werden anonymisiert und lokal auf Ihrem Gerät gespeichert.';

  @override
  String get dsgvo2 =>
      'Bitte beachten Sie, dass Personen, die Zugriff auf Ihr Gerät und die App haben, möglicherweise auf diese Daten zugreifen können.';

  @override
  String get dsgvo3 =>
      'Indem Sie unten auf \"Zustimmen\" klicken, erklären Sie sich damit einverstanden, dass Ihre Daten wie oben beschrieben gespeichert werden. Wenn Sie nicht zustimmen, werden keine Daten erfasst, aber die App kann auch nicht funktionieren.';

  @override
  String get dsgvoOK => 'Zustimmen';

  @override
  String get dsgvoCancel => 'Widersprechen';

  @override
  String get dsgvoYes => 'Zustimmung erteilt';

  @override
  String get close => 'Schließen';

  @override
  String get total => 'Gesamt';

  @override
  String get compareChart => 'Vergleichsdiagramm';

  @override
  String get timeChart => 'Timediagram';

  List<String> get rating => ["Sehr gut", "Guter weg","nicht so gut","dringen dran arbeiten"];


  List<String> get answers => ["Gar nicht","Wenig", "Meistens","Voll und ganz"];

  List<String> get frequenze => ["täglich","wöchentlich","monatlich","jährlich"];



  Map<String, SelfAssessmentQuestionSet> get questionMap {
    Map<String, SelfAssessmentQuestionSet> _questionMap = {
      "Salvation Army Chemnitz": SelfAssessmentQuestionSet(
        authorName: "Heilsarmee Chemnitz",
        description: "Selbstprüfungsfragen entwickelt von der Heilsarmee Chemnitz basierend auf den zehn Geboten.",
        questions: [
          Question(
              text: "Inwieweit vermeide ich es, andere Dinge / Sachen neben dem einen wahren Gott zu setzen?",
              description:"Du sollst keine anderen Götter haben neben mir!  (2. Mose 2, 1-6)",
              tips: "Les mal die Bibel z.b. unter [www.bibelserver.com](https://bibelserver.com/)" ),
          Question(
              text: "Wie konsequent vermeide ich es, mir ein Bild von Gott zu machen oder anzufertigen?",
              description: "Du sollst dir kein Gottesbild anfertigen! (2. Mose 2, 4)"),
          Question(
              text: "Wie sehr habe ich es vermieden Gottes Namen bedenkenlos zu gebrauchen?",
              description:
              "Du sollst den Namen des HERRN, deines Gottes, nicht mißbrauchen! (2. Mose  2, 7)"),
          Question(
              text: "Nehme ich mir einmal aller sechs Tage einen Tag Auszeit, um Gott zu ehren?",
              description:
              "Aber der siebte Tag ist ein Feiertag zu Ehren des HERRN, deines Gottes! (2. Mose 2, 8-11)"),
          Question(
              text: "Inwiefern ehre ich meine Eltern und zeige ihnen Respekt?",
              description: "Ehre deinen Vater und deine Mutter! (2. Mose 2, 12)"),
          Question(
              text: "Wie konsequent vermeide ich es andere Menschen in Gedanken mit Worten oder gar mit Taten Schaden zu zu fügen?",
              description:
              "Du sollst nicht töten! (2. Mose 2, 13)"),
          Question(
              text: "Inwieweit halte ich mich von Ehebruch fern und bewahre die Ehe als heilige Institution?",
              description:
              "Du sollst nicht ehebrechen! (2. Mose 2, 14)"),
          Question(
              text: "Wie zuverlässig lasse ich die Finger von fremdem Eigentum und praktiziere Ehrlichkeit?" ,
              description: "Du sollst nicht stehlen! (2. Mose 2, 15)"),
          Question(
              text: "In welchem Maße vermeide ich es, falsches Dinge über andere Menschen zu verbreiten oder zu lästern?",
              description: "Du sollst kein falsches Zeugnis ablegen gegen deinen Nächsten! (2. Mose 2, 16)"),
          Question(
              text: "Wie sehr vermeide ich es neidisch zu sein auf das was anderen Menschen gehört bzw. wie andere Menschen leben?",
              description: "Du sollst nicht begehren deines Nächsten Haus! Du sollst nicht begehren deines Nächsten Weib, noch seinen Knecht, noch seine Magd, noch sein Rind, noch seinen Esel, noch irgend etwas, was deinem Nächsten gehört. (2. Mose 2, 16)")
        ],
      ),
      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description: "Selbstverleugnungsfragen von William Booth",
        questions: [
          Question(
              text:
                  "Bin ich einer Gewohnheitssünde schuldig? Sündige ich vorsätzlich oder nachlässig in Gedanken, Worten oder Werken, wohl wissend, dass ich Unrecht tue?",
              isPositive: true),
          Question(
              text:
                  "Habe ich mein körperliches Verlangen so unter Kontrolle, dass ich mich nicht schuldig mache? Lasse ich irgendeiner Neigung freien Lauf, die meine Heiligung, mein Wachstum in Erkenntnis, meinen Gehorsam und meine Brauchbarkeit beeinträchtigt?"),
          Question(
              text:
                  "Sind alle meine Gedanken und Gefühle so beschaffen, dass ich mich nicht zu schämen brauche, wenn sie vor Gott offenbar werden?"),
          Question(
              text:
                  "Verleitet mich weltlicher Einfluss dazu, Dinge zu tun oder zu sagen, die nicht zu Christus passen?",
              isPositive: true),
          Question(
              text:
                  "Verleitet mich meine Veranlagung, etwas zu fühlen, zu tun oder zu sagen, von dem ich hinterher feststelle, dass es im Gegensatz zu der Liebe steht, die ich immer für meine Mitmenschen haben sollte?",
              isPositive: true),
          Question(
              text:
                  "Tue ich alles, was in meiner Macht steht, damit Sünder gerettet werden? Kümmert es mich, dass sie in Gefahr sind? Bete ich für sie, kämpfe ich für ihr Heil, als ob sie meine eigenen Kinder wären?"),
          Question(
              text:
                  "Erfülle ich meine Gelübde, die ich vor Gott einmal im Akt der Hingabe oder an der Bußbank gemacht habe?"),
          Question(
            text: "Steht mein Vorbild im Einklang mit meinem Wort?",
          ),
          Question(
              text: "Bin ich im Wesen und Auftreten stolz oder arrogant?",
              isPositive: true),
          Question(
              text:
                  "Richte ich mich nach den Sitten und Gebräuchen der Welt oder habe ich den Mut, gegen den Strom zu schwimmen?"),
          Question(
              text:
                  "Stehe ich in Gefahr, mich hinreißen zu lassen von dem weltlichen Verlangen, reich oder bewundert zu sein?",
              isPositive: true),
          // Weitere Fragen von William Booth hier hinzufügen
        ],
      ),
      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description:
        "John Wesley, Gründer der Methodisten überprüfte sich täglich rigoros selbst, indem er sich folgenden 22 Fragen stellte:",
        questions: [
          Question(
              text:
              "Erwecke ich bewusst oder unbewusst den Eindruck, dass ich besser bin, als ich in Wirklichkeit bin? Mit anderen Worten: Bin ich ein Heuchler?",
              isPositive: true),
          Question(
              text:
              "Bin ich in all meinen Handlungen und Worten ehrlich, oder übertreibe ich?",
              isPositive: true),
          Question(
              text:
              "Gebe ich vertraulich an andere weiter, was mir im Vertrauen gesagt wurde?",
              isPositive: true),
          Question(text: "Kann man mir vertrauen?"),
          Question(
              text:
              "Bin ich ein Sklave meiner Kleidung, Freunde, Arbeit oder Gewohnheiten?",
              isPositive: true),
          Question(
              text:
              "Bin ich selbstbewusst, selbstmitleidig oder rechtfertige ich mich selbst?",
              isPositive: true),
          Question(text: "Hat die Bibel heute in mir gelebt?"),
          Question(
              text: "Gebe ich der Bibel jeden Tag Zeit, zu mir zu sprechen?"),
          Question(text: "Genieße ich das Gebet?"),
          Question(
              text:
              "Wann habe ich zuletzt mit jemandem über meinen Glauben gesprochen?"),
          Question(text: "Bete ich über das Geld, das ich ausgebe?"),
          Question(
              text: "Gehe ich rechtzeitig zu Bett und stehe rechtzeitig auf?"),
          Question(text: "Widersetze ich mich Gott in irgendetwas?",
              isPositive: true),
          Question(
              text:
              "Bestehe ich darauf, etwas zu tun, das mein Gewissen beunruhigt?",
              isPositive: true),
          Question(text: "Bin ich in einem Teil meines Lebens unterlegen?",
              isPositive: true),
          Question(
              text:
              "Bin ich eifersüchtig, unrein, kritisch, reizbar, empfindlich oder misstrauisch?",
              isPositive: true),
          Question(text: "Wie verbringe ich meine Freizeit?",
              isPositive: true),
          Question(text: "Bin ich stolz?",
              isPositive: true),
          Question(
              text:
              "Dank ich Gott, dass ich nicht wie andere Menschen bin, besonders wie die Pharisäer, die den Zöllner verachteten?",
              isPositive: true),
          Question(
              text:
              "Gibt es jemanden, den ich fürchte, nicht leiden kann, den ich ablehne, kritisiere, gegen den ich Groll hege oder den ich ignoriere? Wenn ja, was unternehme ich dagegen?",
              isPositive: true),
          Question(text: "Murre oder beschwere ich mich ständig?",
              isPositive: true),
          Question(text: "Ist Christus für mich real?")
        ],
      ),
    };
    return _questionMap;
  }
}
