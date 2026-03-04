import 'package:flutter_test/flutter_test.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/localizations/app_localizations_de.dart';
import 'package:self_examination/localizations/app_localizations_en.dart';
import 'package:self_examination/localizations/app_localizations_es.dart';
import 'package:self_examination/localizations/app_localizations_ko.dart';
import 'package:self_examination/localizations/app_localizations_lt.dart';
import 'package:self_examination/localizations/app_localizations_pl.dart';
import 'package:self_examination/localizations/app_localizations_uk.dart';
import 'package:self_examination/localizations/app_localizations_ru.dart';

void main() {
  group('QuestionSetIntegrity Tests', () {
    final List<AppLocalizations> locales = [
      AppLocalizationsDe(),
      AppLocalizationsEn(),
      AppLocalizationsEs(),
      AppLocalizationsKo(),
      AppLocalizationsLt(),
      AppLocalizationsPl(),
      AppLocalizationsUk(),
      AppLocalizationsRu(),
    ];

    final expectedCounts = {
      'ten commandments': 10,
      'William Booth': 11,
      'John Wesley': 23,
    };

    test('All locales should have consistent question sets and counts', () {
      for (var locale in locales) {
        final questionMap = locale.questionMap;
        
        // Verify all expected sets exist
        for (var setName in expectedCounts.keys) {
          expect(questionMap.containsKey(setName), true, 
            reason: 'Locale ${locale.localeName} is missing question set: $setName');
          
          final count = questionMap[setName]!.questions.length;
          expect(count, expectedCounts[setName], 
            reason: 'Locale ${locale.localeName} has incorrect question count for $setName. Expected ${expectedCounts[setName]}, found $count');
        }
      }
    });

    test('Author names should not be empty', () {
       for (var locale in locales) {
        for (var entry in locale.questionMap.entries) {
          expect(entry.value.authorName.isNotEmpty, true,
            reason: 'Author name for ${entry.key} in ${locale.localeName} is empty');
        }
      }
    });

    test('Descriptions should not be empty', () {
       for (var locale in locales) {
        for (var entry in locale.questionMap.entries) {
          expect(entry.value.description.isNotEmpty, true,
            reason: 'Description for ${entry.key} in ${locale.localeName} is empty');
        }
      }
    });
  });
}
