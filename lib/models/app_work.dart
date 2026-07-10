import 'package:flutter/material.dart';

class AppWork {
  const AppWork({
    required this.icon,
    required this.iconAsset,
    required this.screenshotAsset,
    required this.title,
    required this.summary,
    required this.tech,
    required this.note,
    required this.url,
  });

  final IconData icon;
  final String iconAsset;
  final String screenshotAsset;
  final String title;
  final String summary;
  final String tech;
  final String note;
  final String url;
}
