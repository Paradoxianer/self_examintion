import 'package:flutter/material.dart';
import 'package:self_examintion/localizations/app_localizations.dart';
import 'package:self_examintion/models/question.dart';
import 'package:self_examintion/utils/globals.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final int cardNumber;
  final ValueChanged<double> onSliderChanged; // Receive callback

  QuestionCard(
      {required this.cardNumber,
        required this.question,
        required this.onSliderChanged}) // Receive callback
      : super(key: ValueKey<int>(cardNumber)); // Use a key to maintain widget identity

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  double _sliderValue = 2.0;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.question.answer.toDouble();
    if (_sliderValue == 0) _sliderValue = 2.0;
  }

  @override
  Widget build(BuildContext context) {
    Color sliderColor = widget.question.isPositive
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
              child: Tooltip(
                message: widget.question.description ?? '',
                child: Text(
                  widget.question.text,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            widget.question.tips != null ? IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                _showTipsDialog(context, widget.question.tips ?? '');
              },
            ) : Container(),
            Row(
              children: [
         //       Text(AppLocalizations.of(context)!.answers[0]),
                SliderTheme(
                  child: Slider(
                      value: _sliderValue,
                      onChanged: (newValue) {
                        setState(() {
                          _sliderValue = newValue;
                          widget.onSliderChanged(newValue); // Call the callback to update slider value
                        });
                      },
                      min: 1,
                      max: 4,
                      divisions: 3,
                      activeColor: sliderColor,
                      inactiveColor: sliderColor,
                      label: AppLocalizations.of(context)!.answers[_sliderValue.toInt() - 1],
                    ),
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 5.0
                  ),
                ),
           //     Text(AppLocalizations.of(context)!.answers.last,softWrap: true,)
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTipsDialog(BuildContext context, String tips) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tipps'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildTipWidgets(context, tips),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Schließen'),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildTipWidgets(BuildContext context, String tips) {
    List<Widget> tipWidgets = [];

    // Split the tips string into lines
    List<String> lines = tips.split('\n');

    for (String line in lines) {
      if (line.isNotEmpty) {
        // Check if the line contains a clickable link
        final linkMatch = RegExp(r'\[(.+?)\]\((\S+?)\)').firstMatch(line);
        if (linkMatch != null) {
          String linkText = linkMatch.group(1)!;
          String linkUrl = linkMatch.group(2)!;

          tipWidgets.add(
            InkWell(
              onTap: () {
                // Open the link when tapped
                // Note: You can implement your own logic to open the link
                // e.g., launch(linkUrl)
              },
              child: Text(
                linkText,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          );
        } else {
          // Regular text without a clickable link
          tipWidgets.add(Text(line));
        }

        // Add a padding between lines
        tipWidgets.add(SizedBox(height: 8));
      }
    }

    return tipWidgets;
  }
}
