import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/widgets/chart_control_widget.dart';

class TimeChartWidget extends StatefulWidget {
  final List<AssessmentEntry> assessmentHistory;

  const TimeChartWidget({super.key, required this.assessmentHistory});

  @override
  _TimeChartWidgetState createState() => _TimeChartWidgetState();
}

class _TimeChartWidgetState extends State<TimeChartWidget> {
  List<bool> selectedQuestions = [];
  TimeRange _currentTimeRange = TimeRange.all;
  DateTime _referenceDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.assessmentHistory.isNotEmpty) {
      selectedQuestions = List.generate(
        widget.assessmentHistory[0].values.length,
        (index) => true,
      );
      // Start with the latest available date in history
      _referenceDate = widget.assessmentHistory.last.timestamp;
    }
  }

  // Logic to calculate the time window
  DateTime get _windowStart {
    switch (_currentTimeRange) {
      case TimeRange.twoDays:
        return DateTime(_referenceDate.year, _referenceDate.month, _referenceDate.day - 1);
      case TimeRange.week:
        return _referenceDate.subtract(const Duration(days: 6));
      case TimeRange.month:
        return DateTime(_referenceDate.year, _referenceDate.month - 1, _referenceDate.day);
      case TimeRange.year:
        return DateTime(_referenceDate.year - 1, _referenceDate.month, _referenceDate.day);
      case TimeRange.all:
        return widget.assessmentHistory.isNotEmpty 
            ? widget.assessmentHistory.first.timestamp 
            : _referenceDate.subtract(const Duration(days: 30));
    }
  }

  DateTime get _windowEnd {
    if (_currentTimeRange == TimeRange.all) {
      return widget.assessmentHistory.isNotEmpty 
          ? widget.assessmentHistory.last.timestamp 
          : _referenceDate;
    }
    return _referenceDate;
  }

  void _navigateTime(bool next) {
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
          _referenceDate = DateTime(_referenceDate.year, _referenceDate.month + factor, _referenceDate.day);
          break;
        case TimeRange.year:
          _referenceDate = DateTime(_referenceDate.year + factor, _referenceDate.month, _referenceDate.day);
          break;
        case TimeRange.all:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.assessmentHistory.isEmpty) {
      return const Center(child: Text("No data available"));
    }

    // Filter history based on current window
    final filteredHistory = widget.assessmentHistory.where((entry) {
      return entry.timestamp.isAfter(_windowStart.subtract(const Duration(seconds: 1))) &&
             entry.timestamp.isBefore(_windowEnd.add(const Duration(seconds: 1)));
    }).toList();

    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: LineChart(
              LineChartData(
                minX: _windowStart.millisecondsSinceEpoch.toDouble(),
                maxX: _windowEnd.millisecondsSinceEpoch.toDouble(),
                minY: 0,
                maxY: 1.1,
                lineBarsData: [
                  LineChartBarData(
                    spots: getOverallScores(filteredHistory),
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 4,
                    dotData: const FlDotData(show: false),
                  ),
                  for (int i = 0; i < selectedQuestions.length; i++)
                    if (selectedQuestions[i])
                      LineChartBarData(
                        spots: getQuestionScores(filteredHistory, i),
                        isCurved: true,
                        color: globalColorMap[i + 1] ?? Colors.blue,
                        barWidth: 2,
                        dotData: const FlDotData(show: false),
                      ),
                ],
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: (_windowEnd.difference(_windowStart).inMilliseconds / 5),
                      getTitlesWidget: (value, meta) => bottomTitleWidgets(value, meta, context),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) => leftTitleWidgets(value, meta, context),
                    ),
                  ),
                ),
                borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.shade300)),
                gridData: const FlGridData(show: true, horizontalInterval: 0.2, drawVerticalLine: false),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          "${(spot.y * 100).round()}%",
                          TextStyle(color: spot.bar.color, fontWeight: FontWeight.bold),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          flex: 4,
          child: ChartControlWidget(
            assessmentHistory: widget.assessmentHistory,
            selectedQuestions: selectedQuestions,
            currentTimeRange: _currentTimeRange,
            onQuestionToggle: (index, value) {
              setState(() {
                selectedQuestions[index] = value;
              });
            },
            onTimeRangeChange: (range) {
              setState(() {
                _currentTimeRange = range;
                if (range == TimeRange.all) {
                   _referenceDate = widget.assessmentHistory.last.timestamp;
                }
              });
            },
            onNavigateTime: _navigateTime,
          ),
        ),
      ],
    );
  }

  List<FlSpot> getOverallScores(List<AssessmentEntry> history) {
    return history.map((entry) {
      double avg = 0;
      int count = 0;
      for (var val in entry.values) {
        if (val != -1.0) {
          avg += val;
          count++;
        }
      }
      return FlSpot(
        entry.timestamp.millisecondsSinceEpoch.toDouble(),
        count > 0 ? avg / count : 0,
      );
    }).toList();
  }

  List<FlSpot> getQuestionScores(List<AssessmentEntry> history, int index) {
    List<FlSpot> spots = [];
    for (var entry in history) {
      if (index < entry.values.length && entry.values[index] != -1.0) {
        spots.add(FlSpot(
          entry.timestamp.millisecondsSinceEpoch.toDouble(),
          entry.values[index],
        ));
      }
    }
    return spots;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    return SideTitleWidget(
      meta: meta,
      child: Text(
        _currentTimeRange == TimeRange.year || _currentTimeRange == TimeRange.all
            ? "${date.month}.${date.year.toString().substring(2)}"
            : "${date.day}.${date.month}.",
        style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    if (value > 1.0) return const SizedBox.shrink();
    return SideTitleWidget(
      meta: meta,
      child: Text("${(value * 100).toInt()}%", style: const TextStyle(fontSize: 8)),
    );
  }
}
