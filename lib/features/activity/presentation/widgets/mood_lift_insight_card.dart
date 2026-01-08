import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class MoodLiftInsightCard extends StatelessWidget {
  const MoodLiftInsightCard({
    super.key,
    required this.moodLiftPercentage,
    required this.hasEnoughData,
  });

  final double moodLiftPercentage;
  final bool hasEnoughData;

  @override
  Widget build(BuildContext context) {
    final isPositive = moodLiftPercentage >= 0;
    final displayPercentage = moodLiftPercentage.abs().round();

    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.05),
            const Color(0xFFFDE047).withValues(alpha: 0.02),
          ],
        ),
        border: Border.all(
          color: hasEnoughData
              ? const Color(0xFFFDE047).withValues(alpha: 0.3)
              : AppColors.glassBorder,
        ),
        boxShadow: hasEnoughData
            ? [
                BoxShadow(
                  color: const Color(0xFFFDE047).withValues(alpha: 0.1),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: Stack(
        children: [
          // Background glow effect
          if (hasEnoughData)
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFDE047).withValues(alpha: 0.15),
                ),
              ),
            ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Icon
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFDE047).withValues(alpha: 0.1),
                        border: Border.all(
                          color: const Color(0xFFFDE047).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Icon(
                        Icons.trending_up,
                        color: hasEnoughData
                            ? const Color(0xFFFCD34D)
                            : AppColors.textMuted,
                        size: 20,
                      ),
                    ),
                    // Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFFDE047).withValues(alpha: 0.1),
                        border: Border.all(
                          color: const Color(0xFFFDE047).withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        'INSIGHT',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: hasEnoughData
                              ? const Color(0xFFFEF3C7)
                              : AppColors.textMuted,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Label
                Text(
                  'IMPACT',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: hasEnoughData
                        ? const Color(0xFFFEF3C7).withValues(alpha: 0.6)
                        : AppColors.textMuted.withValues(alpha: 0.6),
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                // Value
                Text(
                  hasEnoughData
                      ? 'Mood Lift: ${isPositive ? '+' : '-'}$displayPercentage%'
                      : 'Keep logging',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: hasEnoughData
                        ? const Color(0xFFFEF9C3)
                        : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                // Subtitle
                Text(
                  hasEnoughData
                      ? 'Correlated with exercise'
                      : 'to see insights',
                  style: TextStyle(
                    fontSize: 11,
                    color: hasEnoughData
                        ? const Color(0xFFFDE047).withValues(alpha: 0.5)
                        : AppColors.textMuted.withValues(alpha: 0.5),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
