import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/utils/assessment_calculator.dart';
import 'package:self_examination/widgets/chart_control_widget.dart';

class ComparisonChartWidget extends StatefulWidget {
  final List<AssessmentEntry> assessmentHistory;
  final List<bool> selectedQuestions;
  final TimeRange currentTimeRange;
  final DateTime referenceDate;

  const ComparisonChartWidget({
    super.key,
    required this.assessmentHistory,
    required this.selectedQuestions,
    required this.currentTimeRange,
    required this.referenceDate,
  });

  @override
  State<ComparisonChartWidget> createState() => _ComparisonChartWidgetState();
}

class _ComparisonChartWidgetState extends State<ComparisonChartWidget> {
  DateTime? _selectedAnchorA;
  DateTime? _selectedAnchorB;

  @override
  void initState() {
    super.initState();
    _resetToDefaults();
  }

  @override
  void didUpdateWidget(ComparisonChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentTimeRange != widget.currentTimeRange || 
        oldWidget.referenceDate != widget.referenceDate) {
      _resetToDefaults();
    }
  }

  void _resetToDefaults() {
    _selectedAnchorB = widget.referenceDate;
    _selectedAnchorA = _calculateDefaultPrevious(widget.referenceDate);
  }

  DateTime _calculateDefaultPrevious(DateTime date) {
    switch (widget.currentTimeRange) {
      case TimeRange.twoDays: return date.subtract(const Duration(days: 2));
      case TimeRange.week: return date.subtract(const Duration(days: 7));
      case TimeRange.month: return DateTime(date.year, date.month - 1, 1);
      case TimeRange.year: return DateTime(date.year - 1, 1, 1);
      case TimeRange.all: return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    if (widget.assessmentHistory.isEmpty) return Center(child: Text(localization.noData));

    return Column(
      children: [
        if (widget.currentTimeRange != TimeRange.all)
          _buildPeriodSelectors(context, localization),
        const SizedBox(height: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 24, 16),
            child: BarChart(
              BarChartData(
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBorderRadius: BorderRadius.circular(8),
                    getTooltipColor: (group) => Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.98),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) => 
                        _buildCustomTooltipItem(group, groupIndex, rod, rodIndex, context, localization),
                  ),
                ),
                minY: 0,
                maxY: 1.1,
                barGroups: _getComparisonData(context),
                borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.withValues(alpha: 0.1))),
                gridData: const FlGridData(show: true, horizontalInterval: 0.2, drawVerticalLine: false),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) => _bottomTitleWidgets(value, meta, context, localization),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 45,
                      getTitlesWidget: (value, meta) => _leftTitleWidgets(value, meta, context),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _getComparisonData(BuildContext context) {
    final startA = _getPeriodStart(_selectedAnchorA!);
    final endA = _getPeriodEnd(_selectedAnchorA!);
    final startB = _getPeriodStart(_selectedAnchorB!);
    final endB = _getPeriodEnd(_selectedAnchorB!);

    final historyA = widget.assessmentHistory.where((e) => e.timestamp.isAfter(startA.subtract(const Duration(seconds: 1))) && e.timestamp.isBefore(endA.add(const Duration(seconds: 1)))).toList();
    final historyB = widget.assessmentHistory.where((e) => e.timestamp.isAfter(startB.subtract(const Duration(seconds: 1))) && e.timestamp.isBefore(endB.add(const Duration(seconds: 1)))).toList();

    List<BarChartGroupData> barGroups = [];
    if (historyB.isEmpty && historyA.isEmpty) return [];

    final int questionCount = widget.assessmentHistory.first.values.length;
    double sumAllA = 0, sumAllB = 0;
    int countAll = 0;

    for (int i = 0; i < questionCount; i++) {
      double avgA = _calculateAverage(context, historyA, i);
      double avgB = _calculateAverage(context, historyB, i);
      
      // Für den globalen Durchschnitt zählen wir immer alles
      sumAllA += avgA; 
      sumAllB += avgB;
      countAll++;

      // Aber wir fügen nur eine Gruppe hinzu, wenn die Frage ausgewählt ist
      if (i < widget.selectedQuestions.length && widget.selectedQuestions[i]) {
        final color = globalColorMap[i + 1] ?? Colors.blue;
        barGroups.add(
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(toY: avgA, color: color.withValues(alpha: 0.3), width: 10, borderRadius: const BorderRadius.vertical(top: Radius.circular(4))),
              BarChartRodData(toY: avgB, color: color, width: 10, borderRadius: const BorderRadius.vertical(top: Radius.circular(4))),
            ],
          ),
        );
      }
    }

    // Der Durchschnittsbalken wird angezeigt, wenn "Gesamt" (letzter Index) ausgewählt ist
    if (widget.selectedQuestions.isNotEmpty && widget.selectedQuestions.last && countAll > 0) {
      barGroups.add(
        BarChartGroupData(
          x: 100,
          barRods: [
            BarChartRodData(toY: sumAllA / countAll, color: Colors.red.withValues(alpha: 0.2), width: 14, borderRadius: const BorderRadius.vertical(top: Radius.circular(4))),
            BarChartRodData(toY: sumAllB / countAll, color: Colors.red, width: 14, borderRadius: const BorderRadius.vertical(top: Radius.circular(4))),
          ],
        ),
      );
    }
    return barGroups;
  }

  double _calculateAverage(BuildContext context, List<AssessmentEntry> history, int idx) {
    if (history.isEmpty) return 0.0;
    final localization = AppLocalizations.of(context)!;
    double sum = 0; int count = 0;
    for (var e in history) {
      if (idx < e.values.length && e.values[idx] != -1.0) {
        final questionSet = localization.questionMap[e.questionSet];
        bool isPositive = false;
        if (questionSet != null && idx < questionSet.questions.length) {
          isPositive = questionSet.questions[idx].isPositive;
        }
        sum += AssessmentCalculator.getChartValue(e.values[idx], isPositive);
        count++;
      }
    }
    return count > 0 ? sum / count : 0.0;
  }

  // --- Helper Methods ---
  DateTime _getPeriodStart(DateTime d) => AssessmentCalculator.getPeriodStart(d, widget.currentTimeRange);
  DateTime _getPeriodEnd(DateTime d) => AssessmentCalculator.getPeriodEnd(d, widget.currentTimeRange);

  Widget _buildPeriodSelectors(BuildContext context, AppLocalizations localization) {
    final periods = _getAvailablePeriods();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDropdown(_selectedAnchorA!, (val) => setState(() => _selectedAnchorA = val), Colors.grey, periods, localization),
          Icon(Icons.compare_arrows, color: Theme.of(context).colorScheme.primary, size: 24),
          _buildDropdown(_selectedAnchorB!, (val) => setState(() => _selectedAnchorB = val), Theme.of(context).primaryColor, periods, localization),
        ],
      ),
    );
  }

  List<DateTime> _getAvailablePeriods() {
    final Set<String> uniqueKeys = {};
    final List<DateTime> distinctDates = [];
    for (var entry in widget.assessmentHistory) {
      String key = _getPeriodKey(entry.timestamp);
      if (uniqueKeys.add(key)) distinctDates.add(entry.timestamp);
    }
    distinctDates.sort((a, b) => b.compareTo(a));
    return distinctDates;
  }

  String _getPeriodKey(DateTime date) {
    switch (widget.currentTimeRange) {
      case TimeRange.twoDays: return "${date.year}-${date.month}-${date.day}";
      case TimeRange.week: return "${date.year}-W${AssessmentCalculator.getIsoWeek(date)}";
      case TimeRange.month: return "${date.year}-${date.month}";
      case TimeRange.year: return "${date.year}";
      default: return "all";
    }
  }

  Widget _buildDropdown(DateTime currentValue, ValueChanged<DateTime?> onChanged, Color color, List<DateTime> dates, AppLocalizations localization) {
    return DropdownButton<DateTime>(
      value: dates.firstWhere((d) => _getPeriodKey(d) == _getPeriodKey(currentValue), orElse: () => dates.first),
      onChanged: onChanged,
      items: dates.map((date) => DropdownMenuItem<DateTime>(
        value: date,
        child: Text(DateFormat.yMd().format(date), style: TextStyle(color: color, fontSize: 12)),
      )).toList(),
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta, BuildContext context, AppLocalizations localization) {
    if (value == 100) return SideTitleWidget(meta: meta, child: Text(localization.total, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)));
    return SideTitleWidget(meta: meta, child: Text((value.toInt() + 1).toString(), style: const TextStyle(fontSize: 10)));
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta, BuildContext context) => 
      SideTitleWidget(meta: meta, child: Text("${(value * 100).toInt()}%", style: const TextStyle(fontSize: 8)));

  BarTooltipItem? _buildCustomTooltipItem(BarChartGroupData group, int gi, BarChartRodData rod, int ri, BuildContext context, AppLocalizations localization) {
    if (ri == 0 && group.barRods.length > 1) return null;
    final valA = group.barRods[0].toY;
    final valB = group.barRods.length > 1 ? group.barRods[1].toY : valA;
    return BarTooltipItem("${(valA*100).round()}% -> ${(valB*100).round()}%", const TextStyle(color: Colors.white));
  }
}
