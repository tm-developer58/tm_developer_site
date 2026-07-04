import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../widgets/app_work_card.dart';
import '../widgets/section_heading.dart';

class WorksSection extends StatelessWidget {
  const WorksSection({required this.content, super.key});

  final WorksContent content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(eyebrow: content.eyebrow, title: content.title),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: content.items
                    .map(
                      (app) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: app == content.items.last ? 0 : 14,
                          ),
                          child: AppWorkCard(work: app, content: content),
                        ),
                      ),
                    )
                    .toList(),
              );
            }

            return Column(
              children: content.items
                  .map(
                    (app) => Padding(
                      padding: EdgeInsets.only(
                        bottom: app == content.items.last ? 0 : 14,
                      ),
                      child: AppWorkCard(work: app, content: content),
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
