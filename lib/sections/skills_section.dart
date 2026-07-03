import 'package:flutter/material.dart';

import '../models/skill_item.dart';
import '../widgets/section_heading.dart';
import '../widgets/skill_chip.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const _skills = [
    SkillItem(Icons.flutter_dash, 'Flutter / Dart'),
    SkillItem(Icons.lock_outline, 'Firebase Authentication'),
    SkillItem(Icons.storage_outlined, 'Cloud Firestore'),
    SkillItem(Icons.cloud_upload_outlined, 'Firebase Storage'),
    SkillItem(Icons.functions, 'Cloud Functions / TypeScript'),
    SkillItem(Icons.ios_share, 'App Storeリリース'),
    SkillItem(Icons.schema_outlined, 'アプリ設計・開発・運用'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(
          eyebrow: 'Skills',
          title: '実装から運用まで、Flutterアプリに必要な範囲を扱います。',
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _skills.map((skill) => SkillChip(item: skill)).toList(),
        ),
      ],
    );
  }
}
