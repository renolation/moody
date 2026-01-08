import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../providers/insights_provider.dart';
import '../widgets/insights_header.dart';
import '../widgets/mood_heatmap.dart';
import '../widgets/correlation_chart.dart';
import '../widgets/key_insight_card.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  Future<void> _onRefresh(WidgetRef ref) async {
    await Future.wait([
      ref.read(monthlyStatsNotifierProvider.notifier).refresh(),
      ref.read(weeklyCorrelationNotifierProvider.notifier).refresh(),
    ]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () => _onRefresh(ref),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.screenPaddingH,
            vertical: AppDimensions.spacingLg,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InsightsHeader(),
              SizedBox(height: AppDimensions.spacingLg),
              MoodHeatmap(),
              SizedBox(height: AppDimensions.spacingLg),
              CorrelationChart(),
              SizedBox(height: AppDimensions.spacingLg),
              KeyInsightCard(),
              SizedBox(height: AppDimensions.spacingXxl),
            ],
          ),
        ),
      ),
    );
  }
}
