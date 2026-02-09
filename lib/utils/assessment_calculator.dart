import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/models/question.dart';
import 'package:self_examination/data/self_assesment_questions.dart';

class AssessmentCalculator {
  /// Calculates the display value for a question based on its polarity.
  /// If [isPositive] is true (e.g. a sin), 1.0 (100%) becomes 0.0 (0%) for the chart.
  static double getChartValue(double rawValue, bool isPositive) {
    if (rawValue == -1.0) return 0.0;
    return isPositive ? 1.0 - rawValue : rawValue;
  }

  /// Calculates the average 'holiness' score for a single assessment entry.
  static double calculateAverage(AssessmentEntry entry, SelfAssessmentQuestionSet? questionSet) {
    if (entry.values.isEmpty) return 0.0;
    
    double sum = 0;
    int count = 0;
    
    for (int i = 0; i < entry.values.length; i++) {
      double val = entry.values[i];
      if (val != -1.0) {
        bool isPositive = false;
        if (questionSet != null && i < questionSet.questions.length) {
          isPositive = questionSet.questions[i].isPositive;
        }
        sum += getChartValue(val, isPositive);
        count++;
      }
    }
    return count > 0 ? sum / count : 0.0;
  }
}
