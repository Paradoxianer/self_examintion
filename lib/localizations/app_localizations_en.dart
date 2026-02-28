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
  @override String get selectAll => "Select all";
  @override String get selectNone => "Deselect all";
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

  @override String get onboardingSkip => "Skip";
  @override String get onboardingNext => "Next";
  @override String get onboardingStart => "Start";

  @override
  String get onboarding1Title => "Self-Examination App";

  @override
  String get onboarding1DescriptionTop =>
      "William Booth and John Wesley regularly took time for self-examination.\n"
          "How have I lived my faith today?\n"
          "Where could God's love be visible through me?\n"
          "And where does it want to continue changing me?\n\n"
          "This app invites you to exactly this honest reflection.\n"
          "You can choose from different question sets, record your answers\n"
          "and observe your development over days, weeks, months or years –\n"
          "as a whole or in individual areas.\n\n"
          "As a help to perceive where God's love invites you to continue acting –\n"
          "and where growth is still possible.";

  @override
  String get onboarding1DescriptionBottom =>
      "Here you can choose between different sets of self-examination questions. "
          "Each set contains different questions with its own focus. "
          "You can get an overview of all questions by tapping the info icon (i).";

  @override
  String get onboarding2Title => "Reflect & Note";

  @override
  String get onboarding2Step1Title => "Reflect";

  @override
  String get onboarding2Step1Description =>
      "Move the slider to assess for yourself how you would answer the respective question today.\n\n"
          "If you feel your answer is more positive, slide the slider in the green direction. "
          "If you feel it is more negative, slide it in the red direction.\n\n"
          "Your chosen rating in percent will be displayed above the slider.";

  @override
  String get onboarding2Step2Title => "Notes";

  @override
  String get onboarding2Step2Description =>
      "Tap the note icon (sheet with plus) to record a thought, an observation or a prayer. "
          "The note will be saved together with the question and the corresponding date.\n\n"
          "Tap the note icon again to close the note field.";

  @override
  String get onboarding3Title => "Analysis & Security";

  @override
  String get onboarding3Step1Title => "Charts";

  @override
  String get onboarding3Step1Description =>
      "After you have answered all the questions, you can reach the chart view via the 'Finish' button.\n\n"
          "Swipe left or right in the chart area to switch between different views. "
          "Below the charts you can select which questions should be displayed in the evaluation.";

  @override
  String get onboarding3Step2Title => "Privacy";

  @override
  String get onboarding3Step2Description =>
      "Your data remains stored exclusively locally on your device.\n\n"
          "Optionally, you can additionally protect it with your device PIN or biometric "
          "backups (e.g. fingerprint or face recognition).\n\n"
          "If necessary, you can export your data as a CSV file with different levels of detail "
          "and, for example, evaluate it further in Excel.";


  @override
  Map<String, SelfAssessmentQuestionSet> get questionMap {
    return {
      "ten commandments": SelfAssessmentQuestionSet(
        authorName: "Ten Commandments",
        description:
        "A set of questions developed by the Salvation Army Chemnitz as part of a sermon series on the Ten Commandments.",
        questions: [
          Question(
            text: "To what extent have I avoided putting other things or matters beside the one true God?",
            description: "You shall have no other gods before me. (Exodus 20:1–6)",
          ),
          Question(
            text: "How consistently have I avoided making or crafting an image of God?",
            description: "You shall not make for yourself an image. (Exodus 20:4)",
          ),
          Question(
            text: "How much have I avoided using God's name thoughtlessly?",
            description: "You shall not misuse the name of the Lord your God. (Exodus 20:7)",
          ),
          Question(
            text: "Do I consciously take a time-out to honor God?",
            description: "But the seventh day is a sabbath to the Lord your God. (Exodus 20:8–11)",
          ),
          Question(
            text: "To what extent do I honor my parents and show them respect?",
            description: "Honor your father and your mother. (Exodus 20:12)",
          ),
          Question(
            text: "How consistently do I avoid harming other people in thought, word, or deed?",
            description: "You shall not murder. (Exodus 20:13)",
          ),
          Question(
            text: "To what extent do I stay away from adultery and keep marriage sacred?",
            description: "You shall not commit adultery. (Exodus 20:14)",
          ),
          Question(
            text: "How reliably do I keep my hands off other people's property and practice honesty?",
            description: "You shall not steal. (Exodus 20:15)",
          ),
          Question(
            text: "To what extent do I avoid spreading false things about other people or gossiping?",
            description: "You shall not give false testimony against your neighbor. (Exodus 20:16)",
          ),
          Question(
            text: "How much do I avoid being envious of what belongs to other people or how other people live?",
            description: "You shall not covet your neighbor’s house... or anything that belongs to your neighbor. (Exodus 20:17)",
          ),
        ],
      ),

      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description: "Self-examination questions that William Booth asked himself every evening.",
        questions: [
          Question(
            text: "Am I habitually guilty of any known sin? Do I practice or allow myself any thought, word or deed of which my conscience condemns me?",
            isPositive: true,
          ),
          Question(
            text: "Am I so much the master of my bodily appetites as to exhibit no shameful behavior? Do I allow myself any indulgence which is injurious to my holiness, my growth in knowledge, my obedience and my usefulness?",
          ),
          Question(
            text: "Are all my thoughts and feelings such as I should not be ashamed of if they were laid open before God?",
          ),
          Question(
            text: "Does the influence of the world lead me to do or say anything which is not in keeping with the character of a Christian?",
            isPositive: true,
          ),
          Question(
            text: "Does my disposition lead me to feel, do or say anything that I am afterwards conscious is contrary to that love which I ought always to bear to my fellow men?",
            isPositive: true,
          ),
          Question(
            text: "Do I do all in my power for the salvation of sinners? Do I care that they are in danger? Do I pray for them, struggle for their salvation, as though they were my own children?",
          ),
          Question(
            text: "Do I fulfill my vows, made to God in the act of consecration or at the mercy seat?",
          ),
          Question(
            text: "Is my example in harmony with my words?",
          ),
          Question(
            text: "Am I proud or arrogant in nature or appearance?",
            isPositive: true,
          ),
          Question(
            text: "Do I conform to the customs and fashions of the world or have I the courage to go against the stream?",
            isPositive: true,
          ),
          Question(
            text: "Am I in danger of being carried away by the worldly desire to be rich or admired?",
            isPositive: true,
          ),
        ],
      ),

      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description: "John Wesley's 22 questions that he asked himself for self-examination every day:",
        questions: [
          Question(
            text: "Am I consciously or unconsciously creating the impression that I am better than I really am? In other words, am I a hypocrite?",
            isPositive: true,
          ),
          Question(
            text: "Am I honest in all my acts and words, or do I exaggerate?",
            isPositive: true,
          ),
          Question(
            text: "Do I confidentially pass on to another what was told to me in confidence?",
            isPositive: true,
          ),
          Question(
            text: "Can I be trusted?",
          ),
          Question(
            text: "Am I a slave to dress, friends, work, or habits?",
          ),
          Question(
            text: "Am I self-conscious, self-pitying, or self-justifying?",
            isPositive: true,
          ),
          Question(
            text: "Did the Bible live in me today?",
          ),
          Question(
            text: "Do I give the Bible time to speak to me every day?",
          ),
          Question(
            text: "Am I enjoying prayer?",
          ),
          Question(
            text: "When did I last speak to someone else about my faith?",
          ),
          Question(
            text: "Do I pray about the money I spend?",
          ),
          Question(
            text: "Do I go to bed on time and get up on time?",
          ),
          Question(
            text: "Do I disobey God in anything?",
            isPositive: true,
          ),
          Question(
            text: "Do I insist upon doing something about which my conscience is uneasy?",
            isPositive: true,
          ),
          Question(
            text: "Am I defeated in any part of my life?",
            isPositive: true,
          ),
          Question(
            text: "Am I jealous, impure, critical, irritable, touchy, or distrustful?",
            isPositive: true,
          ),
          Question(
            text: "How do I spend my spare time?",
          ),
          Question(
            text: "Am I proud?",
            isPositive: true,
          ),
          Question(
            text: "Do I thank God that I am not as other men, especially as the Pharisees who despised the publican?",
            isPositive: true,
          ),
          Question(
            text: "Is there anyone whom I fear, disbelieve, mistake, criticize, or resent? If so, what am I doing about it?",
            isPositive: true,
          ),
          Question(
            text: "Do I hold a resentment?",
            isPositive: true,
          ),
          Question(
            text: "Do I grumble or complain constantly?",
            isPositive: true,
          ),
          Question(
            text: "Is Christ real to me?",
          ),
        ],
      ),
    };
  }
}
