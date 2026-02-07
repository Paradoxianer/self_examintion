import 'dart:convert';
import 'package:crypto/crypto.dart';

class Question {
  final String id;
  final String text;
  final String? description;
  final bool isPositive;
  final String? tips;
  double value; // 0.0 bis 1.0 (entspricht 0-100%)
  String? note; // Notiz zu dieser spezifischen Frage

  Question({
    required this.text,
    this.description,
    this.isPositive = false,
    this.tips,
    this.value = -1.0, // -1.0 = noch nicht beantwortet
    this.note,
  }) : id = generateIdFromText(text);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'description': description,
      'isPositive': isPositive,
      'tips': tips,
      'value': value,
      'note': note,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      text: map['text'],
      description: map['description'],
      isPositive: map['isPositive'],
      tips: map['tips'],
      value: (map['value'] as num?)?.toDouble() ?? -1.0,
      note: map['note'],
    );
  }

  static String generateIdFromText(String text) {
    final bytes = utf8.encode(text);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }
}
