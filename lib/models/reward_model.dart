import 'package:flutter/material.dart';

class RewardModel {
  final String title;
  final IconData icon;
  final bool unlocked;
  final Color color;

  RewardModel({
    required this.title,
    required this.icon,
    required this.unlocked,
    required this.color,
  });
  RewardModel copyWith({
    String? title,
    IconData? icon,
    bool? unlocked,
    Color? color,
  }) {
    return RewardModel(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      unlocked: unlocked ?? this.unlocked,
      color: color ?? this.color,
    );
  }
}
