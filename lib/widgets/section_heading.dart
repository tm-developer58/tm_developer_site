import 'package:flutter/material.dart';

import '../theme/site_theme.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({required this.eyebrow, required this.title, super.key});

  final String eyebrow;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionEyebrow(text: eyebrow),
        const SizedBox(height: 10),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            height: 1.3,
            fontWeight: FontWeight.w900,
            color: SiteColors.navy,
            letterSpacing: -0.7,
          ),
        ),
      ],
    );
  }
}

class SectionEyebrow extends StatelessWidget {
  const SectionEyebrow({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: SiteColors.blue,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.4,
      ),
    );
  }
}
