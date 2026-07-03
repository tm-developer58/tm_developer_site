import 'package:flutter/material.dart';

import 'section_heading.dart';

class SectionLayout extends StatelessWidget {
  const SectionLayout({
    required this.eyebrow,
    required this.title,
    required this.body,
    super.key,
  });

  final String eyebrow;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 760;
        final heading = SectionHeading(eyebrow: eyebrow, title: title);
        final content = Text(
          body,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF4B5563),
            height: 1.8,
          ),
        );

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 2),
              Expanded(flex: 4, child: heading),
              const SizedBox(width: 52),
              Expanded(flex: 5, child: content),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [heading, const SizedBox(height: 18), content],
        );
      },
    );
  }
}
