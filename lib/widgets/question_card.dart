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
  late double _sliderValue;
  bool _showNote = false;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.question.value;
    if (_sliderValue == -1.0) _sliderValue = 0.5;
    _noteController = TextEditingController(text: widget.question.note);
    _showNote = widget.question.note?.isNotEmpty ?? false;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(QuestionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      setState(() {
        _sliderValue = widget.question.value;
        if (_sliderValue == -1.0) _sliderValue = 0.5;
        _noteController.text = widget.question.note ?? '';
        _showNote = widget.question.note?.isNotEmpty ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    bool isAnswered = widget.question.value != -1.0;
    
    Color sliderColor;
    if (!isAnswered) {
      sliderColor = Colors.grey;
    } else {
      if (widget.question.isPositive) {
        sliderColor = Color.lerp(Colors.red, Colors.green, _sliderValue) ?? Colors.green;
      } else {
        sliderColor = Color.lerp(Colors.green, Colors.red, _sliderValue) ?? Colors.red;
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 2,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: globalColorMap[widget.cardNumber]?.withOpacity(0.5) ?? Colors.blue.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(25)),
                ),
                child: Center(
                  child: Text(
                    widget.cardNumber.toString(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Tooltip(
                              message: widget.question.description ?? '',
                              child: Text(
                                widget.question.text,
                                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(_showNote ? Icons.note : Icons.note_add_outlined, size: 20, color: _showNote ? Theme.of(context).primaryColor : null),
                            onPressed: () {
                              setState(() {
                                _showNote = !_showNote;
                              });
                            },
                          ),
                          if (widget.question.tips != null)
                            IconButton(
                              icon: const Icon(Icons.info_outline, size: 20),
                              onPressed: () => _showTipsDialog(context, widget.question.tips!),
                            ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 8.0,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
                          valueIndicatorShape: const RectangularSliderValueIndicatorShape(),
                          valueIndicatorColor: sliderColor,
                          valueIndicatorTextStyle: const TextStyle(color: Colors.white),
                        ),
                        child: Column(
                          children: [
                            Slider(
                              value: _sliderValue,
                              onChanged: (newValue) {
                                setState(() {
                                  _sliderValue = newValue;
                                  widget.onSliderChanged(newValue);
                                });
                              },
                              min: 0.0,
                              max: 1.0,
                              activeColor: sliderColor,
                              inactiveColor: sliderColor.withOpacity(0.2),
                              label: "${(_sliderValue * 100).round()}%",
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(localization.answers.first, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                  Text(localization.answers.last, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_showNote)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: TextField(
                controller: _noteController,
                decoration: InputDecoration(
                  hintText: localization.noteHint,
                  isDense: true,
                  border: const OutlineInputBorder(),
                ),
                maxLines: null,
                onChanged: (value) {
                  widget.question.note = value;
                },
              ),
            ),
        ],
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
