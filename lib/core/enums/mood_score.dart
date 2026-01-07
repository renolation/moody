import 'package:flutter/material.dart';

enum MoodScore {
  awful(1, 'Awful', Icons.sentiment_very_dissatisfied),
  bad(2, 'Bad', Icons.sentiment_dissatisfied),
  okay(3, 'Okay', Icons.sentiment_neutral),
  good(4, 'Good', Icons.sentiment_satisfied),
  great(5, 'Great', Icons.sentiment_very_satisfied);

  const MoodScore(this.value, this.label, this.icon);

  final int value;
  final String label;
  final IconData icon;

  static MoodScore fromValue(int value) {
    return MoodScore.values.firstWhere(
      (e) => e.value == value,
      orElse: () => MoodScore.okay,
    );
  }
}
