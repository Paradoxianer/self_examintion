import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/widgets/chart_control_widget.dart';
import 'package:self_examination/widgets/comparison_chart.dart';
import 'package:self_examination/widgets/radar_chart_widget.dart';
import 'package:self_examination/widgets/time_chart_widget.dart';
import 'package:self_examination/screens/settings_screen.dart';
import 'package:self_examination/widgets/question_set_selection.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  final LocalStorage _localStorage = LocalStorage();
  late PageController _pageController;
  
  List<bool> _selectedQuestions = [];
  TimeRange _currentTimeRange = TimeRange.all;
  DateTime _referenceDate = DateTime.now();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = _localStorage.getInt('lastChartIndex', defaultValue: 0);
    _pageController = PageController(initialPage: _currentPage);
    _initializeState();
  }

  void _initializeState() async {
    final history = await _localStorage.loadAssessmentEntries();
    if (history.isNotEmpty && mounted) {
      final int questionCount = history[0].values.length + 1; // +1 for average
      
      // Load saved selection or default to all true
      List<bool>? savedSelection = _localStorage.getBoolList('chartSelectedQuestions');
      if (savedSelection == null || savedSelection.length != questionCount) {
        savedSelection = List.generate(questionCount, (index) => true);
      }

      // Load saved time range
      String? savedRange = _localStorage.getString('chartTimeRange');
      TimeRange range = TimeRange.all;
      if (savedRange != null) {
        range = TimeRange.values.firstWhere((e) => e.toString() == savedRange, orElse: () => TimeRange.all);
      }

      setState(() {
        _selectedQuestions = savedSelection!;
        _currentTimeRange = range;
        _referenceDate = history.last.timestamp;
      });
    }
  }

  void _saveSettings() {
    _localStorage.setBoolList('chartSelectedQuestions', _selectedQuestions);
    _localStorage.setString('chartTimeRange', _currentTimeRange.toString());
    _localStorage.setInt('lastChartIndex', _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _localStorage.assessmentNotifier,
      builder: (context, _) {
        return FutureBuilder<List<AssessmentEntry>>(
          future: _localStorage.loadAssessmentEntries(),
          builder: (context, snapshot) {
            final history = snapshot.data ?? [];
            final localization = AppLocalizations.of(context)!;

            if (history.isEmpty) {
              return Scaffold(
                appBar: AppBar(title: QuestionSetSelection()),
                body: Center(child: Text(localization.noHistory)),
              );
            }

            if (_selectedQuestions.isEmpty && history.isNotEmpty) {
               _selectedQuestions = List.generate(history[0].values.length + 1, (index) => true);
               _referenceDate = history.last.timestamp;
            }

            return Scaffold(
              appBar: AppBar(
                title: QuestionSetSelection(),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SettingsScreen()),
                      );
                    },
                  ),
                ],
              ),
              body: OrientationBuilder(
                builder: (context, orientation) {
                  if (orientation == Orientation.portrait) {
                    return Column(
                      children: [
                        _buildChartCarousel(history),
                        _buildPageIndicator(),
                        const Divider(height: 1),
                        Expanded(
                          flex: 3,
                          child: _buildControls(history),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            children: [
                              Expanded(child: _buildChartCarousel(history)),
                              _buildPageIndicator(),
                            ],
                          ),
                        ),
                        const VerticalDivider(width: 1),
                        Expanded(
                          flex: 4,
                          child: _buildControls(history),
                        ),
                      ],
                    );
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildChartCarousel(List<AssessmentEntry> history) {
    return SizedBox(
      height: 300,
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
          _saveSettings();
        },
        children: [
          TimeChartWidget(
            assessmentHistory: history,
            selectedQuestions: _selectedQuestions,
            currentTimeRange: _currentTimeRange,
            referenceDate: _referenceDate,
          ),
          ComparisonChartWidget(
            assessmentHistory: history,
            selectedQuestions: _selectedQuestions,
            currentTimeRange: _currentTimeRange,
            referenceDate: _referenceDate,
          ),
          RadarChartWidget(
            assessmentHistory: history,
            selectedQuestions: _selectedQuestions,
            currentTimeRange: _currentTimeRange,
            referenceDate: _referenceDate,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Theme.of(context).primaryColor : Colors.grey.shade300,
          ),
        )),
      ),
    );
  }

  Widget _buildControls(List<AssessmentEntry> history) {
    return ChartControlWidget(
      assessmentHistory: history,
      selectedQuestions: _selectedQuestions,
      currentTimeRange: _currentTimeRange,
      showAverage: true,
      onQuestionToggle: (index, value) {
        setState(() => _selectedQuestions[index] = value);
        _saveSettings();
      },
      onTimeRangeChange: (range) {
        setState(() {
          _currentTimeRange = range;
          _referenceDate = history.isNotEmpty ? history.last.timestamp : DateTime.now();
        });
        _saveSettings();
      },
      onNavigateTime: (next) {
        setState(() {
          int factor = next ? 1 : -1;
          switch (_currentTimeRange) {
            case TimeRange.twoDays:
              _referenceDate = _referenceDate.add(Duration(days: 2 * factor));
              break;
            case TimeRange.week:
              _referenceDate = _referenceDate.add(Duration(days: 7 * factor));
              break;
            case TimeRange.month:
              _referenceDate = DateTime(_referenceDate.year, _referenceDate.month + factor, 1);
              break;
            case TimeRange.year:
              _referenceDate = DateTime(_referenceDate.year + factor, 1, 1);
              break;
            case TimeRange.all:
              break;
          }
        });
      },
      onTodayPressed: () {
        setState(() => _referenceDate = history.isNotEmpty ? history.last.timestamp : DateTime.now());
      },
    );
  }
}
