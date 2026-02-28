import 'dart:math';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/local_storage.dart';

class DemoDataGenerator {
  static Future<void> generate(AppLocalizations localization) async {
    final storage = LocalStorage();
    final random = Random();
    final now = DateTime.now();
    
    // Die drei Standard-Keys
    final keys = ["ten commandments", "William Booth", "John Wesley"];
    
    print("--- START DEMO DATA GENERATION ---");
    
    for (String authorKey in keys) {
      final questionSet = localization.questionMap[authorKey];
      if (questionSet == null) continue;
      
      final questionCount = questionSet.questions.length;
      print("Generating 2 years of data for: $authorKey ($questionCount questions)");
      
      // Erstmal alles für diesen Author löschen, um einen sauberen Stand zu haben
      storage.setCurrentAuthor(authorKey);
      await storage.clearAllAssesmentEntries();
      
      // Generiere Daten für 730 Tage (2 Jahre), alle 2 Tage ein Eintrag
      for (int i = 730; i >= 0; i -= 2) {
        final date = now.subtract(Duration(days: i));
        
        // Erzeuge Werte mit einem "Trend" (Sinus-Welle + Zufall)
        // So sehen die Diagramme organischer aus
        List<double> values = List.generate(questionCount, (qIdx) {
          double trend = sin((i + qIdx * 5) / 40.0) * 0.25; // Langsame Welle
          double base = 0.5 + (qIdx % 3 * 0.1); // Unterschiedliche Basis pro Frage
          double noise = (random.nextDouble() - 0.5) * 0.15; // Etwas Rauschen
          
          return (base + trend + noise).clamp(0.0, 1.0);
        });
        
        // Hin und wieder eine Notiz einstreuen
        List<String?> questionNotes = List.generate(questionCount, (idx) {
          if (random.nextDouble() > 0.92) {
            return "Demo note for ${questionSet.questions[idx].text.substring(0, 10)}...";
          }
          return null;
        });

        final entry = AssessmentEntry(
          timestamp: date,
          questionSet: authorKey,
          values: values,
          questionNotes: questionNotes,
          note: i % 20 == 0 ? "General reflection for this period." : null
        );
        
        await storage.saveAssessmentEntry(entry);
      }
    }
    
    // Zurück auf William Booth setzen als Standard-Ansicht nach Generierung
    storage.setCurrentAuthor("William Booth");
    print("--- DEMO DATA GENERATION COMPLETE ---");
  }
}
