import 'dart:math';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/local_storage.dart';

class DemoDataGenerator {
  static final Map<String, Map<int, List<String>>> _demoNotes = {
    "ten commandments": {
      0: [
        "Need to prioritize prayer time over work.",
        "Recognized some subtle idols in my daily routine today.",
        "Focusing more on God's presence throughout the day."
      ],
      3: [
        "The Sabbath rest was truly refreshing this week.",
        "Struggled to keep the day holy with so many chores.",
        "Peaceful day focusing on family and worship."
      ],
      6: [
        "Working on patience and kindness in my marriage.",
        "Had a deep conversation with my spouse today.",
        "Grateful for the commitment we share."
      ],
      9: [
        "Felt a bit of envy regarding a colleague's success.",
        "Practicing gratitude for what I have.",
        "Contentment is a daily choice."
      ],
    },
    "William Booth": {
      1: [
        "I need more discipline in my eating habits.",
        "Focusing on health as a temple of the Holy Spirit.",
        "Resisted some unhealthy cravings today."
      ],
      4: [
        "Reacted with frustration instead of love today.",
        "Praying for more compassion for those around me.",
        "A small act of kindness brought someone joy today."
      ],
      7: [
        "My actions didn't match my words today. Asking for grace.",
        "Striving for integrity in every small detail.",
        "Consistency is hard but rewarding."
      ],
      10: [
        "The desire for admiration was strong today. Staying humble.",
        "Finding my worth in God, not in human praise.",
        "Grateful for a quiet moment of humility."
      ],
    },
    "John Wesley": {
      2: [
        "Kept a secret today that was hard to hold.",
        "Honesty in communication is my main goal this week.",
        "Being a safe place for others to share."
      ],
      5: [
        "Struggled with self-pity this morning.",
        "God's grace is sufficient even when I feel low.",
        "Choosing joy over self-centeredness."
      ],
      8: [
        "Prayer felt dry today, but I stayed faithful.",
        "Had a breakthrough in my personal prayer time.",
        "Quiet time was the highlight of my day."
      ],
      11: [
        "Woke up early for reflection and it changed my day.",
        "Need to get to bed earlier tonight.",
        "Rest is a part of holiness."
      ],
      14: [
        "Felt defeated in my patience today.",
        "Getting back up after a spiritual stumble.",
        "God's strength is made perfect in my weakness."
      ],
      17: [
        "Caught myself being critical of a neighbor.",
        "Choosing to see others through God's eyes.",
        "Humility means seeing the truth about myself."
      ],
      20: [
        "Held onto a resentment too long today. Forgiving now.",
        "Peace returned as I let go of the grudge.",
        "Asking for a heart that forgives quickly."
      ],
    }
  };

  static Future<void> generate(AppLocalizations localization) async {
    final storage = LocalStorage();
    final random = Random();
    final now = DateTime.now();
    
    final keys = ["ten commandments", "William Booth", "John Wesley"];
    
    print("--- START DEMO DATA GENERATION ---");
    
    for (String authorKey in keys) {
      final questionSet = localization.questionMap[authorKey];
      if (questionSet == null) continue;
      
      final questionCount = questionSet.questions.length;
      final authorNotes = _demoNotes[authorKey] ?? {};
      
      print("Generating 2 years of data for: $authorKey");
      
      storage.setCurrentAuthor(authorKey);
      await storage.clearAllAssesmentEntries();
      
      for (int i = 730; i >= 0; i -= 2) {
        final date = now.subtract(Duration(days: i));
        
        List<double> values = List.generate(questionCount, (qIdx) {
          double trend = sin((i + qIdx * 5) / 45.0) * 0.25; 
          double base = 0.5 + (qIdx % 3 * 0.1); 
          double noise = (random.nextDouble() - 0.5) * 0.15; 
          
          return (base + trend + noise).clamp(0.0, 1.0);
        });
        
        List<String?> questionNotes = List.generate(questionCount, (qIdx) {
          // Check if we have specific notes for this question index
          if (authorNotes.containsKey(qIdx)) {
            // Only add a note in ~8% of the cases to not clutter too much
            if (random.nextDouble() > 0.92) {
              final notesList = authorNotes[qIdx]!;
              return notesList[random.nextInt(notesList.length)];
            }
          }
          return null;
        });

        final entry = AssessmentEntry(
          timestamp: date,
          questionSet: authorKey,
          values: values,
          questionNotes: questionNotes,
          note: i % 30 == 0 ? "General reflection on my spiritual journey during this month." : null
        );
        
        await storage.saveAssessmentEntry(entry);
      }
    }
    
    storage.setCurrentAuthor("William Booth");
    print("--- DEMO DATA GENERATION COMPLETE ---");
  }
}
