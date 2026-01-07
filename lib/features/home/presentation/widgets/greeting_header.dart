import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/date_time_extensions.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../../../settings/presentation/providers/settings_provider.dart';

class GreetingHeader extends ConsumerWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final userName = settingsAsync.valueOrNull?.userName ?? 'Friend';
    final greeting = DateTime.now().timeOfDayGreeting;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$greeting,',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w300,
                color: AppColors.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: AppColors.sage300,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        GlassIconButton(
          icon: Icons.notifications_outlined,
          onTap: () {
            // TODO: Show notifications
          },
          showBadge: true,
          badgeColor: Colors.orange,
        ),
      ],
    );
  }
}
