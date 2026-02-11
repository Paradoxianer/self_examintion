import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/models/question.dart';
import 'app_localizations.dart';

class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override String get greetings => 'Welcome to the Self-Assessment Tool';
  @override String get start => 'Start';
  @override String get results => 'Results';
  @override String get settings => 'Settings';
  @override String get examinTitle => 'Self-Assessment';
  @override String get noteHint => 'Add notes...';
  @override String get pleasAnswer => 'Please answer all questions.';
  @override String get commit => 'Finish';
  @override String get saved => 'Data saved';
  @override String get chartTitle => 'Development Chart';
  @override String get noHistory => 'No data found. Please answer the questions.';
  @override String get warningTitle => 'Warning';
  @override String warningDel(String autor, Object author) => 'All progress for $autor will be deleted. Proceed?';
  @override String get settingsTitle => 'Settings';
  @override String get chooseQuestionSet => 'Choose question set';
  @override String get delete => 'Delete data';
  @override String get notification => 'Remind me';
  @override String get notificationFrequency => 'Frequency';
  @override String get daily => 'daily';
  @override String get weekly => 'weekly';
  @override String get monthly => 'monthly';
  @override String get datasecurityDialog => 'Privacy & GDPR';
  @override String get dsgvoNo => 'Consent denied';
  @override String get dsgvoNoInfo => 'The app can only function if you agree.';
  @override String get ok => 'OK';
  @override String get cancel => 'Cancel';
  @override String get dsgvoTitle => 'Data Privacy and Consent';
  @override String get dsgvo1 => 'To track your personal spiritual development, we store your answers locally on your device.';
  @override String get dsgvo2 => 'No data is transmitted to the cloud. Your privacy stays 100% on your phone.';
  @override String get dsgvo3 => 'By clicking \'Agree\', you consent to local storage. Without it, history cannot be saved.';
  @override String get dsgvoOK => 'Agree';
  @override String get dsgvoCancel => 'Reject';
  @override String get dsgvoYes => 'Consent given';
  @override String get close => 'Close';
  @override String get total => 'Total';
  @override String get compareChart => 'Comparison';
  @override String get timeChart => 'Timeline';
  @override String get fullDateAndTime => 'EEE, MMM dd, yyyy h:mm a';
  @override String get fullDate => 'MMM dd, yyyy';
  @override String get shortDate => 'MM/dd/yy';
  @override String get shortTime => 'h:mm a';
  @override List<String> get rating => ["Excellent", "Good path", "Not so good", "Needs work"];
  @override List<String> get answers => ["Not at all", "Little", "Mostly", "Completely"];
  @override List<String> get frequenze => ["daily", "weekly", "monthly", "annually"];

  @override String get filterQuestions => "Filter Questions";
  @override String get today => "Today";
  @override String get noData => "No data available";
  @override String get radarError => "The Radar Chart requires at least 3 selected questions.";
  @override String get prevPeriod => "Previous Period";
  @override String get currPeriod => "Current Period";
  @override String get all => "All";
  @override List<String> get timeRangeShort => ["2D", "1W", "1M", "1Y", "All"];
  @override String get tips => "Tips & Information";

  @override String get settingsQuestionSetSubtitle => "Choose a set to edit or delete data.";
  @override String get settingsExportHeader => "Data Export";
  @override String get settingsExportAll => "Export All";
  @override String get settingsExportValues => "Values & Average";
  @override String get settingsExportAverage => "Average Only";
  @override String get settingsSecurityHeader => "Security & Privacy";
  @override String get settingsSecurityLock => "Enable App Lock";
  @override String get settingsReminderHeader => "Reminder";
  @override String get settingsNoDataToExport => "No data available to export.";

  @override String get about => "About the App";
  @override String get aboutContent => "This app is for personal reflection and spiritual growth. Inspired by William Booth and John Wesley.";
  @override String get version => "Version";
  @override String get imprint => "Imprint";
  @override String get license => "Licenses";
  @override String get imprintContent => "Responsible: Matthias Lindner\nContact: ";
  @override String get githubRepository => "GitHub Repository (Report bugs & contribute)";

  @override
  Map<String, SelfAssessmentQuestionSet> get questionMap {
    return {
      "ten commandments": SelfAssessmentQuestionSet(
        authorName: "ten commandments",
        description: "Questions based on the Ten Commandments.",
        questions: [
          Question(text: "To what extent do I avoid putting other things beside God?"),
          Question(text: "How consistently do I refrain from making an image of God?"),
          Question(text: "Do I use the Lord's name thoughtfully?"),
          Question(text: "Do I take a day off to honor God?"),
          Question(text: "Do I honor my parents?"),
          Question(text: "Do I avoid harming others?"),
          Question(text: "Do I preserve marriage as sacred?"),
          Question(text: "Am I honest with others' property?"),
          Question(text: "Do I avoid gossip?"),
          Question(text: "Do I avoid envy?"),
        ],
      ),
      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description: "Self-denial questions by William Booth",
        questions: [
          Question(text: "Am I habitually guilty of any known sin?", isPositive: true),
          Question(text: "Am I the master of my bodily appetites?"),
          Question(text: "Are my thoughts such that I would not be ashamed?"),
          Question(text: "Does worldly influence cause me to do wrong?", isPositive: true),
          Question(text: "Do I act out of love?", isPositive: true),
          Question(text: "Do I do all for the salvation of sinners?"),
          Question(text: "Do I fulfill my vows?"),
          Question(text: "Is my example in harmony with my word?"),
          Question(text: "Am I proud or arrogant?", isPositive: true),
          Question(text: "Do I have the courage to go against the stream?"),
          Question(text: "Am I in danger of worldly desire?", isPositive: true),
        ],
      ),
      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description: "John Wesley's 22 daily questions:",
        questions: [
          Question(text: "Am I a hypocrite?", isPositive: true),
          Question(text: "Am I honest or do I exaggerate?", isPositive: true),
          Question(text: "Do I pass on confidential info?", isPositive: true),
          Question(text: "Can I be trusted?"),
          Question(text: "Am I a slave to habits?", isPositive: true),
          Question(text: "Am I self-pitying?", isPositive: true),
          Question(text: "Did the Bible live in me today?"),
          Question(text: "Do I give the Bible time?"),
          Question(text: "Am I enjoying prayer?"),
          Question(text: "When did I last speak of my faith?"),
          Question(text: "Do I pray about my money?"),
          Question(text: "Do I sleep and wake on time?"),
          Question(text: "Do I disobey God?", isPositive: true),
          Question(text: "Do I insist on things that bother my conscience?", isPositive: true),
          Question(text: "Am I defeated in any part?", isPositive: true),
          Question(text: "Am I jealous or irritable?", isPositive: true),
          Question(text: "How do I spend my spare time?", isPositive: true),
          Question(text: "Am I proud?", isPositive: true),
          Question(text: "Do I thank God I am not like others?", isPositive: true),
          Question(text: "Do I hold a resentment?", isPositive: true),
          Question(text: "Do I grumble constantly?", isPositive: true),
          Question(text: "Is Christ real to me?"),
        ],
      ),
    };
  }
}
