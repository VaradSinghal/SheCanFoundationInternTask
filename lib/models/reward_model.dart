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
}