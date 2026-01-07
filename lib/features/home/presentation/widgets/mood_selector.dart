import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/enums/mood_score.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../providers/home_provider.dart';

class MoodSelector extends ConsumerStatefulWidget {
  const MoodSelector({super.key});

  @override
  ConsumerState<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends ConsumerState<MoodSelector> {
  final _noteController = TextEditingController();
  bool _showNote = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _onMoodSelected(MoodScore score) {
    HapticFeedback.lightImpact();
    ref.read(selectedMoodProvider.notifier).select(score);
    setState(() {
      _showNote = true;
    });
  }

  Future<void> _submitMood() async {
    final selectedMood = ref.read(selectedMoodProvider);
    if (selectedMood == null) return;

    HapticFeedback.mediumImpact();

    final note = _noteController.text.trim().isEmpty
        ? null
        : _noteController.text.trim();

    await ref.read(todayMoodsProvider.notifier).addMood(selectedMood, note: note);

    // Clear state
    ref.read(selectedMoodProvider.notifier).clear();
    _noteController.clear();
    setState(() {
      _showNote = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedMood = ref.watch(selectedMoodProvider);

    return GlassPanel(
      padding: const EdgeInsets.all(AppDimensions.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.moodQuestion,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingLg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: MoodScore.values.map((mood) {
              final isSelected = selectedMood == mood;
              return _MoodButton(
                mood: mood,
                isSelected: isSelected,
                onTap: () => _onMoodSelected(mood),
              );
            }).toList(),
          ),
          if (_showNote) ...[
            const SizedBox(height: AppDimensions.spacingLg),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: SizedBox(
                height: 48,
                child: Stack(
                  children: [
                    TextField(
                      controller: _noteController,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: AppStrings.addNote,
                        hintStyle: TextStyle(
                          color: AppColors.textMuted.withValues(alpha: 0.7),
                        ),
                        filled: true,
                        fillColor: AppColors.sage900.withValues(alpha: 0.4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.glassBorder,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.glassBorder,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.sage500,
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 16,
                          right: 52,
                          top: 14,
                          bottom: 14,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Material(
                        color: AppColors.sage600,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: _submitMood,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MoodButton extends StatelessWidget {
  const _MoodButton({
    required this.mood,
    required this.isSelected,
    required this.onTap,
  });

  final MoodScore mood;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? AppColors.sage800.withValues(alpha: 0.8)
                  : Colors.transparent,
              border: isSelected
                  ? Border.all(color: AppColors.glassHighlight, width: 1)
                  : null,
            ),
            child: Icon(
              mood.icon,
              size: 32,
              color: isSelected ? AppColors.sage300 : AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            mood.label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? AppColors.sage300 : AppColors.textMuted,
              letterSpacing: 0.5,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.sage300,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.sage300.withValues(alpha: 0.5),
                    blurRadius: 5,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
