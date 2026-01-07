import 'package:flutter/material.dart';

enum ActivityType {
  walking('Walk', Icons.directions_walk, 30),
  running('Run', Icons.directions_run, 30),
  yoga('Yoga', Icons.self_improvement, 30),
  gym('Gym', Icons.fitness_center, 45),
  cycling('Cycle', Icons.directions_bike, 30);

  const ActivityType(this.label, this.icon, this.defaultDuration);

  final String label;
  final IconData icon;
  final int defaultDuration; // in minutes
}
