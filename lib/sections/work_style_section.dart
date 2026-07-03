import 'package:flutter/material.dart';

import '../models/work_style_item.dart';
import '../widgets/section_heading.dart';
import '../widgets/work_style_row.dart';

class WorkStyleSection extends StatelessWidget {
  const WorkStyleSection({super.key});

  static const _items = [
    WorkStyleItem(Icons.calendar_month_outlined, '週2〜3日程度'),
    WorkStyleItem(Icons.home_work_outlined, 'フルリモート希望'),
    WorkStyleItem(Icons.chat_bubble_outline, 'チャット中心'),
    WorkStyleItem(Icons.video_call_outlined, '短時間MTG対応可'),
    WorkStyleItem(Icons.construction_outlined, '設計・実装・Firebase連携が得意'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(eyebrow: 'Work Style', title: '小さく始めて、着実に進める働き方'),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth >= 760
                ? (constraints.maxWidth - 16) / 2
                : constraints.maxWidth;

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _items
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
