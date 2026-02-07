import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/question.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:url_launcher/url_launcher.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final int cardNumber;
  final ValueChanged<double> onSliderChanged;

  const QuestionCard({
    super.key,
    required this.cardNumber,
    required this.question,
    required this.onSliderChanged,
  });

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
  void didUpdateWidget(QuestionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      setState(() {
        _sliderValue = widget.question.answer.toDouble();
        if (_sliderValue == 0) _sliderValue = 2.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color sliderColor = widget.question.isPositive
        ? Color.lerp(Colors.green, Colors.red, _sliderValue / 4) ?? Colors.green
        : Color.lerp(Colors.red, Colors.green, _sliderValue / 4) ?? Colors.red;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Container(
              width: 60,
              color: globalColorMap[widget.cardNumber]!.withValues(alpha: 0.50),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.cardNumber.toString(),
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, right: 4.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Tooltip(
                            message: widget.question.description ?? '',
                            child: Text(
                              widget.question.text,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        if (widget.question.tips != null)
                          IconButton(
                            icon: const Icon(Icons.info),
                            onPressed: () => _showTipsDialog(context, widget.question.tips!),
                          ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(trackHeight: 5.0),
                      child: Slider(
                        value: _sliderValue,
                        onChanged: (newValue) {
                          setState(() {
                            _sliderValue = newValue;
                            widget.onSliderChanged(newValue);
                          });
                        },
                        min: 1,
                        max: 4,
                        divisions: 3,
                        activeColor: sliderColor,
                        inactiveColor: sliderColor.withValues(alpha: 0.3),
                        label: AppLocalizations.of(context)!.answers[_sliderValue.toInt() - 1],
                      ),
                    ),
                  ],
                ),
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
          title: const Text('Tipps'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildTipWidgets(context, tips),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Schließen'),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildTipWidgets(BuildContext context, String tips) {
    List<Widget> tipWidgets = [];
    List<String> lines = tips.split('\n');

    for (String line in lines) {
      if (line.isNotEmpty) {
        tipWidgets.add(
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: _getRichTextSpans(context, line),
            ),
          ),
        );
        tipWidgets.add(const SizedBox(height: 8));
      }
    }
    return tipWidgets;
  }

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
          recognizer: TapGestureRecognizer()
            ..onTap = () => _launchURL(linkUrl),
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

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $url');
    }
  }
}
