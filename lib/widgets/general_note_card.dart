import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';

/// A persistent free-text field below the question list, used to journal
/// the overall spiritual state or context of the day for this assessment.
class GeneralNoteCard extends StatelessWidget {
  final TextEditingController controller;

  const GeneralNoteCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.edit_note, size: 20),
                const SizedBox(width: 8),
                Text(
                  localization.generalNoteLabel,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: localization.generalNoteHint,
                isDense: true,
                border: const OutlineInputBorder(),
              ),
              maxLines: null,
              minLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
