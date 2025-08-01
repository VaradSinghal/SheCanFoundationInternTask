import 'package:flutter/material.dart';

class Announcement {
  final String title;
  final String content;
  final String timestamp;
  final IconData icon;

  Announcement({
    required this.title,
    required this.content,
    required this.timestamp,
    required this.icon,
  });
}
