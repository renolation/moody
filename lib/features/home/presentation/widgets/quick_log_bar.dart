import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/enums/activity_type.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../../domain/exceptions/activity_overlap_exception.dart';
import '../providers/home_provider.dart';

class QuickLogBar extends ConsumerWidget {
  const QuickLogBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            AppStrings.quickLog,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spacingMd),
        Row(
          children: [
            _QuickLogButton(
              type: ActivityType.walking,
              onTap: () => _logActivity(context, ref, ActivityType.walking),
              onLongPress: () => _showDurationPicker(
                context,
                ref,
                ActivityType.walking,
              ),
            ),
            const SizedBox(width: AppDimensions.spacingSm),
            _QuickLogButton(
              type: ActivityType.running,
              onTap: () => _logActivity(context, ref, ActivityType.running),
              onLongPress: () => _showDurationPicker(
                context,
                ref,
                ActivityType.running,
              ),
            ),
            const SizedBox(width: AppDimensions.spacingSm),
            _QuickLogButton(
              type: ActivityType.yoga,
              onTap: () => _logActivity(context, ref, ActivityType.yoga),
              onLongPress: () => _showDurationPicker(
                context,
                ref,
                ActivityType.yoga,
              ),
            ),
            const SizedBox(width: AppDimensions.spacingSm),
            _QuickLogButton(
              type: ActivityType.gym,
              onTap: () => _logActivity(context, ref, ActivityType.gym),
              onLongPress: () => _showDurationPicker(
                context,
                ref,
                ActivityType.gym,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _logActivity(
    BuildContext context,
    WidgetRef ref,
    ActivityType type,
  ) async {
    HapticFeedback.lightImpact();
    try {
      await ref.read(todayActivitiesProvider.notifier).addActivity(type);
    } on ActivityOverlapException catch (e) {
      HapticFeedback.heavyImpact();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.friendlyMessage),
            backgroundColor: AppColors.sage700,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  void _showDurationPicker(
    BuildContext context,
    WidgetRef ref,
    ActivityType type,
  ) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => _DurationPicker(
        type: type,
        onSelect: (duration) async {
          try {
            await ref.read(todayActivitiesProvider.notifier).addActivity(
                  type,
                  duration: duration,
                );
            if (sheetContext.mounted) {
              Navigator.pop(sheetContext);
            }
          } on ActivityOverlapException catch (e) {
            HapticFeedback.heavyImpact();
            if (sheetContext.mounted) {
              Navigator.pop(sheetContext);
            }
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.friendlyMessage),
                  backgroundColor: AppColors.sage700,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

class _QuickLogButton extends StatelessWidget {
  const _QuickLogButton({
    required this.type,
    required this.onTap,
    required this.onLongPress,
  });

  final ActivityType type;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassButton(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: AppDimensions.radiusLg,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.sage800.withValues(alpha: 0.4),
                border: Border.all(
                  color: AppColors.glassHighlight,
                  width: 1,
                ),
              ),
              child: Icon(
                type.icon,
                color: AppColors.sage300,
                size: 24,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              type.label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DurationPicker extends StatefulWidget {
  const _DurationPicker({
    required this.type,
    required this.onSelect,
  });

  final ActivityType type;
  final Future<void> Function(int duration) onSelect;

  @override
  State<_DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<_DurationPicker> {
  late int _selectedDuration;

  @override
  void initState() {
    super.initState();
    _selectedDuration = widget.type.defaultDuration;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.sage700,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Log ${widget.type.label}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (_selectedDuration > 5) {
                    setState(() => _selectedDuration -= 5);
                  }
                },
                icon: const Icon(Icons.remove_circle_outline),
                color: AppColors.sage400,
                iconSize: 32,
              ),
              const SizedBox(width: 24),
              Text(
                '$_selectedDuration min',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 24),
              IconButton(
                onPressed: () {
                  if (_selectedDuration < 180) {
                    setState(() => _selectedDuration += 5);
                  }
                },
                icon: const Icon(Icons.add_circle_outline),
                color: AppColors.sage400,
                iconSize: 32,
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => widget.onSelect(_selectedDuration),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.sage600,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Log Activity',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
