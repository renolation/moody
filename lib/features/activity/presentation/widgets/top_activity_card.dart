import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_panel.dart';

class TopActivityCard extends StatelessWidget {
  const TopActivityCard({
    super.key,
    required this.activityName,
    required this.percentage,
  });

  final String activityName;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(20),
      borderRadius: 24,
      child: SizedBox(
        height: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.1),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: const Icon(
                Icons.bar_chart,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const Spacer(),
            // Label
            Text(
              'TOP ACTIVITY',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted.withValues(alpha: 0.6),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            // Activity name
            Text(
              activityName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            // Progress bar
            Container(
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: AppColors.glassBackground,
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
