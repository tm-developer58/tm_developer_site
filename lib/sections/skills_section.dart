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
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: content.items
              .map((skill) => SkillChip(item: skill))
              .toList(),
        ),
      ],
    );
  }
}
