import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/question.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:url_launcher/url_launcher.dart';


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
              flex: 2,
              child: Tooltip(
                message: widget.question.description ?? '',
                child: Text(
                  widget.question.text,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            Flexible(
              child: Wrap(
                spacing: 9.0,
                children: [
                  widget.question.tips != null ? Center(
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {
                        _showTipsDialog(context, widget.question.tips ?? '');
                      },
                    ),
                  ) : Container(),
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
                ],
              ),
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
        // Use a RichText widget to allow for mixed-style text
        tipWidgets.add(
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: _getRichTextSpans(context, line),
            ),
          ),
        );

        // Add a padding between lines
        tipWidgets.add(SizedBox(height: 8));
      }
    }

    return tipWidgets;
  }

// This function creates a list of TextSpans for a given line
  List<TextSpan> _getRichTextSpans(BuildContext context, String line) {
    RegExp linkPattern = RegExp(r'\[(.+?)\]\((\S+?)\)');

    List<TextSpan> spans = [];
    int start = 0;

    for (final match in linkPattern.allMatches(line)) {
      final String precedingText = line.substring(start, match.start);
      if (precedingText.isNotEmpty) {
        spans.add(TextSpan(text: precedingText));
      }

      final String linkText = match.group(1)!;
      final String linkUrl = match.group(2)!;

      spans.add(
        TextSpan(
          text: linkText,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()..onTap = () {
            _launchURL(linkUrl);
          },
        ),
      );

      start = match.end;
    }

    final String remainingText = line.substring(start);
    if (remainingText.isNotEmpty) {
      spans.add(TextSpan(text: remainingText));
    }

    return spans;
  }

// Function to launch URLs
  void _launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      // Handle the error or display a message
      print('Could not launch $url');
    }
  }
}
