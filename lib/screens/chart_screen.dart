import 'dart:ui';
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

/// A screen that displays assessment results through various interactive charts.
/// Supports swiping between Timeline, Comparison, and Radar views.
class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  final LocalStorage _localStorage = LocalStorage();
  late PageController _pageController;
  Future<List<AssessmentEntry>>? _historyFuture;

  List<bool> _selectedQuestions = [];
  TimeRange _currentTimeRange = TimeRange.all;
  DateTime _referenceDate = DateTime.now();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = _localStorage.getInt('lastChartIndex', defaultValue: 0);
    _pageController = PageController(initialPage: _currentPage);
    _loadStoredFilters();
    _loadHistory();
  }

  void _loadHistory() {
    _historyFuture = _localStorage.loadAssessmentEntries();
  }

  void _loadStoredFilters() {
    String? savedRange = _localStorage.getString('chartTimeRange');
    if (savedRange != null) {
      _currentTimeRange = TimeRange.values.firstWhere(
        (e) => e.toString() == savedRange, 
        orElse: () => TimeRange.all
      );
    }
  }

  /// Saves the current chart configuration to local storage using author-specific keys.
  void _saveSettings() {
    final authorKey = _localStorage.getCurrentAuthor();
    _localStorage.setBoolList('chartSelectedQuestions_$authorKey', _selectedQuestions);
    _localStorage.setString('chartTimeRange', _currentTimeRange.toString());
    _localStorage.setInt('lastChartIndex', _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _localStorage.assessmentNotifier,
      builder: (context, _) {
        // Refresh future when assessment changes
        _loadHistory();
        
        return FutureBuilder<List<AssessmentEntry>>(
          future: _historyFuture,
          builder: (context, snapshot) {
            final history = snapshot.data ?? [];
            final localization = AppLocalizations.of(context)!;

            if (snapshot.connectionState == ConnectionState.waiting && history.isEmpty) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (history.isEmpty) {
              return Scaffold(
                appBar: AppBar(title: const QuestionSetSelection()),
                body: Center(child: Text(localization.noHistory)),
              );
            }

            // Sync selectedQuestions with the current author's specific settings
            final authorKey = _localStorage.getCurrentAuthor();
            final int expectedLength = history[0].values.length + 1;
            final String storageKey = 'chartSelectedQuestions_$authorKey';
            
            // Check if we need to switch or initialize the selection list
            if (_selectedQuestions.length != expectedLength) {
              List<bool>? savedSelection = _localStorage.getBoolList(storageKey);
              
              if (savedSelection != null && savedSelection.length == expectedLength) {
                _selectedQuestions = savedSelection;
              } else {
                // Default: all selected for a new or uninitialized set
                _selectedQuestions = List.generate(expectedLength, (index) => true);
              }
              _referenceDate = history.last.timestamp;
            }

            return Scaffold(
              appBar: AppBar(
                title: const QuestionSetSelection(),
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
                  return orientation == Orientation.portrait
                      ? Column(
                          children: [
                            _buildChartCarousel(history),
                            _buildPageIndicator(),
                            const Divider(height: 1),
                            Expanded(flex: 3, child: _buildControls(history)),
                          ],
                        )
                      : Row(
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
                            Expanded(flex: 4, child: _buildControls(history)),
                          ],
                        );
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
      child: Stack(
        children: [
          PageView(
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
          // Navigation arrows remain the same...
          if (_currentPage > 0)
            _buildNavArrow(Icons.chevron_left, Alignment.centerLeft, () => _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            )),
          if (_currentPage < 2)
            _buildNavArrow(Icons.chevron_right, Alignment.centerRight, () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            )),
        ],
      ),
    );
  }

  Widget _buildNavArrow(IconData icon, Alignment alignment, VoidCallback onPressed) {
     return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.5),
          child: IconButton(
            icon: Icon(icon),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            3,
            (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8, height: 8,
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
      onToggleAll: (value) {
        setState(() {
          for (int i = 0; i < _selectedQuestions.length; i++) {
            _selectedQuestions[i] = value;
          }
        });
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
