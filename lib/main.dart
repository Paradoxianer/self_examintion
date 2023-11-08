import 'package:flutter/material.dart';
import 'package:self_examintion/screens/home_screen.dart';
import 'package:self_examintion/utils/local_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorage = LocalStorage();
  await localStorage.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // Add your custom localization delegates here if needed.
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('de', 'DE'), // German
        // Add more supported locales if needed.
      ],
      // Add more MaterialApp configurations as needed.
      home: HomeScreen()
    );
  }
}
