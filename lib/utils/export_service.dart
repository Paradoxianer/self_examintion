import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:flutter/widgets.dart';

enum ExportType { all, valuesAndAverage, averageOnly }

class ExportService {
  /// Generates and shares a CSV file based on the selected [ExportType].
  Future<void> exportData(BuildContext context, List<AssessmentEntry> history, ExportType type) async {
    final localization = AppLocalizations.of(context)!;
    final String author = history.isNotEmpty ? history.first.questionSet : "Export";
    
    // 1. Create CSV Content
    String csv = _generateCsvContent(context, history, type);

    // 2. Save to temporary file
    final directory = await getTemporaryDirectory();
    final String fileName = "${author.replaceAll(' ', '_')}_export_${DateFormat('yyyyMMdd').format(DateTime.now())}.csv";
    final File file = File('${directory.path}/$fileName');
    
    await file.writeAsString(csv);

    // 3. Share the file
    await Share.shareXFiles([XFile(file.path)], text: 'Self-Examination Data Export ($author)');
  }

  String _generateCsvContent(BuildContext context, List<AssessmentEntry> history, ExportType type) {
    final localization = AppLocalizations.of(context)!;
    StringBuffer buffer = StringBuffer();

    // Header Row
    buffer.write("Date;");
    if (type != ExportType.averageOnly) {
      final questionSet = localization.questionMap[history.first.questionSet];
      if (questionSet != null) {
        for (int i = 0; i < questionSet.questions.length; i++) {
          buffer.write("Q${i + 1};");
          if (type == ExportType.all) {
            buffer.write("Note Q${i + 1};");
          }
        }
      }
    }
    buffer.write("Average\n");

    // Data Rows
    for (var entry in history) {
      buffer.write("${DateFormat('yyyy-MM-dd HH:mm').format(entry.timestamp)};");
      
      double sum = 0;
      int count = 0;

      if (type != ExportType.averageOnly) {
        for (int i = 0; i < entry.values.length; i++) {
          double val = entry.values[i];
          if (val != -1.0) {
            buffer.write("${(val * 100).round()}%;");
            sum += val;
            count++;
          } else {
            buffer.write("-;");
          }

          if (type == ExportType.all) {
            String note = entry.questionNotes.length > i ? (entry.questionNotes[i] ?? "") : "";
            buffer.write("${note.replaceAll(';', ',').replaceAll('\n', ' ')};");
          }
        }
      } else {
        // Still need sum/count for averageOnly
        for (var val in entry.values) {
          if (val != -1.0) { sum += val; count++; }
        }
      }

      double avg = count > 0 ? (sum / count) * 100 : 0;
      buffer.write("${avg.round()}%\n");
    }

    return buffer.toString();
  }
}
