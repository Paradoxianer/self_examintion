import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:flutter/widgets.dart';

/// Defines the granularity of the data export.
enum ExportType {
  /// Includes all question values, individual notes, and daily averages.
  all,

  /// Includes question values and daily averages, but skips notes.
  valuesAndAverage,

  /// Only includes the calculated daily averages.
  averageOnly
}

/// Service to handle the generation and sharing of assessment data as CSV files.
class ExportService {
  /// Generates a CSV file from the given [history] and opens the system share sheet.
  ///
  /// [context] is required for localization access.
  /// [type] determines how much detail is included in the CSV.
  /// [sharePositionOrigin] is required for iPad to avoid crashes when showing the share sheet.
  Future<void> exportData(BuildContext context, List<AssessmentEntry> history,
      ExportType type, {Rect? sharePositionOrigin}) async {
    final String author =
        history.isNotEmpty ? history.first.questionSet : "Export";

    // 1. Create CSV Content
    String csv = _generateCsvContent(context, history, type);

    // 2. Save to temporary file
    final directory = await getTemporaryDirectory();
    final String timestamp = DateFormat('yyyyMMdd_HHmm').format(DateTime.now());
    final String fileName = "${author.replaceAll(' ', '_')}_$timestamp.csv";
    final File file = File('${directory.path}/$fileName');

    await file.writeAsString(csv);

    // 3. Share the file with iPad support
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Self-Examination Data: $author',
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  /// Internal helper to construct the CSV string.
  String _generateCsvContent(
      BuildContext context, List<AssessmentEntry> history, ExportType type) {
    final localization = AppLocalizations.of(context)!;
    StringBuffer buffer = StringBuffer();

    if (history.isEmpty) return "";

    final questionSet = localization.questionMap[history.first.questionSet];
    final String setName = questionSet?.authorName ?? history.first.questionSet;

    // --- Header Row ---
    buffer.write("Date;");
    
    if (type == ExportType.averageOnly) {
      // If only average, show the name of the question set as the column title
      buffer.write("$setName (Average);");
    } else if (questionSet != null) {
      for (int i = 0; i < questionSet.questions.length; i++) {
        // Use the actual question text instead of "Q1, Q2..."
        String qText = questionSet.questions[i].text.replaceAll(';', ',').replaceAll('\n', ' ');
        buffer.write("$qText;");
        if (type == ExportType.all) {
          buffer.write("Note: $qText;");
        }
      }
    }
    
    if (type != ExportType.averageOnly) {
      buffer.write("Total Average\n");
    } else {
      buffer.write("\n");
    }

    // --- Data Rows ---
    for (var entry in history) {
      buffer
          .write("${DateFormat('yyyy-MM-dd HH:mm').format(entry.timestamp)};");

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
            String note = entry.questionNotes.length > i
                ? (entry.questionNotes[i] ?? "")
                : "";
            // Escape separators to keep CSV valid
            buffer.write("${note.replaceAll(';', ',').replaceAll('\n', ' ')};");
          }
        }
      } else {
        for (var val in entry.values) {
          if (val != -1.0) {
            sum += val;
            count++;
          }
        }
      }

      double avg = count > 0 ? (sum / count) * 100 : 0;
      buffer.write("${avg.round()}%\n");
    }

    return buffer.toString();
  }
}
