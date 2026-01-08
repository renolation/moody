import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../providers/activity_stats_provider.dart';
import '../widgets/activity_progress_ring.dart';
import '../widgets/top_activity_card.dart';
import '../widgets/mood_lift_insight_card.dart';
import '../widgets/recent_movement_list.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(activityStatsNotifierProvider);

    return SafeArea(
      child: statsAsync.when(
        data: (stats) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.screenPaddingH,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppDimensions.spacingLg),
              // Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.glassBackground,
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.textMuted,
                        size: 18,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Activity & Movement',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.glassBackground,
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: const Icon(
                      Icons.calendar_month,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spacingXl),

              // Hero: Activity Progress Ring
              Center(
                child: ActivityProgressRing(
                  currentMinutes: stats.todayMinutes,
                  goalMinutes: stats.goalMinutes,
                ),
              ),
              const SizedBox(height: AppDimensions.spacingXl),

              // Insights Grid
              Row(
                children: [
                  Expanded(
                    child: TopActivityCard(
                      activityName: stats.topActivity?.label ?? 'No activity yet',
                      percentage: stats.topActivityPercentage,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingMd),
                  Expanded(
                    child: MoodLiftInsightCard(
                      moodLiftPercentage: stats.moodLiftPercentage,
                      hasEnoughData: stats.hasEnoughDataForInsight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spacingXl),

              // Recent Movement List
              RecentMovementList(
                activities: stats.recentActivities,
              ),
              const SizedBox(height: AppDimensions.spacingXxl),
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: AppColors.textMuted,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Failed to load activity data',
                style: TextStyle(
                  color: AppColors.textMuted.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
