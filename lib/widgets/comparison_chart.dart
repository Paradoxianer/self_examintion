import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/utils/assessment_calculator.dart';

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
                    getTooltipColor: (group) => Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.98),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) => 
                        _buildCustomTooltipItem(group, groupIndex, rod, rodIndex, context, localization),
                  ),
                ),
                minY: 0,
                maxY: 1.1,
                barGroups: _getComparisonData(context, localization),
                borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.withValues(alpha: 0.1))),
                gridData: const FlGridData(show: true, horizontalInterval: 0.2, drawVerticalLine: false),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
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

  Widget _bottomTitleWidgets(double value, TitleMeta meta, BuildContext context, AppLocalizations localization) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 10);
    if (value == 100) return SideTitleWidget(meta: meta, child: Text(localization.total, style: style));
    // Nur Title anzeigen wenn der Wert im Bereich der Fragen liegt
    if (value >= 0 && value < widget.selectedQuestions.length - 1) {
      return SideTitleWidget(meta: meta, child: Text((value.toInt() + 1).toString(), style: style));
    }
    return const SizedBox.shrink();
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta, BuildContext context) => 
      SideTitleWidget(meta: meta, child: Text("${(value * 100).toInt()}%", style: const TextStyle(fontSize: 8)));

  BarTooltipItem? _buildCustomTooltipItem(BarChartGroupData group, int gi, BarChartRodData rod, int ri, BuildContext context, AppLocalizations localization) {
    if (ri == 0 && group.barRods.length > 1) return null;
    final valA = group.barRods[0].toY;
    final valB = group.barRods.length > 1 ? group.barRods[1].toY : valA;
    return BarTooltipItem("${(valA*100).round()}% -> ${(valB*100).round()}%", const TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
  }

  List<BarChartGroupData> _getComparisonData(BuildContext context, AppLocalizations localization) {
    if (widget.assessmentHistory.isEmpty) return [];

    final startA = AssessmentCalculator.getPeriodStart(_selectedAnchorA!, widget.currentTimeRange);
    final endA = AssessmentCalculator.getPeriodEnd(_selectedAnchorA!, widget.currentTimeRange);
    final startB = AssessmentCalculator.getPeriodStart(_selectedAnchorB!, widget.currentTimeRange);
    final endB = AssessmentCalculator.getPeriodEnd(_selectedAnchorB!, widget.currentTimeRange);

    final historyA = widget.assessmentHistory.where((e) => e.timestamp.isAfter(startA.subtract(const Duration(seconds: 1))) && e.timestamp.isBefore(endA.add(const Duration(seconds: 1)))).toList();
    final historyB = widget.assessmentHistory.where((e) => e.timestamp.isAfter(startB.subtract(const Duration(seconds: 1))) && e.timestamp.isBefore(endB.add(const Duration(seconds: 1)))).toList();

    if (historyA.isEmpty && historyB.isEmpty) return [];

    final String currentSetKey = widget.assessmentHistory.first.questionSet;
    final questionSet = localization.questionMap[currentSetKey];
    final int questionCount = widget.assessmentHistory.first.values.length;
    
    final List<bool> polarities = List.generate(questionCount, (i) => 
      (questionSet != null && i < questionSet.questions.length) ? questionSet.questions[i].isPositive : false
    );

    List<BarChartGroupData> barGroups = [];
    double totalAvgSumA = 0, totalAvgSumB = 0;
    int totalValidQuestions = 0;

    for (int i = 0; i < questionCount; i++) {
      final avgA = _calculateAverageForQuestion(historyA, i, polarities[i]);
      final avgB = _calculateAverageForQuestion(historyB, i, polarities[i]);
      
      totalAvgSumA += avgA;
      totalAvgSumB += avgB;
      totalValidQuestions++;

      if (i < widget.selectedQuestions.length && widget.selectedQuestions[i]) {
        final color = globalColorMap[i + 1] ?? Colors.blue;
        barGroups.add(BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(toY: avgA, color: color.withValues(alpha: 0.3), width: 10, borderRadius: const BorderRadius.vertical(top: Radius.circular(4))),
            BarChartRodData(toY: avgB, color: color, width: 10, borderRadius: const BorderRadius.vertical(top: Radius.circular(4))),
          ],
        ));
      }
    }

    if (widget.selectedQuestions.isNotEmpty && widget.selectedQuestions.last && totalValidQuestions > 0) {
      barGroups.add(BarChartGroupData(
        x: 100,
        barRods: [
          BarChartRodData(toY: totalAvgSumA / totalValidQuestions, color: Colors.red.withValues(alpha: 0.2), width: 14, borderRadius: const BorderRadius.vertical(top: Radius.circular(4))),
          BarChartRodData(toY: totalAvgSumB / totalValidQuestions, color: Colors.red, width: 14, borderRadius: const BorderRadius.vertical(top: Radius.circular(4))),
        ],
      ));
    }

    return barGroups;
  }

  double _calculateAverageForQuestion(List<AssessmentEntry> history, int idx, bool isPositive) {
    if (history.isEmpty) return 0.0;
    double sum = 0;
    int count = 0;
    for (var e in history) {
      if (idx < e.values.length && e.values[idx] != -1.0) {
        sum += AssessmentCalculator.getChartValue(e.values[idx], isPositive);
        count++;
      }
    }
    return count > 0 ? sum / count : 0.0;
  }

  Widget _buildPeriodSelectors(BuildContext context, AppLocalizations localization) {
    final periods = _getAvailablePeriods();
    if (periods.isEmpty) return const SizedBox.shrink();
    
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
    String currentKey = _getPeriodKey(currentValue);
    DateTime? effectiveValue = dates.where((d) => _getPeriodKey(d) == currentKey).firstOrNull;
    
    return DropdownButtonHideUnderline(
      child: DropdownButton<DateTime>(
        value: effectiveValue ?? dates.first,
        icon: Icon(Icons.arrow_drop_down, color: color),
        onChanged: onChanged,
        items: dates.map((date) => DropdownMenuItem<DateTime>(
          value: date,
          child: Text(DateFormat.yMd(localization.localeName).format(date), 
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
        )).toList(),
      ),
    );
  }
}
