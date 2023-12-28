import 'dart:convert';
import 'package:crypto/crypto.dart';

class Question {
  final String id; // Eindeutige ID der Frage, generiert aus dem Text
  final String text; // Der Text der Frage
  final String? description; // Beschreibung der Frage
  final bool isPositive;
  final String? tips; // Tipps um besser zu werden in der entsprechenden Frage
  int answer; // Die vom Benutzer gegebene Antwort (1-4)

  Question({
    required this.text,
    this.description,
    this.isPositive = false, // Umgekehrte Logik für isPositive
    this.tips,
    this.answer = 0, // Standardmäßig keine Antwort
  }) : id = generateIdFromText(text); // Automatische Generierung der ID aus dem Text

  // Konvertiert die Frage in ein Map-Objekt für die Speicherung in der lokalen Datenbank
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'description': description,
      'isPositive': isPositive,
      'tips': tips,
      'answer': answer,
    };
  }

  // Erstellt eine Frage aus einem Map-Objekt, z.B. beim Laden aus der Datenbank
  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      text: map['text'],
      description: map['description'],
      isPositive: map['isPositive'],
      tips: map['tips'],
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
