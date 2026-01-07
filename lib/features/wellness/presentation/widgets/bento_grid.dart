import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/glass_panel.dart';
import 'breathe_bubble_preview.dart';

class WellnessBentoGrid extends StatelessWidget {
  const WellnessBentoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Row(
        children: [
          // Left column - Breathe Bubble (tall)
          Expanded(
            child: GestureDetector(
              onTap: () => context.push('/breathe'),
              child: GlassPanel(
                padding: EdgeInsets.zero,
                child: Stack(
                  children: [
                    // Animated background
                    const Positioned.fill(
                      child: BreatheBubblePreview(),
                    ),
                    // Content
                    Positioned(
                      left: AppDimensions.spacingLg,
                      right: AppDimensions.spacingLg,
                      top: AppDimensions.spacingLg,
                      bottom: AppDimensions.spacingLg,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.glassBackground,
                              border: Border.all(
                                color: AppColors.glassBorder,
                              ),
                            ),
                            child: const Icon(
                              Icons.air,
                              color: AppColors.accent,
                              size: 22,
                            ),
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Breathe\nBubble',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '3 min session',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.spacingMd),
          // Right column - stacked
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.push('/quotes'),
                    child: GlassPanel(
                      padding: const EdgeInsets.all(AppDimensions.spacingMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.format_quote,
                            color: AppColors.accent,
                            size: 26,
                          ),
                          const Text(
                            'Daily Quotes\nGallery',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingMd),
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.push('/gratitude'),
                    child: GlassPanel(
                      padding: const EdgeInsets.all(AppDimensions.spacingMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.edit_note,
                            color: AppColors.accent,
                            size: 26,
                          ),
                          const Text(
                            'Gratitude\nJournal',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
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
