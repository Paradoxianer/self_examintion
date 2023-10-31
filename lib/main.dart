import 'package:flutter/material.dart';
import 'package:self_examintion/screens/home_screen.dart';
import 'package:self_examintion/utils/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorage = LocalStorage();
  await localStorage.initialize();
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}