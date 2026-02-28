import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;
import 'package:self_examination/data/self_assesment_questions.dart';

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_es.dart';
import 'app_localizations_lt.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_uk.dart';

abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('ko'),
    Locale('es'),
    Locale('pl'),
    Locale('lt'),
    Locale('uk'),
  ];

  String get greetings;
  String get start;
  String get results;
  String get settings;
  String get examinTitle;
  String get noteHint;
  String get pleasAnswer;
  String get commit;
  String get saved;
  String get chartTitle;
  String get noHistory;
  String get warningTitle;
  String warningDel(String autor, Object author);
  String get settingsTitle;
  String get chooseQuestionSet;
  String get delete;
  String get notification;
  String get notificationFrequency;
  String get daily;
  String get weekly;
  String get monthly;
  String get datasecurityDialog;
  String get dsgvoNo;
  String get dsgvoNoInfo;
  String get ok;
  String get cancel;
  String get dsgvoTitle;
  String get dsgvo1;
  String get dsgvo2;
  String get dsgvo3;
  String get dsgvoOK;
  String get dsgvoCancel;
  String get dsgvoYes;
  String get close;
  String get total;
  String get compareChart;
  String get timeChart;
  String get fullDateAndTime;
  String get fullDate;
  String get shortDate;
  String get shortTime;
  List<String> get rating;
  List<String> get answers;
  List<String> get frequenze;
  Map<String, SelfAssessmentQuestionSet> get questionMap;

  // Chart UI strings
  String get filterQuestions;
  String get today;
  String get noData;
  String get radarError;
  String get prevPeriod;
  String get currPeriod;
  String get all;
  String get selectAll;
  String get selectNone;
  List<String> get timeRangeShort;
  String get tips;

  // Settings specific strings
  String get settingsQuestionSetSubtitle;
  String get settingsExportHeader;
  String get settingsExportAll;
  String get settingsExportValues;
  String get settingsExportAverage;
  String get settingsSecurityHeader;
  String get settingsSecurityLock;
  String get settingsReminderHeader;
  String get settingsNoDataToExport;

  // About and Legal strings
  String get about;
  String get aboutContent;
  String get version;
  String get imprint;
  String get license;
  String get imprintContent;
  String get githubRepository;

  // Onboarding strings
  String get onboardingSkip;
  String get onboardingNext;
  String get onboardingStart;
  
  // Screen 1: Vision & Selection
  String get onboarding1Title;
  String get onboarding1DescriptionTop;
  String get onboarding1DescriptionBottom;
  
  // Screen 2: Usage (Slider & Notes)
  String get onboarding2Title;
  String get onboarding2Step1Title;
  String get onboarding2Step1Description;
  String get onboarding2Step2Title;
  String get onboarding2Step2Description;
  
  // Screen 3: Analysis & Privacy
  String get onboarding3Title;
  String get onboarding3Step1Title;
  String get onboarding3Step1Description;
  String get onboarding3Step2Title;
  String get onboarding3Step2Description;

  // Security strings
  String get appLocked;
  String get unlock;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'ko', 'es', 'pl', 'lt', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'ko': return AppLocalizationsKo();
    case 'es': return AppLocalizationsEs();
    case 'pl': return AppLocalizationsPl();
    case 'lt': return AppLocalizationsLt();
    case 'uk': return AppLocalizationsUk();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale".'
  );
}
