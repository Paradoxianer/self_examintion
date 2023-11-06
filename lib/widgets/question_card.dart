import 'package:flutter/material.dart';
import 'package:self_examintion/models/question.dart';
import 'package:self_examintion/utils/globals.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final int cardNumber;

  QuestionCard({required this.cardNumber, required this.question});

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  double _sliderValue = 2; // Standardwert für den Slider

  @override
  Widget build(BuildContext context) {
    Color sliderColor = widget.question.isNegative
        ? Color.lerp(Colors.green, Colors.red, _sliderValue / 4) ?? Colors.green
        : Color.lerp(Colors.red, Colors.green, _sliderValue / 4) ?? Colors.red;


    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Card(
              color: globalColorMap[widget.cardNumber + 1]!.withOpacity(0.50),
              margin: EdgeInsets.fromLTRB(2.0, 2.0, 16, 2.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.cardNumber.toString(),
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                widget.question.text,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Slider(
              value: _sliderValue,
              onChanged: (newValue) {
                setState(() {
                  _sliderValue = newValue;
                  // Speichere den Wert im Question-Objekt
                  widget.question.answer = _sliderValue.toInt();
                });
              },
              min: 1,
              max: 4,
              divisions: 3,
              activeColor: sliderColor,
              inactiveColor: sliderColor.withOpacity(0.5),
              label: answers[_sliderValue]
            ),
          ],
        ),
      ),
    );
  }
}
