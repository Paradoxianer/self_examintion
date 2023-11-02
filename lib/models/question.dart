import 'dart:convert';
import 'package:crypto/crypto.dart';

class Question {
  final String id; // Eindeutige ID der Frage, generiert aus dem Text
  final String text; // Der Text der Frage
  final String? description = null;
  final bool isNegative;
  final String? tipps = null;
  int answer; // Die vom Benutzer gegebene Antwort (1-4)

  Question({
    required this.text,
    this.isNegative=false,
    this.answer = 0, // Standardmäßig keine Antwort
  }) : id = generateIdFromText(text); // Automatische Generierung der ID aus dem Text

  // Konvertiert die Frage in ein Map-Objekt für die Speicherung in der lokalen Datenbank
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'isNegative': isNegative,
      'answer': answer,
    };
  }

  // Erstellt eine Frage aus einem Map-Objekt, z.B. beim Laden aus der Datenbank
  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      text: map['text'],
      answer: map['answer'],
    );
  }

  // Hilfsfunktion zur automatischen Generierung der ID aus dem Text
  static String generateIdFromText(String text) {
    final bytes = utf8.encode(text); // Text in Bytes konvertieren
    final hash = sha256.convert(bytes); // SHA-256 Hash berechnen
    return hash.toString();
  }
}
