

import '../models/question.dart';

class SelfAssessmentQuestionSet {
  final String authorName; // Name des Autors des Fragebogens
  final String description; // Beschreibung des Fragebogens
  final List<Question> questions; // Die Fragen im Fragebogen

  SelfAssessmentQuestionSet({
    required this.authorName,
    required this.description,
    required this.questions,
  });
}
class SelfAssessmentQuestions {

  static Map <String, SelfAssessmentQuestionSet> questionMap = {
    "William Booth": SelfAssessmentQuestionSet(
      authorName: "William Booth",
      description: "Selbstverleugnungsfragen von William Booth",
      questions: [
        Question(
            text: "Bin ich einer Gewohnheitssünde schuldig? Sündige ich vorsätzlich oder nachlässig in Gedanken, Worten oder Werken, wohl wissend, dass ich Unrecht tue?",
            isNegative: true),
        Question(
            text: "Habe ich mein körperliches Verlangen so unter Kontrolle, dass ich mich nicht schuldig mache? Lasse ich irgendeiner Neigung freien Lauf, die meine Heiligung, mein Wachstum in Erkenntnis, meinen Gehorsam und meine Brauchbarkeit beeinträchtigt?"),
        Question(
            text: "Sind alle meine Gedanken und Gefühle so beschaffen, dass ich mich nicht zu schämen brauche, wenn sie vor Gott offenbar werden?"),
        Question(
            text: "Verleitet mich weltlicher Einfluss dazu, Dinge zu tun oder zu sagen, die nicht zu Christus passen?",
            isNegative: true),
        Question(
            text: "Verleitet mich meine Veranlagung, etwas zu fühlen, zu tun oder zu sagen, von dem ich hinterher feststelle, dass es im Gegensatz zu der Liebe steht, die ich immer für meine Mitmenschen haben sollte?",
            isNegative: true),
        Question(
            text: "Tue ich alles, was in meiner Macht steht, damit Sünder gerettet werden? Kümmert es mich, dass sie in Gefahr sind? Bete ich für sie, kämpfe ich für ihr Heil, als ob sie meine eigenen Kinder wären?"),
        Question(
            text: "Erfülle ich meine Gelübde, die ich vor Gott einmal im Akt der Hingabe oder an der Bußbank gemacht habe?"),
        Question(text: "Bin ich im Wesen und Auftreten stolz oder arrogant?",
            isNegative: true),
        Question(
            text: "Richte ich mich nach den Sitten und Gebräuchen der Welt oder habe ich den Mut, gegen den Strom zu schwimmen?"),
        Question(
            text: "Stehe ich in Gefahr, mich hinreißen zu lassen von dem weltlichen Verlangen, reich oder bewundert zu sein?",
            isNegative: true),
        // Weitere Fragen von William Booth hier hinzufügen
      ],
    ),
    "John Wesley": SelfAssessmentQuestionSet(
      authorName: "John Wesley",
      description: "Selbstverleugnungsfragen von John Wesley",
      questions: [
        Question(
            text: "Erwecke ich bewusst oder unbewusst den Eindruck, dass ich besser bin, als ich in Wirklichkeit bin? Mit anderen Worten: Bin ich ein Heuchler?"),
        Question(
            text: "Gebe ich vertraulich an andere weiter, was mir im Vertrauen gesagt wurde?"),
        Question(text: "Bin ich vertrauenswürdig?"),
        Question(
            text: "Bin ich ein Sklave meiner Kleidung, Freunde, Arbeit oder Gewohnheiten?"),
        Question(
            text: "Bin ich unsicher, voller Selbstmitleid oder selbstgerecht?"),
        Question(text: "Lebte die Bibel heute in mir?"),
        Question(
            text: "Gebe ich der Bibel jeden Tag Zeit, zu mir zu sprechen?"),
        Question(text: "Habe ich Freude am Gebet?"),
        Question(
            text: "Wann habe ich zuletzt mit jemandem über meinen Glauben gesprochen?"),
        Question(text: "Bete ich über das Geld, das ich ausgebe?"),
        Question(
            text: "Gehe ich rechtzeitig zu Bett und stehe rechtzeitig auf?"),
        Question(text: "Bin ich Gott bei etwas ungehorsam?"),
        Question(
            text: "Bestehe ich darauf, etwas zu tun, das mein Gewissen beunruhigt?"),
        Question(text: "War ich in einem Teil meines Lebens unterlegen?"),
        Question(
            text: "Bin ich eifersüchtig, unrein, kritisch, reizbar, empfindlich oder misstrauisch?"),
        Question(text: "Wie verbringe ich meine Freizeit?"),
        Question(text: "Bin ich stolz?"),
        Question(
            text: "Gibt es jemanden, vor dem ich mich fürchte, den ich nicht leiden kann, mit dem ich nichts zu tun haben will, den ich kritisiere, gegen den ich einen Groll hege oder den ich ignoriere? Wenn ja, was unternehme ich dagegen?"),
        Question(text: "Murre oder beschwere ich mich ständig?"),
        Question(text: "Ist Christus für mich real?"),
      ],
    )
  };
}
/*
class SelfAssessmentQuestions {

  static List<SelfAssessmentQuestionSet> questionSets = [
    SelfAssessmentQuestionSet(
      authorName: "William Booth",
      description: "Selbstverleugnungsfragen von William Booth",
      questions: [
        Question(text: "Bin ich einer Gewohnheitssünde schuldig? Sündige ich vorsätzlich oder nachlässig in Gedanken, Worten oder Werken, wohl wissend, dass ich Unrecht tue?",isNegative: true),
        Question(text: "Habe ich mein körperliches Verlangen so unter Kontrolle, dass ich mich nicht schuldig mache? Lasse ich irgendeiner Neigung freien Lauf, die meine Heiligung, mein Wachstum in Erkenntnis, meinen Gehorsam und meine Brauchbarkeit beeinträchtigt?"),
        Question(text: "Sind alle meine Gedanken und Gefühle so beschaffen, dass ich mich nicht zu schämen brauche, wenn sie vor Gott offenbar werden?"),
        Question(text: "Verleitet mich weltlicher Einfluss dazu, Dinge zu tun oder zu sagen, die nicht zu Christus passen?",isNegative: true),
        Question(text: "Verleitet mich meine Veranlagung, etwas zu fühlen, zu tun oder zu sagen, von dem ich hinterher feststelle, dass es im Gegensatz zu der Liebe steht, die ich immer für meine Mitmenschen haben sollte?",isNegative: true),
        Question(text: "Tue ich alles, was in meiner Macht steht, damit Sünder gerettet werden? Kümmert es mich, dass sie in Gefahr sind? Bete ich für sie, kämpfe ich für ihr Heil, als ob sie meine eigenen Kinder wären?"),
        Question(text: "Erfülle ich meine Gelübde, die ich vor Gott einmal im Akt der Hingabe oder an der Bußbank gemacht habe?"),
        Question(text: "Bin ich im Wesen und Auftreten stolz oder arrogant?",isNegative: true),
        Question(text: "Richte ich mich nach den Sitten und Gebräuchen der Welt oder habe ich den Mut, gegen den Strom zu schwimmen?"),
        Question(text: "Stehe ich in Gefahr, mich hinreißen zu lassen von dem weltlichen Verlangen, reich oder bewundert zu sein?",isNegative: true),
        // Weitere Fragen von William Booth hier hinzufügen
      ],
    ),
    SelfAssessmentQuestionSet(
      authorName: "John Wesley",
      description: "Selbstverleugnungsfragen von John Wesley",
      questions: [
        Question(text: "Erwecke ich bewusst oder unbewusst den Eindruck, dass ich besser bin, als ich in Wirklichkeit bin? Mit anderen Worten: Bin ich ein Heuchler?"),
        Question(text: "Gebe ich vertraulich an andere weiter, was mir im Vertrauen gesagt wurde?"),
        Question(text: "Bin ich vertrauenswürdig?"),
        Question(text: "Bin ich ein Sklave meiner Kleidung, Freunde, Arbeit oder Gewohnheiten?"),
        Question(text: "Bin ich unsicher, voller Selbstmitleid oder selbstgerecht?"),
        Question(text: "Lebte die Bibel heute in mir?"),
        Question(text: "Gebe ich der Bibel jeden Tag Zeit, zu mir zu sprechen?"),
        Question(text: "Habe ich Freude am Gebet?"),
        Question(text: "Wann habe ich zuletzt mit jemandem über meinen Glauben gesprochen?"),
        Question(text: "Bete ich über das Geld, das ich ausgebe?"),
        Question(text: "Gehe ich rechtzeitig zu Bett und stehe rechtzeitig auf?"),
        Question(text: "Bin ich Gott bei etwas ungehorsam?"),
        Question(text: "Bestehe ich darauf, etwas zu tun, das mein Gewissen beunruhigt?"),
        Question(text: "War ich in einem Teil meines Lebens unterlegen?"),
        Question(text: "Bin ich eifersüchtig, unrein, kritisch, reizbar, empfindlich oder misstrauisch?"),
        Question(text: "Wie verbringe ich meine Freizeit?"),
        Question(text: "Bin ich stolz?"),
        Question(text: "Gibt es jemanden, vor dem ich mich fürchte, den ich nicht leiden kann, mit dem ich nichts zu tun haben will, den ich kritisiere, gegen den ich einen Groll hege oder den ich ignoriere? Wenn ja, was unternehme ich dagegen?"),
        Question(text: "Murre oder beschwere ich mich ständig?"),
        Question(text: "Ist Christus für mich real?"),
      ],
    ),
    // Weitere Fragebögen hier hinzufügen
  ];
}*/
