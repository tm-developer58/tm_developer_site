import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../widgets/section_layout.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({required this.content, super.key});

  final SectionCopy content;

  @override
  Widget build(BuildContext context) {
    return SectionLayout(
      eyebrow: content.eyebrow,
      title: content.title,
      body: content.body,
    );
  }
}
