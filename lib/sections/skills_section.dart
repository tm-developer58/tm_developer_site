import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../widgets/section_heading.dart';
import '../widgets/skill_chip.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({required this.content, super.key});

  final SkillsContent content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(eyebrow: content.eyebrow, title: content.title),
        const SizedBox(height: 32),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 980
                ? 3
                : constraints.maxWidth >= 600
                ? 2
                : 1;
            final width = (constraints.maxWidth - (columns - 1) * 16) / columns;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: content.items
                  .map(
                    (skill) => SizedBox(
                      width: width,
                      child: SkillChip(item: skill),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
