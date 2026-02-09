import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/localizations/app_localizations_de.dart';
import 'package:self_examination/localizations/app_localizations_en.dart';
import 'package:self_examination/localizations/app_localizations_es.dart';
import 'package:self_examination/localizations/app_localizations_ko.dart';
import 'package:self_examination/localizations/app_localizations_lt.dart';
import 'package:self_examination/localizations/app_localizations_pl.dart';

void main() {
  group('Localization Parity Tests', () {
    final List<AppLocalizations> locales = [
      AppLocalizationsDe(),
      AppLocalizationsEn(),
      AppLocalizationsEs(),
      AppLocalizationsKo(),
      AppLocalizationsLt(),
      AppLocalizationsPl(),
    ];

    test('All locales should have the correct number of TimeRangeShort labels', () {
      for (var locale in locales) {
        // We expect exactly 5 labels: 2D, 1W, 1M, 1Y, All
        expect(locale.timeRangeShort.length, 5, 
          reason: 'Locale ${locale.localeName} has incorrect count of timeRangeShort labels');
      }
    });

    test('All locales should have the correct number of rating/answer labels', () {
      for (var locale in locales) {
        expect(locale.rating.length, 4, 
          reason: 'Locale ${locale.localeName} should have 4 rating labels');
        expect(locale.answers.length, 4, 
          reason: 'Locale ${locale.localeName} should have 4 answer labels');
      }
    });

    test('All locales should provide the main question sets', () {
      for (var locale in locales) {
        final sets = locale.questionMap;
        expect(sets.containsKey('Salvation Army Chemnitz'), true, 
          reason: 'Locale ${locale.localeName} is missing "Salvation Army Chemnitz" set');
        expect(sets.containsKey('William Booth'), true, 
          reason: 'Locale ${locale.localeName} is missing "William Booth" set');
        expect(sets.containsKey('John Wesley'), true, 
          reason: 'Locale ${locale.localeName} is missing "John Wesley" set');
      }
    });

    test('Question counts should be consistent across languages', () {
      final baseCount = AppLocalizationsDe().questionMap['Salvation Army Chemnitz']!.questions.length;
      
      for (var locale in locales) {
        final count = locale.questionMap['Salvation Army Chemnitz']!.questions.length;
        expect(count, baseCount, 
          reason: 'Question count for Salvation Army Chemnitz differs in ${locale.localeName}');
      }
    });
  });
}
