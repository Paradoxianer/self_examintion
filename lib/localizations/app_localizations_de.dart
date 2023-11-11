import 'package:self_examintion/data/self_assesment_questions.dart';
import 'package:self_examintion/models/question.dart';

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
  String get answer1 => 'Gar nicht';

  @override
  String get answer2 => 'Wenig';

  @override
  String get answer3 => 'Meistens';

  @override
  String get answer4 => 'Voll und ganz';

  @override
  String get w_description =>
      'Selbstverleugnungsfragen von William Booth die er sich jede Woche gestellt hat';

  @override
  String get w_1 =>
      'Bin ich einer Gewohnheitssünde schuldig? Sündige ich vorsätzlich oder nachlässig in Gedanken, Worten oder Werken, wohl wissend, dass ich Unrecht tue?';

  @override
  String get w_2 =>
      'Habe ich mein körperliches Verlangen so unter Kontrolle, dass ich mich nicht schuldig mache? Lasse ich irgendeiner Neigung freien Lauf, die meine Heiligung, mein Wachstum in Erkenntnis, meinen Gehorsam und meine Brauchbarkeit beeinträchtigt?';

  @override
  String get w_3 =>
      'Sind alle meine Gedanken und Gefühle so beschaffen, dass ich mich nicht zu schämen brauche, wenn sie vor Gott offenbar werden?';

  @override
  String get w_4 =>
      'Verleitet mich weltlicher Einfluss dazu, Dinge zu tun oder zu sagen, die nicht zu Christus passen?';

  @override
  String get w_5 =>
      'Verleitet mich meine Veranlagung, etwas zu fühlen, zu tun oder zu sagen, von dem ich hinterher feststelle, dass es im Gegensatz zu der Liebe steht, die ich immer für meine Mitmenschen haben sollte?';

  @override
  String get w_6 =>
      'Tue ich alles, was in meiner Macht steht, damit Sünder gerettet werden? Kümmert es mich, dass sie in Gefahr sind? Bete ich für sie, kämpfe ich für ihr Heil, als ob sie meine eigenen Kinder wären?';

  @override
  String get w_7 =>
      'Erfülle ich meine Gelübde, die ich vor Gott einmal im Akt der Hingabe oder an der Bußbank gemacht habe?';

  @override
  String get w_8 => 'Steht mein Vorbild im Einklang mit meinem Wort?';

  @override
  String get w_9 => 'Bin ich im Wesen und Auftreten stolz oder arrogant?';

  @override
  String get w_10 =>
      'Richte ich mich nach den Sitten und Gebräuchen der Welt oder habe ich den Mut, gegen den Strom zu schwimmen?';

  @override
  String get w_11 =>
      'Stehe ich in Gefahr, mich hinreißen zu lassen von dem weltlichen Verlangen, reich oder bewundert zu sein?';

  @override
  String get j_description => 'Selbstverleugnungsfragen von John Wesley';

  @override
  String get j_1 =>
      'Erwecke ich bewusst oder unbewusst den Eindruck, dass ich besser bin, als ich in Wirklichkeit bin? Mit anderen Worten: Bin ich ein Heuchler?';

  @override
  String get j_2 =>
      'Gebe ich vertraulich an andere weiter, was mir im Vertrauen gesagt wurde?';

  @override
  String get j_3 => 'Bin ich vertrauenswürdig?';

  @override
  String get j_4 =>
      'Bin ich ein Sklave meiner Kleidung, Freunde, Arbeit oder Gewohnheiten?';

  @override
  String get j_5 =>
      'Bin ich unsicher, voller Selbstmitleid oder selbstgerecht?';

  @override
  String get j_6 => 'Lebt die Bibel heute in mir?';

  @override
  String get j_7 => 'Gebe ich der Bibel jeden Tag Zeit, zu mir zu sprechen?';

  @override
  String get j_8 => 'Habe ich Freude am Gebet?';

  @override
  String get j_9 =>
      'Wann habe ich zuletzt mit jemandem über meinen Glauben gesprochen?';

  @override
  String get j_10 => 'Bete ich über das Geld, das ich ausgebe?';

  @override
  String get j_11 => 'Gehe ich rechtzeitig zu Bett und stehe rechtzeitig auf?';

  @override
  String get j_12 => 'Bin ich Gott bei etwas ungehorsam?';

  @override
  String get j_13 =>
      'Bestehe ich darauf, etwas zu tun, das mein Gewissen beunruhigt?';

  @override
  String get j_14 => 'War ich in einem Teil meines Lebens unterlegen?';

  @override
  String get j_15 =>
      'Bin ich eifersüchtig, unrein, kritisch, reizbar, empfindlich oder misstrauisch?';

  @override
  String get j_16 => 'Wie verbringe ich meine Freizeit?';

  @override
  String get j_17 => 'Bin ich stolz?';

  @override
  String get j_18 =>
      'Gibt es jemanden, vor dem ich mich fürchte, den ich nicht leiden kann, mit dem ich nichts zu tun haben will, den ich kritisiere, gegen den ich einen Groll hege oder den ich ignoriere? Wenn ja, was unternehme ich dagegen?';

  @override
  String get j_19 => 'Murre oder beschwere ich mich ständig?';

  @override
  String get j_20 => 'Ist Christus für mich real?';

  Map<String, SelfAssessmentQuestionSet> get questionMap {
    Map<String, SelfAssessmentQuestionSet> _questionMap = {
      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description: "Selbstverleugnungsfragen von William Booth",
        questions: [
          Question(
              text:
                  "Bin ich einer Gewohnheitssünde schuldig? Sündige ich vorsätzlich oder nachlässig in Gedanken, Worten oder Werken, wohl wissend, dass ich Unrecht tue?",
              isNegative: true),
          Question(
              text:
                  "Habe ich mein körperliches Verlangen so unter Kontrolle, dass ich mich nicht schuldig mache? Lasse ich irgendeiner Neigung freien Lauf, die meine Heiligung, mein Wachstum in Erkenntnis, meinen Gehorsam und meine Brauchbarkeit beeinträchtigt?"),
          Question(
              text:
                  "Sind alle meine Gedanken und Gefühle so beschaffen, dass ich mich nicht zu schämen brauche, wenn sie vor Gott offenbar werden?"),
          Question(
              text:
                  "Verleitet mich weltlicher Einfluss dazu, Dinge zu tun oder zu sagen, die nicht zu Christus passen?",
              isNegative: true),
          Question(
              text:
                  "Verleitet mich meine Veranlagung, etwas zu fühlen, zu tun oder zu sagen, von dem ich hinterher feststelle, dass es im Gegensatz zu der Liebe steht, die ich immer für meine Mitmenschen haben sollte?",
              isNegative: true),
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
              isNegative: true),
          Question(
              text:
                  "Richte ich mich nach den Sitten und Gebräuchen der Welt oder habe ich den Mut, gegen den Strom zu schwimmen?"),
          Question(
              text:
                  "Stehe ich in Gefahr, mich hinreißen zu lassen von dem weltlichen Verlangen, reich oder bewundert zu sein?",
              isNegative: true),
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
                  "Erwecke ich bewusst oder unbewusst den Eindruck, dass ich besser bin, als ich in Wirklichkeit bin? Mit anderen Worten: Bin ich ein Heuchler?"),
          Question(
              text:
                  "Bin ich in all meinen Handlungen und Worten ehrlich, oder übertreibe ich?"),
          Question(
              text:
                  "Gebe ich vertraulich an andere weiter, was mir im Vertrauen gesagt wurde?"),
          Question(text: "Kann man mir vertrauen?"),
          Question(
              text:
                  "Bin ich ein Sklave meiner Kleidung, Freunde, Arbeit oder Gewohnheiten?"),
          Question(
              text:
                  "Bin ich selbstbewusst, selbstmitleidig oder rechtfertige ich mich selbst?"),
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
          Question(text: "Widersetze ich mich Gott in irgendetwas?"),
          Question(
              text:
                  "Bestehe ich darauf, etwas zu tun, das mein Gewissen beunruhigt?"),
          Question(text: "Bin ich in einem Teil meines Lebens unterlegen?"),
          Question(
              text:
                  "Bin ich eifersüchtig, unrein, kritisch, reizbar, empfindlich oder misstrauisch?"),
          Question(text: "Wie verbringe ich meine Freizeit?"),
          Question(text: "Bin ich stolz?"),
          Question(
              text:
                  "Dank ich Gott, dass ich nicht wie andere Menschen bin, besonders wie die Pharisäer, die den Zöllner verachteten?"),
          Question(
              text:
                  "Gibt es jemanden, den ich fürchte, nicht leiden kann, den ich ablehne, kritisiere, gegen den ich Groll hege oder den ich ignoriere? Wenn ja, was unternehme ich dagegen?"),
          Question(text: "Murre oder beschwere ich mich ständig?"),
          Question(text: "Ist Christus für mich real?")
        ],
      )
    };
    return _questionMap;
  }
}
