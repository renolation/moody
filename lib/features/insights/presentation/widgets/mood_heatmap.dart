import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../../domain/entities/mood_stats.dart';
import '../providers/insights_provider.dart';

class MoodHeatmap extends ConsumerWidget {
  const MoodHeatmap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(monthlyStatsProvider);
    final selectedMonth = ref.watch(selectedMonthProvider);

    return GlassPanel(
      padding: const EdgeInsets.all(AppDimensions.spacingLg),
      child: statsAsync.when(
        data: (stats) => _HeatmapContent(
          stats: stats,
          selectedMonth: selectedMonth,
        ),
        loading: () => const SizedBox(
          height: 250,
          child: Center(
            child: CircularProgressIndicator(color: AppColors.sage500),
          ),
        ),
        error: (error, stackTrace) => const SizedBox(
          height: 250,
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

class _HeatmapContent extends StatelessWidget {
  const _HeatmapContent({
    required this.stats,
    required this.selectedMonth,
  });

  final MonthlyStats stats;
  final DateTime selectedMonth;

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(selectedMonth.year, selectedMonth.month, 1);
    final daysInMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0).day;
    final startWeekday = firstDayOfMonth.weekday;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              AppStrings.monthlyHeatmap,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.glassBackground,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.glassHighlight),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Avg ${stats.averageMood.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spacingMd),
        // Weekday headers
        Row(
          children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
              .map((day) => Expanded(
                    child: Text(
                      day,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted.withValues(alpha: 0.5),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        // Calendar grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
          ),
          itemCount: 42, // 6 weeks max
          itemBuilder: (context, index) {
            final dayOffset = index - (startWeekday - 1);
            if (dayOffset < 0 || dayOffset >= daysInMonth) {
              return const SizedBox();
            }

            final day = dayOffset + 1;
            final dayStats = stats.dailyStats[day];
            final avgMood = dayStats?.averageMood;

            return _HeatmapCell(
              day: day,
              moodScore: avgMood,
            );
          },
        ),
      ],
    );
  }
}

class _HeatmapCell extends StatelessWidget {
  const _HeatmapCell({
    required this.day,
    this.moodScore,
  });

  final int day;
  final double? moodScore;

  Color _getColor() {
    if (moodScore == null) return AppColors.sage900.withValues(alpha: 0.3);

    // Map 1-5 to opacity 0.2-1.0
    final opacity = 0.2 + (moodScore! - 1) * 0.2;
    return AppColors.primary.withValues(alpha: opacity);
  }

  @override
  Widget build(BuildContext context) {
    final hasData = moodScore != null;
    final isHighMood = moodScore != null && moodScore! >= 4;

    return Container(
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: BorderRadius.circular(8),
        boxShadow: isHighMood
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          day.toString(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: isHighMood ? FontWeight.w700 : FontWeight.w400,
            color: isHighMood
                ? AppColors.darkBg
                : hasData
                    ? AppColors.textSecondary.withValues(alpha: 0.8)
                    : AppColors.textMuted.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}
