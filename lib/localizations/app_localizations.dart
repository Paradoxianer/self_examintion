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

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('ko'),
    Locale('es'),
  ];

  /// The greeting shown at the home screen
  ///
  /// In de, this message translates to:
  /// **'Willkommen zum Selbstprüfungs-Tool'**
  String get greetings;

  /// No description provided for @start.
  ///
  /// In de, this message translates to:
  /// **'Starten'**
  String get start;

  /// No description provided for @results.
  ///
  /// In de, this message translates to:
  /// **'Ergebnisse'**
  String get results;

  /// No description provided for @settings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settings;

  /// No description provided for @examinTitle.
  ///
  /// In de, this message translates to:
  /// **'Selbst-Prüfung'**
  String get examinTitle;

  /// No description provided for @noteHint.
  ///
  /// In de, this message translates to:
  /// **'Notizen hinzufügen..'**
  String get noteHint;

  /// No description provided for @pleasAnswer.
  ///
  /// In de, this message translates to:
  /// **'Bitte beantworten sie alle Fragen.'**
  String get pleasAnswer;

  /// No description provided for @commit.
  ///
  /// In de, this message translates to:
  /// **'Fertig'**
  String get commit;

  /// No description provided for @saved.
  ///
  /// In de, this message translates to:
  /// **'Daten gespeichert'**
  String get saved;

  /// No description provided for @chartTitle.
  ///
  /// In de, this message translates to:
  /// **'Entwicklungsdiagramm'**
  String get chartTitle;

  /// No description provided for @noHistory.
  ///
  /// In de, this message translates to:
  /// **'Keine Daten von vergangenen Selbstprüfungfragen gefunden. Bitte wähle ein anderes Fragenset aus oder füllle die Fragen aus.'**
  String get noHistory;

  /// No description provided for @warningTitle.
  ///
  /// In de, this message translates to:
  /// **'Warnung'**
  String get warningTitle;

  /// A warning dialog that all answers for the questions of this author will be deleted
  ///
  /// In de, this message translates to:
  /// **'Alle gespeicherten Fortschritte für {autor} werden gelöscht und für immer verloren gehen. Möchten Sie fortfahren?'**
  String warningDel(String autor, Object author);

  /// No description provided for @settingsTitle.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settingsTitle;

  /// No description provided for @chooseQuestionSet.
  ///
  /// In de, this message translates to:
  /// **'Fragenset wählen'**
  String get chooseQuestionSet;

  /// No description provided for @delete.
  ///
  /// In de, this message translates to:
  /// **'Daten löschen'**
  String get delete;

  /// No description provided for @notification.
  ///
  /// In de, this message translates to:
  /// **'Erinnere mich daran'**
  String get notification;

  /// No description provided for @notificationFrequency.
  ///
  /// In de, this message translates to:
  /// **'Häufigkeit'**
  String get notificationFrequency;

  /// No description provided for @daily.
  ///
  /// In de, this message translates to:
  /// **'täglich'**
  String get daily;

  /// No description provided for @weekly.
  ///
  /// In de, this message translates to:
  /// **'wöchentlich'**
  String get weekly;

  /// No description provided for @monthly.
  ///
  /// In de, this message translates to:
  /// **'monatlich'**
  String get monthly;

  /// No description provided for @datasecurityDialog.
  ///
  /// In de, this message translates to:
  /// **'DSGVO Dialog'**
  String get datasecurityDialog;

  /// No description provided for @dsgvoNo.
  ///
  /// In de, this message translates to:
  /// **'Zustimmung verweigert'**
  String get dsgvoNo;

  /// No description provided for @dsgvoNoInfo.
  ///
  /// In de, this message translates to:
  /// **'Die App kann leider nur funktionieren, wenn Sie zustimmen.'**
  String get dsgvoNoInfo;

  /// No description provided for @ok.
  ///
  /// In de, this message translates to:
  /// **'ok'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In de, this message translates to:
  /// **'cancel'**
  String get cancel;

  /// No description provided for @dsgvoTitle.
  ///
  /// In de, this message translates to:
  /// **'Datenschutz und Zustimmung'**
  String get dsgvoTitle;

  /// No description provided for @dsgvo1.
  ///
  /// In de, this message translates to:
  /// **'Um Ihre persönliche geistliche Entwicklung zu verfolgen, speichern wir Ihre Antworten auf die gestellten Fragen. Diese Daten werden anonymisiert und lokal auf Ihrem Gerät gespeichert.'**
  String get dsgvo1;

  /// No description provided for @dsgvo2.
  ///
  /// In de, this message translates to:
  /// **'Bitte beachten Sie, dass Personen, die Zugriff auf Ihr Gerät und die App haben, möglicherweise auf diese Daten zugreifen können.'**
  String get dsgvo2;

  /// No description provided for @dsgvo3.
  ///
  /// In de, this message translates to:
  /// **'Indem Sie unten auf \"Zustimmen\" klicken, erklären Sie sich damit einverstanden, dass Ihre Daten wie oben beschrieben gespeichert werden. Wenn Sie nicht zustimmen, werden keine Daten erfasst, aber die App kann auch nicht funktionieren.'**
  String get dsgvo3;

  /// No description provided for @dsgvoOK.
  ///
  /// In de, this message translates to:
  /// **'Zustimmen'**
  String get dsgvoOK;

  /// No description provided for @dsgvoCancel.
  ///
  /// In de, this message translates to:
  /// **'Widersprechen'**
  String get dsgvoCancel;

  /// No description provided for @dsgvoYes.
  ///
  /// In de, this message translates to:
  /// **'Zustimmung erteilt'**
  String get dsgvoYes;

  /// No description provided for @close.
  ///
  /// In de, this message translates to:
  /// **'Schließen'**
  String get close;

  /// In de, this message translates to:
  /// **'Gesamt'**
  String get total;

  String get compareChart;

  String get timeChart;

  List<String> get rating;

  //returns a localized List of the wighted anservalues
  List<String> get answers;

  List<String> get frequenze;


  //returns a localized Mag of SelfassementQuestions
  Map<String, SelfAssessmentQuestionSet> get questionMap;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'ko', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'ko': return AppLocalizationsKo();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
          'an issue with the localizations generation tool. Please file an issue '
          'on GitHub with a reproducible sample app and the gen-l10n configuration '
          'that was used.'
  );
}
