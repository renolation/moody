import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../../../home/domain/entities/activity_entry.dart';

class RecentMovementList extends StatelessWidget {
  const RecentMovementList({
    super.key,
    required this.activities,
  });

  final List<ActivityEntry> activities;

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final activityDate = DateTime(
      timestamp.year,
      timestamp.month,
      timestamp.day,
    );

    if (activityDate == today) {
      return DateFormat('h:mm a').format(timestamp);
    } else if (activityDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM d').format(timestamp);
    }
  }

  String _getCategoryLabel(String activityType) {
    switch (activityType.toLowerCase()) {
      case 'walking':
      case 'running':
      case 'cycling':
        return 'Cardio';
      case 'yoga':
        return 'Mindfulness';
      case 'gym':
        return 'Strength';
      default:
        return 'Activity';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Movement',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to full history
                },
                child: const Text(
                  'SEE ALL',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // List
        if (activities.isEmpty)
          GlassPanel(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.directions_walk,
                    color: AppColors.textMuted.withValues(alpha: 0.4),
                    size: 40,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Start moving to see your activity here',
                    style: TextStyle(
                      color: AppColors.textMuted.withValues(alpha: 0.6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ...activities.map((activity) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ActivityItem(
                  activity: activity,
                  timeLabel: _formatTime(activity.timestamp),
                  categoryLabel: _getCategoryLabel(activity.type.name),
                ),
              )),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({
    required this.activity,
    required this.timeLabel,
    required this.categoryLabel,
  });

  final ActivityEntry activity;
  final String timeLabel;
  final String categoryLabel;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(16),
      borderRadius: 20,
      child: Row(
        children: [
          // Icon container
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.glassBackground,
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Icon(
              activity.type.icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      activity.type.label,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      timeLabel,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${activity.duration} mins',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.sage500,
                      ),
                    ),
                    Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.textMuted.withValues(alpha: 0.3),
                      ),
                    ),
                    Text(
                      categoryLabel,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
