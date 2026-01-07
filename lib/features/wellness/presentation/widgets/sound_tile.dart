import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../../domain/entities/sound.dart';
import '../providers/wellness_provider.dart';

class SoundTile extends ConsumerWidget {
  const SoundTile({
    super.key,
    required this.sound,
  });

  final Sound sound;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentlyPlaying = ref.watch(currentlyPlayingProvider);
    final isPlaying = currentlyPlaying == sound.id;

    return GlassPanel(
      padding: const EdgeInsets.all(12),
      borderColor: isPlaying
          ? AppColors.accent.withValues(alpha: 0.3)
          : AppColors.glassBorder,
      child: Row(
        children: [
          // Play button
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              ref.read(currentlyPlayingProvider.notifier).toggle(sound.id);
            },
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isPlaying
                    ? AppColors.accent.withValues(alpha: 0.2)
                    : AppColors.glassBackground,
                boxShadow: isPlaying
                    ? [
                        BoxShadow(
                          color: AppColors.accent.withValues(alpha: 0.15),
                          blurRadius: 15,
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: isPlaying ? AppColors.accent : AppColors.textMuted,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.spacingMd),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sound.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isPlaying
                      ? 'Playing Now'
                      : sound.isPremium ? 'Premium' : 'Free',
                  style: TextStyle(
                    fontSize: 12,
                    color: isPlaying ? AppColors.accent : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          // Equalizer / waveform
          _Equalizer(isActive: isPlaying),
        ],
      ),
    );
  }
}

class _Equalizer extends StatefulWidget {
  const _Equalizer({required this.isActive});

  final bool isActive;

  @override
  State<_Equalizer> createState() => _EqualizerState();
}

class _EqualizerState extends State<_Equalizer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    if (widget.isActive) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant _Equalizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _controller.repeat(reverse: true);
    } else if (!widget.isActive && oldWidget.isActive) {
      _controller.stop();
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            final delay = index * 0.1;
            final value = widget.isActive
                ? ((_controller.value + delay) % 1.0)
                : 0.3;
            final height = 4 + (value * 12);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
              width: 3,
              height: height,
              decoration: BoxDecoration(
                color: widget.isActive
                    ? AppColors.accent
                    : AppColors.textMuted.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        );
      },
    );
  }
}
