import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../providers/insights_provider.dart';

class KeyInsightCard extends ConsumerWidget {
  const KeyInsightCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final correlationAsync = ref.watch(weeklyCorrelationNotifierProvider);

    return correlationAsync.when(
      data: (correlation) {
        final insight = correlation.insight;
        if (insight == null) {
          return _NoInsightCard();
        }
        return _InsightContent(insight: insight);
      },
      loading: () => const SizedBox(
        height: 100,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.sage500),
        ),
      ),
      error: (error, stackTrace) => _NoInsightCard(),
    );
  }
}

class _InsightContent extends StatelessWidget {
  const _InsightContent({required this.insight});

  final String insight;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(AppDimensions.spacingLg),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.primary.withValues(alpha: 0.1),
          Colors.transparent,
        ],
      ),
      borderColor: AppColors.primary.withValues(alpha: 0.2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.2),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: const Icon(
              Icons.lightbulb_outline,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: AppDimensions.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      AppStrings.keyInsight,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  insight,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: AppColors.textSecondary.withValues(alpha: 0.9),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoInsightCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(AppDimensions.spacingLg),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.sage800.withValues(alpha: 0.5),
            ),
            child: const Icon(
              Icons.lightbulb_outline,
              color: AppColors.textMuted,
              size: 20,
            ),
          ),
          const SizedBox(width: AppDimensions.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Keep logging!',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Log moods and activities for personalized insights',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
