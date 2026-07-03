import 'package:flutter/material.dart';

class AppWork {
  const AppWork({
    required this.icon,
    required this.title,
    required this.summary,
    required this.tech,
    required this.note,
    required this.url,
  });

  final IconData icon;
  final String title;
  final String summary;
  final String tech;
  final String note;
  final String url;
}
