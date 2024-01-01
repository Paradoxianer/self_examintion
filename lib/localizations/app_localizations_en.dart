import 'package:self_examintion/data/self_assesment_questions.dart';
import 'package:self_examintion/models/question.dart';

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
      'No data found from past self-assessment questions. Please choose a different question set or fill out the questions.';

  @override
  String get warningTitle => 'Warning';

  @override
  String warningDel(String autor, Object author) {
    return 'All saved progress for $author will be deleted and lost forever. Do you want to proceed?';
  }

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
      'To track your personal spiritual development, we store your answers to the questions asked. These data are anonymized and stored locally on your device.';

  @override
  String get dsgvo2 =>
      'Please note that individuals who have access to your device and the app may be able to access this data.';

  @override
  String get dsgvo3 =>
      'By clicking \'Agree\' below, you agree to have your data stored as described above. If you do not agree, no data will be collected, but the app will also not function.';

  @override
  String get dsgvoOK => 'Agree';

  @override
  String get dsgvoCancel => 'Reject';

  @override
  String get dsgvoYes => 'Consent given';

  @override
  String get close => 'Close';

  @override
  String get total => 'total';

  @override
  String get compareChart => 'compare chart';

  @override
  String get timeChart => 'time chart';

  List<String> get rating => ["Excellent", "Good path", "Not so good", "Needs work"];

  List<String> get answers => ["Not at all","Little", "Mostly","Completely"];

  List<String> get frequenze => ["daily","weekly","montly","anual"];


  Map<String, SelfAssessmentQuestionSet> get questionMap {
    Map<String, SelfAssessmentQuestionSet> _questionMap = {
      "Salvation Army Chemnitz": SelfAssessmentQuestionSet(
        authorName: "Salvation Army Chemnitz",
        description: "Self-assessment questions developed by the Salvation Army Chemnitz based on the Ten Commandments.",
        questions: [
          Question(
              text: "To what extent do I avoid putting other things beside the one true God?",
              description: "You shall have no other gods before me! (Exodus 20:2-6)"
          ),
          Question(
              text: "How consistently do I refrain from making or worshiping an image of God?",
              description: "You shall not make for yourself an image in the form of anything in heaven above or on the earth beneath or in the waters below. (Exodus 20:4)"
          ),
          Question(
              text: "How much have I avoided using the name of the LORD, my God, thoughtlessly?",
              description: "You shall not misuse the name of the LORD your God, for the LORD will not hold anyone guiltless who misuses his name. (Exodus 20:7)"
          ),
          Question(
              text: "Do I take a day off every six days to honor God?",
              description: "But the seventh day is a sabbath to the LORD your God. On it you shall not do any work. (Exodus 20:8-11)"
          ),
          Question(
              text: "To what extent do I honor my parents and show them respect?",
              description: "Honor your father and your mother, so that you may live long in the land the LORD your God is giving you. (Exodus 20:12)"
          ),
          Question(
              text: "How consistently do I avoid harming others in thoughts, words, or actions?",
              description: "You shall not murder. (Exodus 20:13)"
          ),
          Question(
              text: "To what extent do I stay away from adultery and preserve marriage as a sacred institution?",
              description: "You shall not commit adultery. (Exodus 20:14)"
          ),
          Question(
              text: "How reliably do I refrain from taking what does not belong to me and practice honesty?",
              description: "You shall not steal. (Exodus 20:15)"
          ),
          Question(
              text: "To what extent do I avoid spreading false information or gossip about others?",
              description: "You shall not give false testimony against your neighbor. (Exodus 20:16)"
          ),
          Question(
              text: "How much do I avoid being envious of what belongs to others or how others live?",
              description: "You shall not covet your neighbor's house, you shall not covet your neighbor's wife, nor his manservant, nor his maidservant, nor his ox, nor his ass, nor any thing that is your neighbor's. (Exodus 20:17)"
          ),
        ],
      ),
      "William Booth": SelfAssessmentQuestionSet(
        authorName: "William Booth",
        description: "Self-denial questions by William Booth",
        questions: [
          Question(
              text:
                  "Am I habitually guilty of any known sin? Do I practice or allow myself any thought, word or deed that I know to be wrong?",
              isPositive: true),
          Question(
              text:
                  "Am I so the master of my bodily appetites as to have no condemnation? Do I allow myself any indulgence that is injurious to my holiness, growth in knowledge, obedience, or usefulness?"),
          Question(
              text:
                  "Are my thoughts and feelings such that I should not be ashamed to hear them published before God?"),
          Question(
              text:
                  "Does the influence of the world cause me to do or say things that are unlike Christ?",
              isPositive: true),
          Question(
              text:
                  "Do my tempers cause me to act, or feel, or say things that I see afterward are contrary to that love that I ought to [show] always to those about me?",
              isPositive: true),
          Question(
              text:
                  "Am I doing all in my power for the salvation of sinners? Do I feel concern about their danger and pray and work for their salvation as if they were my children?"),
          Question(
              text:
                  "Am I fulfilling the vows I have made to God in my acts of consecration or at the penitent-form?"),
          Question(
            text: "Is my example in harmony with my profession?",
          ),
          Question(
              text:
                  "Am I conscious of any pride or haughtiness in my manner or bearing?",
              isPositive: true),
          Question(
              text:
                  "Do I conform to the fashions and customs of the world, or do I show that I despise them?"),
          Question(
              text:
                  "Am I in danger of being carried away with worldly desire to be rich or admired?",
              isPositive: true),
          // Weitere Fragen von William Booth hier hinzufügen
        ],
      ),
      "John Wesley": SelfAssessmentQuestionSet(
        authorName: "John Wesley",
        description: "John Wesley rigorously self-examined himself everyday by asking the following 22 questions:",
        questions: [
          Question(
              text:
                  "Am I consciously or unconsciously creating the impression that I am better than I really am? In other words, am I a hypocrite?"),
          Question(
              text:
                  "Am I honest in all my acts and words, or do I exaggerate?"),
          Question(
              text:
                  "Do I confidentially pass on to others what has been said to me in confidence?"),
          Question(text: "Can I be trusted?"),
          Question(text: "Am I a slave to dress, friends, work or habits?"),
          Question(
              text: "Am I self-conscious, self-pitying, or self-justifying?"),
          Question(text: "Did the Bible live in me today?"),
          Question(text: "Do I give the Bible time to speak to me every day?"),
          Question(text: "Am I enjoying prayer?"),
          Question(text: "When did I last speak to someone else of my faith?"),
          Question(text: "Do I pray about the money I spend?"),
          Question(text: "Do I get to bed on time and get up on time?"),
          Question(text: "Do I disobey God in anything?"),
          Question(
              text:
                  "Do I insist upon doing something about which my conscience is uneasy?"),
          Question(text: "Am I defeated in any part of my life?"),
          Question(
              text:
                  "Am I jealous, impure, critical, irritable, touchy or distrustful?"),
          Question(text: "How do I spend my spare time?"),
          Question(text: "Am I proud?"),
          Question(
              text:
                  "Do I thank God that I am not as other people, especially as the Pharisees who despised the publican?"),
          Question(
              text:
                  "Is there anyone whom I fear, dislike, disown, criticize, hold a resentment toward or disregard? If so, what am I doing about it?"),
          Question(text: "Do I grumble or complain constantly?"),
          Question(text: "Is Christ real to me?")
        ],
      )
    };
    return _questionMap;
  }
}
