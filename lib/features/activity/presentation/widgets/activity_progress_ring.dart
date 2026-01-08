import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ActivityProgressRing extends StatelessWidget {
  const ActivityProgressRing({
    super.key,
    required this.currentMinutes,
    required this.goalMinutes,
  });

  final int currentMinutes;
  final int goalMinutes;

  double get progress => goalMinutes > 0
      ? (currentMinutes / goalMinutes).clamp(0.0, 1.0)
      : 0.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background ring
          CustomPaint(
            size: const Size(280, 280),
            painter: _RingPainter(
              progress: progress,
              strokeWidth: 12,
              backgroundColor: AppColors.glassBackground,
              gradientColors: [AppColors.primary, AppColors.sage500],
            ),
          ),
          // Center content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$currentMinutes',
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1,
                ),
              ),
              const Text(
                'min',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'OF $goalMinutes MIN GOAL',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted.withValues(alpha: 0.6),
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.gradientColors,
  });

  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final List<Color> gradientColors;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background track
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    if (progress > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final gradient = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
        colors: gradientColors,
      );

      final progressPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      // Draw arc starting from top (-90 degrees)
      canvas.drawArc(
        rect,
        -math.pi / 2, // Start from top
        2 * math.pi * progress, // Sweep angle based on progress
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
