import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../widgets/greeting_header.dart';
import '../widgets/daily_inspiration_card.dart';
import '../widgets/mood_selector.dart';
import '../widgets/quick_log_bar.dart';
import '../widgets/journey_timeline.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.screenPaddingH,
          vertical: AppDimensions.spacingXl,
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingHeader(),
            SizedBox(height: AppDimensions.spacingXl),
            DailyInspirationCard(),
            SizedBox(height: AppDimensions.spacingXl),
            MoodSelector(),
            SizedBox(height: AppDimensions.spacingXl),
            QuickLogBar(),
            SizedBox(height: AppDimensions.spacingXl),
            JourneyTimeline(),
            SizedBox(height: AppDimensions.spacingXxl),
          ],
        ),
      ),
    );
  }
}
