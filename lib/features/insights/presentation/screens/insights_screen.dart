import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../widgets/insights_header.dart';
import '../widgets/mood_heatmap.dart';
import '../widgets/correlation_chart.dart';
import '../widgets/key_insight_card.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
    );
  }
}
