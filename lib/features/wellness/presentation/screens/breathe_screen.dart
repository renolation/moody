import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/background_gradient.dart';
import '../providers/wellness_provider.dart';

class BreatheScreen extends ConsumerStatefulWidget {
  const BreatheScreen({super.key});

  @override
  ConsumerState<BreatheScreen> createState() => _BreatheScreenState();
}

class _BreatheScreenState extends ConsumerState<BreatheScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Timer? _phaseTimer;
  bool _isActive = false;
  BreathingPhase _currentPhase = BreathingPhase.inhale;
  int _countdown = 4;
  int _cycleCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _phaseTimer?.cancel();
    super.dispose();
  }

  void _startSession() {
    HapticFeedback.mediumImpact();
    setState(() {
      _isActive = true;
      _currentPhase = BreathingPhase.inhale;
      _countdown = 4;
      _cycleCount = 0;
    });
    _startPhase();
  }

  void _startPhase() {
    final duration = switch (_currentPhase) {
      BreathingPhase.inhale => 4,
      BreathingPhase.hold => 7,
      BreathingPhase.exhale => 8,
    };

    _countdown = duration;

    // Animate bubble
    if (_currentPhase == BreathingPhase.inhale) {
      _controller.duration = Duration(seconds: duration);
      _controller.forward(from: 0);
    } else if (_currentPhase == BreathingPhase.exhale) {
      _controller.duration = Duration(seconds: duration);
      _controller.reverse(from: 1);
    }

    // Countdown timer
    _phaseTimer?.cancel();
    _phaseTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() => _countdown--);
      } else {
        timer.cancel();
        _nextPhase();
      }
    });
  }

  void _nextPhase() {
    HapticFeedback.lightImpact();

    setState(() {
      _currentPhase = switch (_currentPhase) {
        BreathingPhase.inhale => BreathingPhase.hold,
        BreathingPhase.hold => BreathingPhase.exhale,
        BreathingPhase.exhale => BreathingPhase.inhale,
      };

      if (_currentPhase == BreathingPhase.inhale) {
        _cycleCount++;
        if (_cycleCount >= 9) {
          // ~3 minutes
          _stopSession();
          return;
        }
      }
    });

    _startPhase();
  }

  void _stopSession() {
    HapticFeedback.mediumImpact();
    _phaseTimer?.cancel();
    _controller.stop();
    setState(() {
      _isActive = false;
    });
  }

  String get _phaseLabel => switch (_currentPhase) {
        BreathingPhase.inhale => 'Inhale',
        BreathingPhase.hold => 'Hold',
        BreathingPhase.exhale => 'Exhale',
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: BackgroundGradient(
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.all(AppDimensions.screenPaddingH),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.glassBackground,
                          border: Border.all(color: AppColors.glassBorder),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: AppColors.textMuted,
                          size: 20,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Breathe Bubble',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              // Main content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Phase label
                    if (_isActive)
                      Text(
                        _phaseLabel,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                          color: AppColors.textSecondary,
                          letterSpacing: 2,
                        ),
                      ),
                    const SizedBox(height: 40),
                    // Breathing bubble
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        final scale = _isActive
                            ? 0.6 + (_controller.value * 0.4)
                            : 0.8;
                        return Transform.scale(
                          scale: scale,
                          child: _BreatheBubble(isActive: _isActive),
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                    // Countdown or cycle info
                    if (_isActive) ...[
                      Text(
                        _countdown.toString(),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w200,
                          color: AppColors.accent,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Cycle ${_cycleCount + 1} of 9',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textMuted.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Start/Stop button
              Padding(
                padding: const EdgeInsets.all(AppDimensions.spacingXl),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isActive ? _stopSession : _startSession,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isActive ? AppColors.sage700 : AppColors.accent,
                      foregroundColor:
                          _isActive ? AppColors.textPrimary : AppColors.darkBg,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _isActive ? 'End Session' : 'Begin 4-7-8 Breathing',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BreatheBubble extends StatelessWidget {
  const _BreatheBubble({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer rings
        for (int i = 3; i > 0; i--)
          Container(
            width: 180 + (i * 30),
            height: 180 + (i * 30),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.glassBorder,
                width: 1,
              ),
            ),
          ),
        // Glow
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.accent.withValues(alpha: isActive ? 0.4 : 0.2),
                AppColors.accent.withValues(alpha: 0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),
        // Core
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.accent.withValues(alpha: 0.7),
                AppColors.accent.withValues(alpha: 0.3),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.4),
                blurRadius: 30,
                spreadRadius: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
