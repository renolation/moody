import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../providers/wellness_provider.dart';
import '../widgets/bento_grid.dart';
import '../widgets/sound_tile.dart';

class WellnessScreen extends ConsumerWidget {
  const WellnessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soundsAsync = ref.watch(soundsProvider);
    final sounds = soundsAsync.valueOrNull ?? [];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.screenPaddingH,
          vertical: AppDimensions.spacingXl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  AppStrings.wellnessLibrary,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                GlassIconButton(
                  icon: Icons.search,
                  onTap: () {
                    // TODO: Search
                  },
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spacingXl),
            // Bento Grid
            const WellnessBentoGrid(),
            const SizedBox(height: AppDimensions.spacingXl),
            // Sleep Sounds Section
            const Text(
              AppStrings.sleepSounds,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingMd),
            ...sounds.map((sound) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SoundTile(sound: sound),
                )),
            const SizedBox(height: AppDimensions.spacingXxl),
          ],
        ),
      ),
    );
  }
}
