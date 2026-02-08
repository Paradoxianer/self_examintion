import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Represents a single self-examination question.
class Question {
  /// Unique identifier generated from the question text.
  final String id;
  /// The actual question text shown to the user.
  final String text;
  /// Optional detailed description or biblical reference.
  final String? description;
  /// If true, 100% is considered 'bad' (red), otherwise 'good' (green).
  final bool isPositive;
  /// Optional helpful tips or markdown links.
  final String? tips;
  /// The user's answer from 0.0 (0%) to 1.0 (100%). -1.0 means unanswered.
  double value;
  /// Optional personal note for this specific answer.
  String? note;

  Question({
    required this.text,
    this.description,
    this.isPositive = false,
    this.tips,
    this.value = -1.0,
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
      isPositive: map['isPositive'] ?? false,
      tips: map['tips'],
      value: (map['value'] as num?)?.toDouble() ?? -1.0,
      note: map['note'],
    );
  }

  /// Generates a SHA-256 hash from the question text to use as a stable ID.
  static String generateIdFromText(String text) {
    final bytes = utf8.encode(text);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }
}
