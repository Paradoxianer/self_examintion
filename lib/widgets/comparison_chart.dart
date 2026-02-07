import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/utils/local_storage.dart';
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
      case TimeRange.twoDays:
        return date.subtract(const Duration(days: 2));
      case TimeRange.week:
        return date.subtract(const Duration(days: 7));
      case TimeRange.month:
        return DateTime(date.year, date.month - 1, 1);
      case TimeRange.year:
        return DateTime(date.year - 1, 1, 1);
      case TimeRange.all:
        return date;
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
        const SizedBox(height: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: BarChart(
              BarChartData(
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                        _buildTooltipItem(group, groupIndex, rod, rodIndex,
                            context, localization),
                  ),
                ),
                minY: 0,
                maxY: 1.1,
                barGroups: _getComparisonData(context),
                borderData: FlBorderData(
                    show: true,
                    border:
                        Border.all(color: Colors.grey.withValues(alpha: 0.2))),
                gridData: const FlGridData(
                    show: true,
                    horizontalInterval: 0.2,
                    drawVerticalLine: false),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) => _bottomTitleWidgets(
                          value, meta, context, localization),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) =>
                          _leftTitleWidgets(value, meta, context),
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

  Widget _buildPeriodSelectors(BuildContext context,
      List<DateTime> availableDates, AppLocalizations localization) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDropdown(
              _selectedAnchorA!,
              (val) => setState(() => _selectedAnchorA = val),
              Colors.grey,
              availableDates,
              localization),
          const Icon(Icons.compare_arrows, color: Colors.grey, size: 20),
          _buildDropdown(
              _selectedAnchorB!,
              (val) => setState(() => _selectedAnchorB = val),
              Theme.of(context).primaryColor,
              availableDates,
              localization),
        ],
      ),
    );
  }

  Widget _buildDropdown(
      DateTime currentValue,
      ValueChanged<DateTime?> onChanged,
      Color color,
      List<DateTime> dates,
      AppLocalizations localization) {
    String currentKey = _getPeriodKey(currentValue);
    DateTime effectiveValue = dates.firstWhere(
        (d) => _getPeriodKey(d) == currentKey,
        orElse: () => currentValue);

    if (!dates.any((d) => _getPeriodKey(d) == currentKey)) {
      dates = [effectiveValue, ...dates];
      dates.sort((a, b) => b.compareTo(a));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<DateTime>(
          value: effectiveValue,
          icon: Icon(Icons.arrow_drop_down, color: color, size: 18),
          onChanged: onChanged,
          items: dates.map((date) {
            return DropdownMenuItem<DateTime>(
              value: date,
              child: Text(_formatDateForDropdown(date, localization),
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold, color: color)),
            );
          }).toList(),
        ),
      ),
    );
  }

  List<DateTime> _getAvailablePeriods() {
    final Set<String> uniqueKeys = {};
    final List<DateTime> distinctDates = [];
    for (var entry in widget.assessmentHistory) {
      String key = _getPeriodKey(entry.timestamp);
      if (uniqueKeys.add(key)) {
        distinctDates.add(entry.timestamp);
      }
    }
    distinctDates.sort((a, b) => b.compareTo(a));
    return distinctDates;
  }

  String _getPeriodKey(DateTime date) {
    switch (widget.currentTimeRange) {
      case TimeRange.twoDays:
        return "${date.year}-${date.month}-${date.day}";
      case TimeRange.week:
        int week = _getIsoWeek(date);
        return "${date.year}-W$week";
      case TimeRange.month:
        return "${date.year}-${date.month}";
      case TimeRange.year:
        return "${date.year}";
      case TimeRange.all:
        return "all";
    }
  }

  String _formatDateForDropdown(DateTime date, AppLocalizations localization) {
    switch (widget.currentTimeRange) {
      case TimeRange.twoDays:
        return DateFormat('dd.MM.yy').format(date);
      case TimeRange.week:
        return "KW ${_getIsoWeek(date)}, ${date.year}";
      case TimeRange.month:
        return DateFormat('MMM yyyy').format(date);
      case TimeRange.year:
        return date.year.toString();
      case TimeRange.all:
        return localization.all;
    }
  }

  int _getIsoWeek(DateTime date) {
    int days = date.difference(DateTime(date.year, 1, 1)).inDays;
    return ((days - date.weekday + 10) / 7).floor();
  }

  List<BarChartGroupData> _getComparisonData(BuildContext context) {
    final startA = _getPeriodStart(_selectedAnchorA!);
    final endA = _getPeriodEnd(_selectedAnchorA!);
    final startB = _getPeriodStart(_selectedAnchorB!);
    final endB = _getPeriodEnd(_selectedAnchorB!);

    final historyA = widget.assessmentHistory
        .where((e) =>
            e.timestamp.isAfter(startA.subtract(const Duration(seconds: 1))) &&
            e.timestamp.isBefore(endA.add(const Duration(seconds: 1))))
        .toList();

    final historyB = widget.assessmentHistory
        .where((e) =>
            e.timestamp.isAfter(startB.subtract(const Duration(seconds: 1))) &&
            e.timestamp.isBefore(endB.add(const Duration(seconds: 1))))
        .toList();

    List<BarChartGroupData> barGroups = [];
    final int questionCount = widget.assessmentHistory.first.values.length;
    double totalAvgA = 0, totalAvgB = 0;
    int countSelected = 0;

    for (int i = 0; i < questionCount; i++) {
      if (i < widget.selectedQuestions.length && !widget.selectedQuestions[i])
        continue;

      double avgA = _calculateAverage(historyA, i);
      double avgB = _calculateAverage(historyB, i);
      totalAvgA += avgA;
      totalAvgB += avgB;
      countSelected++;

      final color = globalColorMap[i + 1] ?? Colors.blue;

      barGroups.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
              toY: avgA, color: color.withValues(alpha: 0.3), width: 8),
          BarChartRodData(toY: avgB, color: color, width: 8),
        ],
      ));
    }

    if (widget.selectedQuestions.isNotEmpty &&
        widget.selectedQuestions.last &&
        countSelected > 0) {
      barGroups.add(BarChartGroupData(
        x: 100,
        barRods: [
          BarChartRodData(
              toY: totalAvgA / countSelected,
              color: Colors.red.withValues(alpha: 0.3),
              width: 12),
          BarChartRodData(
              toY: totalAvgB / countSelected, color: Colors.red, width: 12),
        ],
      ));
    }
    return barGroups;
  }

  double _calculateAverage(List<AssessmentEntry> history, int idx) {
    if (history.isEmpty) return 0.0;
    double sum = 0;
    int count = 0;
    for (var e in history) {
      if (idx < e.values.length && e.values[idx] != -1.0) {
        sum += e.values[idx];
        count++;
      }
    }
    return count > 0 ? sum / count : 0.0;
  }

  DateTime _getPeriodStart(DateTime d) {
    switch (widget.currentTimeRange) {
      case TimeRange.twoDays:
        return d;
      case TimeRange.week:
        return d.subtract(Duration(days: d.weekday - 1));
      case TimeRange.month:
        return DateTime(d.year, d.month, 1);
      case TimeRange.year:
        return DateTime(d.year, 1, 1);
      default:
        return d;
    }
  }

  DateTime _getPeriodEnd(DateTime d) {
    switch (widget.currentTimeRange) {
      case TimeRange.twoDays:
        return DateTime(d.year, d.month, d.day, 23, 59, 59);
      case TimeRange.week:
        return _getPeriodStart(d)
            .add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
      case TimeRange.month:
        return DateTime(d.year, d.month + 1, 0, 23, 59, 59);
      case TimeRange.year:
        return DateTime(d.year, 12, 31, 23, 59, 59);
      default:
        return d;
    }
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta, BuildContext context,
      AppLocalizations localization) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 10);
    if (value == 100)
      return SideTitleWidget(
          meta: meta, child: Text(localization.total, style: style));
    return SideTitleWidget(
        meta: meta, child: Text((value.toInt() + 1).toString(), style: style));
  }

  Widget _leftTitleWidgets(
          double value, TitleMeta meta, BuildContext context) =>
      SideTitleWidget(
          meta: meta,
          child: Text("${(value * 100).toInt()}%",
              style: const TextStyle(fontSize: 8)));

  BarTooltipItem _buildTooltipItem(
      BarChartGroupData group,
      int gi,
      BarChartRodData rod,
      int ri,
      BuildContext context,
      AppLocalizations localization) {
    final authorKey = LocalStorage().getCurrentAuthor();
    final questionSet = localization.questionMap[authorKey];
    String qText = group.x == 100
        ? localization.total
        : (questionSet?.questions[group.x.toInt()].text ?? "");
    String periodLabel =
        ri == 0 ? localization.prevPeriod : localization.currPeriod;
    return BarTooltipItem("$qText\n$periodLabel: ${(rod.toY * 100).round()}%",
        TextStyle(color: rod.color, fontWeight: FontWeight.bold, fontSize: 10));
  }
}
