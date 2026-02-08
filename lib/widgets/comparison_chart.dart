import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/widgets/chart_control_widget.dart';

/// A widget that visualizes a comparison between two periods or entries
/// with support for polarity inversion and custom themed tooltips.
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
    if (widget.assessmentHistory.isEmpty) {
      return Center(child: Text(localization.noData));
    }

    final periods = _getAvailablePeriods();
    
    return Column(
      children: [
        if (widget.currentTimeRange != TimeRange.all)
          _buildPeriodSelectors(context, periods, localization),
        const SizedBox(height: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 24, 16),
            child: BarChart(
              BarChartData(
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBorderRadius: BorderRadius.circular(8),
                    tooltipPadding: const EdgeInsets.all(8),
                    tooltipMargin: 4,
                    fitInsideVertically: true,
                    fitInsideHorizontally: true,
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

  // --- Logic & Data ---

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
    double totalAvgA = 0, totalAvgB = 0;
    int countSelected = 0;

    for (int i = 0; i < questionCount; i++) {
      if (i < widget.selectedQuestions.length && !widget.selectedQuestions[i]) continue;

      double avgA = _calculateAverage(context, historyA, i);
      double avgB = _calculateAverage(context, historyB, i);
      totalAvgA += avgA; totalAvgB += avgB;
      countSelected++;

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

    if (widget.selectedQuestions.isNotEmpty && widget.selectedQuestions.last && countSelected > 0) {
      barGroups.add(
        BarChartGroupData(
          x: 100,
          barRods: [
            BarChartRodData(toY: totalAvgA / countSelected, color: Colors.red.withValues(alpha: 0.2), width: 14, borderRadius: const BorderRadius.vertical(top: Radius.circular(4))),
            BarChartRodData(toY: totalAvgB / countSelected, color: Colors.red, width: 14, borderRadius: const BorderRadius.vertical(top: Radius.circular(4))),
          ],
        ),
      );
    }
    return barGroups;
  }

  BarTooltipItem? _buildCustomTooltipItem(BarChartGroupData group, int gi, BarChartRodData rod, int ri, BuildContext context, AppLocalizations localization) {
    final authorKey = LocalStorage().getCurrentAuthor();
    final questionSet = localization.questionMap[authorKey];
    
    if (ri == 0 && group.barRods.length > 1) return null;

    final valA = group.barRods[0].toY;
    final valB = group.barRods.length > 1 ? group.barRods[1].toY : valA;
    final color = group.barRods.length > 1 ? group.barRods[1].color : group.barRods[0].color;
    
    String headerText = group.x == 100 ? localization.total : "${(group.x.toInt() + 1)}";
    String bodyText = group.x == 100 ? "" : (questionSet?.questions[group.x.toInt()].text ?? "");

    return BarTooltipItem(
      "",
      const TextStyle(),
      children: [
        TextSpan(
          text: "$headerText ",
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        TextSpan(
          text: "${(valA * 100).round()}% → ",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6), fontSize: 12, fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: "${(valB * 100).round()}%\n",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        if (bodyText.isNotEmpty)
          TextSpan(
            text: bodyText,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8), fontSize: 10, fontStyle: FontStyle.italic),
          ),
      ],
    );
  }

  // --- UI Helpers ---

  Widget _buildPeriodSelectors(BuildContext context, List<DateTime> availableDates, AppLocalizations localization) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDropdown(_selectedAnchorA!, (val) => setState(() => _selectedAnchorA = val), Colors.grey, availableDates, localization),
          Icon(Icons.compare_arrows, color: Theme.of(context).colorScheme.primary, size: 24),
          _buildDropdown(_selectedAnchorB!, (val) => setState(() => _selectedAnchorB = val), Theme.of(context).primaryColor, availableDates, localization),
        ],
      ),
    );
  }

  Widget _buildDropdown(DateTime currentValue, ValueChanged<DateTime?> onChanged, Color color, List<DateTime> dates, AppLocalizations localization) {
    String currentKey = _getPeriodKey(currentValue);
    DateTime effectiveValue = dates.firstWhere((d) => _getPeriodKey(d) == currentKey, orElse: () => currentValue);
    if (!dates.any((d) => _getPeriodKey(d) == currentKey)) {
      dates = [effectiveValue, ...dates];
      dates.sort((a, b) => b.compareTo(a));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<DateTime>(
          value: effectiveValue,
          icon: Icon(Icons.arrow_drop_down, color: color),
          onChanged: onChanged,
          items: dates.map((date) => DropdownMenuItem<DateTime>(
            value: date,
            child: Text(_formatDateForDropdown(date, localization), 
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          )).toList(),
        ),
      ),
    );
  }

  double _calculateAverage(BuildContext context, List<AssessmentEntry> history, int idx) {
    if (history.isEmpty) return 0.0;
    final localization = AppLocalizations.of(context)!;
    double sum = 0; int count = 0;
    for (var e in history) {
      if (idx < e.values.length && e.values[idx] != -1.0) {
        double val = e.values[idx];
        final questionSet = localization.questionMap[e.questionSet];
        if (questionSet != null && idx < questionSet.questions.length && questionSet.questions[idx].isPositive) {
          val = 1.0 - val;
        }
        sum += val; count++;
      }
    }
    return count > 0 ? sum / count : 0.0;
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
      case TimeRange.week: return "${date.year}-W${_getIsoWeek(date)}";
      case TimeRange.month: return "${date.year}-${date.month}";
      case TimeRange.year: return "${date.year}";
      case TimeRange.all: return "all";
    }
  }

  String _formatDateForDropdown(DateTime date, AppLocalizations localization) {
    switch (widget.currentTimeRange) {
      case TimeRange.twoDays: return DateFormat('dd.MM.yy').format(date);
      case TimeRange.week: return "KW ${_getIsoWeek(date)}, ${date.year}";
      case TimeRange.month: return DateFormat('MMM yyyy').format(date);
      case TimeRange.year: return date.year.toString();
      default: return "";
    }
  }

  int _getIsoWeek(DateTime date) {
    int days = date.difference(DateTime(date.year, 1, 1)).inDays;
    return ((days - date.weekday + 10) / 7).floor();
  }

  DateTime _getPeriodStart(DateTime d) {
    switch (widget.currentTimeRange) {
      case TimeRange.twoDays: return d;
      case TimeRange.week: return d.subtract(Duration(days: d.weekday - 1));
      case TimeRange.month: return DateTime(d.year, d.month, 1);
      case TimeRange.year: return DateTime(d.year, 1, 1);
      default: return d;
    }
  }

  DateTime _getPeriodEnd(DateTime d) {
    switch (widget.currentTimeRange) {
      case TimeRange.twoDays: return DateTime(d.year, d.month, d.day, 23, 59, 59);
      case TimeRange.week: return _getPeriodStart(d).add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
      case TimeRange.month: return DateTime(d.year, d.month + 1, 0, 23, 59, 59);
      case TimeRange.year: return DateTime(d.year, 12, 31, 23, 59, 59);
      default: return d;
    }
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta, BuildContext context, AppLocalizations localization) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 10);
    if (value == 100) return SideTitleWidget(meta: meta, child: Text(localization.total, style: style));
    return SideTitleWidget(meta: meta, child: Text((value.toInt() + 1).toString(), style: style));
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta, BuildContext context) => 
      SideTitleWidget(meta: meta, child: Text("${(value * 100).toInt()}%", style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)));
}
