import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String get helloWorld {
    return Intl.message(
      'Hello, World!',
      name: 'helloWorld',
      locale: locale.toString(),
    );
  }

// Define more localized strings here
}