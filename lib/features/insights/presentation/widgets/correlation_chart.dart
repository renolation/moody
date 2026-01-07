import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../../domain/entities/mood_stats.dart';
import '../providers/insights_provider.dart';

class CorrelationChart extends ConsumerWidget {
  const CorrelationChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final correlationAsync = ref.watch(weeklyCorrelationProvider);

    return GlassPanel(
      padding: const EdgeInsets.all(AppDimensions.spacingLg),
      child: correlationAsync.when(
        data: (correlation) => _ChartBody(correlation: correlation),
        loading: () => const SizedBox(
          height: 220,
          child: Center(
            child: CircularProgressIndicator(color: AppColors.sage500),
          ),
        ),
        error: (error, stackTrace) => const SizedBox(
          height: 220,
          child: Center(
            child: Text(
              'Failed to load data',
              style: TextStyle(color: AppColors.textMuted),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChartBody extends StatelessWidget {
  const _ChartBody({required this.correlation});

  final WeeklyCorrelation correlation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.moodMovement,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  AppStrings.correlationAnalysis,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _LegendItem(
                  color: AppColors.primary,
                  label: AppStrings.moodScore,
                  isLine: true,
                ),
                const SizedBox(height: 4),
                _LegendItem(
                  color: AppColors.textMuted.withValues(alpha: 0.3),
                  label: AppStrings.exerciseMin,
                  isLine: false,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spacingLg),
        SizedBox(
          height: 180,
          child: _ChartContent(correlation: correlation),
        ),
        const SizedBox(height: AppDimensions.spacingSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: correlation.days
              .map((d) => Text(
                    d.dayName,
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.textMuted.withValues(alpha: 0.5),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
    required this.isLine,
  });

  final Color color;
  final String label;
  final bool isLine;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: isLine ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isLine ? null : BorderRadius.circular(2),
            boxShadow: isLine
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.6),
                      blurRadius: 6,
                    ),
                  ]
                : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _ChartContent extends StatelessWidget {
  const _ChartContent({required this.correlation});

  final WeeklyCorrelation correlation;

  @override
  Widget build(BuildContext context) {
    final days = correlation.days;
    final maxExercise = days.fold<int>(
            0, (max, d) => d.exerciseMinutes > max ? d.exerciseMinutes : max) +
        10;

    // Prepare line chart data
    final moodSpots = <FlSpot>[];
    for (int i = 0; i < days.length; i++) {
      final mood = days[i].moodScore;
      if (mood != null) {
        moodSpots.add(FlSpot(i.toDouble(), mood));
      }
    }

    return Stack(
      children: [
        // Bar chart for exercise
        BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: maxExercise.toDouble(),
            barTouchData: BarTouchData(enabled: false),
            titlesData: const FlTitlesData(show: false),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: maxExercise / 4,
              getDrawingHorizontalLine: (value) => FlLine(
                color: AppColors.glassHighlight,
                strokeWidth: 1,
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups: List.generate(
              days.length,
              (i) => BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: days[i].exerciseMinutes.toDouble(),
                    color: AppColors.textMuted.withValues(alpha: 0.15),
                    width: 24,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Line chart for mood
        if (moodSpots.length >= 2)
          LineChart(
            LineChartData(
              minY: 0,
              maxY: 5.5,
              lineTouchData: const LineTouchData(enabled: false),
              titlesData: const FlTitlesData(show: false),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: moodSpots,
                  isCurved: true,
                  curveSmoothness: 0.3,
                  color: AppColors.primary,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(
                      radius: 4,
                      color: AppColors.darkBg,
                      strokeWidth: 2,
                      strokeColor: AppColors.primary,
                    ),
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.2),
                        AppColors.primary.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
