import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/models/question.dart';
import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get greetings => 'Welcome to the Self-Assessment Tool';
  @override
  String get start => 'Start';
  @override
  String get results => 'Results';
  @override
  String get settings => 'Settings';
  @override
  String get examinTitle => 'Self-Assessment';
  @override
  String get noteHint => 'Add notes...';
  @override
  String get pleasAnswer => 'Please answer all questions.';
  @override
  String get commit => 'Finish';
  @override
  String get saved => 'Data saved';
  @override
  String get chartTitle => 'Development Chart';
  @override
  String get noHistory =>
      'No data found from past self-assessment. Please choose another set or fill out the questions.';
  @override
  String get warningTitle => 'Warning';
  @override
  String warningDel(String autor, Object author) =>
      'All saved progress for $autor will be deleted and lost forever. Proceed?';
  @override
  String get settingsTitle => 'Settings';
  @override
  String get chooseQuestionSet => 'Choose question set';
  @override
  String get delete => 'Delete data';
  @override
  String get notification => 'Remind me';
  @override
  String get notificationFrequency => 'Frequency';
  @override
  String get daily => 'daily';
  @override
  String get weekly => 'weekly';
  @override
  String get monthly => 'monthly';
  @override
  String get datasecurityDialog => 'GDPR Dialog';
  @override
  String get dsgvoNo => 'Consent denied';
  @override
  String get dsgvoNoInfo => 'The app can only function if you agree.';
  @override
  String get ok => 'OK';
  @override
  String get cancel => 'Cancel';
  @override
  String get dsgvoTitle => 'Data Privacy and Consent';
  @override
  String get dsgvo1 =>
      'To track your personal spiritual development, we store your answers. This data is anonymized and stored locally.';
  @override
  String get dsgvo2 =>
      'Please note that individuals with access to your device may be able to access this data.';
  @override
  String get dsgvo3 =>
      'By clicking \'Agree\', you agree to have your data stored as described.';
  @override
  String get dsgvoOK => 'Agree';
  @override
  String get dsgvoCancel => 'Reject';
  @override
  String get dsgvoYes => 'Consent given';
  @override
  String get close => 'Close';
  @override
  String get total => 'Total';
  @override
  String get compareChart => 'Comparison';
  @override
  String get timeChart => 'Timeline';
  @override
  String get fullDateAndTime => 'EEE, MMM dd, yyyy h:mm a';
  @override
  String get fullDate => 'MMM dd, yyyy';
  @override
  String get shortDate => 'MM/dd/yy';
  @override
  String get shortTime => 'h:mm a';
  @override
  List<String> get rating =>
      ["Excellent", "Good path", "Not so good", "Needs work"];
  @override
  List<String> get answers => ["Not at all", "Little", "Mostly", "Completely"];
  @override
  List<String> get frequenze => ["daily", "weekly", "monthly", "annually"];

  @override
  String get filterQuestions => "Filter Questions";
  @override
  String get today => "Today";
  @override
  String get noData => "No data available";
  @override
  String get radarError =>
      "The Radar Chart requires at least 3 selected questions to display an area.";
  @override
  String get prevPeriod => "Previous Period";
  @override
  String get currPeriod => "Current Period";
  @override
  String get all => "All";
  @override
  List<String> get timeRangeShort => ["2D", "1W", "1M", "1Y", "All"];

  @override
  Map<String, SelfAssessmentQuestionSet> get questionMap {
    return {
      "Salvation Army Chemnitz": SelfAssessmentQuestionSet(
        authorName: "Salvation Army Chemnitz",
        description: "Self-assessment questions based on the Ten Commandments.",
        questions: [
          Question(
              text:
                  "To what extent do I avoid putting other things beside the one true God?"),
          Question(
              text:
                  "How consistently do I refrain from making an image of God?"),
          Question(
              text:
                  "How much have I avoided using the name of the LORD thoughtlessly?"),
          Question(text: "Do I take a day off every six days to honor God?"),
          Question(
              text:
                  "To what extent do I honor my parents and show them respect?"),
          Question(
              text:
                  "How consistently do I avoid harming others in thoughts, words, or actions?"),
          Question(text: "To what extent do I stay away from adultery?"),
          Question(
              text:
                  "How reliably do I practice honesty and refrain from taking others property?"),
          Question(
              text:
                  "In what measure do I avoid spreading false things or gossip?"),
          Question(
              text:
                  "How much do I avoid being envious of what belongs to others?"),
        ],
      ),
      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description: "Self-denial questions by William Booth",
        questions: [
          Question(
              text: "Am I habitually guilty of any known sin?",
              isPositive: true),
          Question(text: "Am I the master of my bodily appetites?"),
          Question(
              text:
                  "Are my thoughts such that I would not be ashamed if God revealed them?"),
          Question(
              text:
                  "Does worldly influence cause me to do things unlike Christ?",
              isPositive: true),
          Question(
              text: "Do my tempers cause me to act contrary to love?",
              isPositive: true),
          Question(
              text: "Am I doing all in my power for the salvation of sinners?"),
          Question(text: "Am I fulfilling the vows I made to God?"),
          Question(text: "Is my example in harmony with my profession?"),
          Question(
              text: "Am I conscious of any pride or arrogance?",
              isPositive: true),
          Question(
              text:
                  "Do I have the courage to go against the stream of the world?"),
          Question(
              text: "Am I in danger of worldly desire to be rich or admired?",
              isPositive: true),
        ],
      ),
      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description: "John Wesley's 22 daily questions:",
        questions: [
          Question(text: "Am I a hypocrite?", isPositive: true),
          Question(
              text: "Am I honest in all my acts, or do I exaggerate?",
              isPositive: true),
          Question(
              text: "Do I pass on what was said in confidence?",
              isPositive: true),
          Question(text: "Can I be trusted?"),
          Question(
              text: "Am I a slave to dress, friends, work or habits?",
              isPositive: true),
          Question(
              text: "Am I self-conscious or self-pitying?", isPositive: true),
          Question(text: "Did the Bible live in me today?"),
          Question(text: "Do I give the Bible time to speak to me every day?"),
          Question(text: "Am I enjoying prayer?"),
          Question(text: "When did I last speak to someone of my faith?"),
          Question(text: "Do I pray about the money I spend?"),
          Question(text: "Do I get to bed and get up on time?"),
          Question(text: "Do I disobey God in anything?", isPositive: true),
          Question(
              text:
                  "Do I insist on doing something that bothers my conscience?",
              isPositive: true),
          Question(
              text: "Am I defeated in any part of my life?", isPositive: true),
          Question(
              text: "Am I jealous, impure, critical or irritable?",
              isPositive: true),
          Question(text: "How do I spend my spare time?", isPositive: true),
          Question(text: "Am I proud?", isPositive: true),
          Question(
              text: "Do I thank God that I am not as other people?",
              isPositive: true),
          Question(
              text: "Is there anyone I hold a resentment toward?",
              isPositive: true),
          Question(
              text: "Do I grumble or complain constantly?", isPositive: true),
          Question(text: "Is Christ real to me?"),
        ],
      ),
    };
  }
}
