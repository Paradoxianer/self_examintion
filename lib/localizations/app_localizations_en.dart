import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get greetings => 'Welcome to the selfexamination tool';

  @override
  String get start => 'Start';

  @override
  String get results => 'Results';

  @override
  String get settings => 'Settings';
}
