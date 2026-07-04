import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../widgets/section_heading.dart';
import '../widgets/work_style_row.dart';

class WorkStyleSection extends StatelessWidget {
  const WorkStyleSection({required this.content, super.key});

  final WorkStyleContent content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(eyebrow: content.eyebrow, title: content.title),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth >= 760
                ? (constraints.maxWidth - 16) / 2
                : constraints.maxWidth;

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: content.items
                  .map(
                    (item) => SizedBox(
                      width: width,
                      child: WorkStyleRow(item: item),
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
