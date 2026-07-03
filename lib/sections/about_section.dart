import 'package:flutter/material.dart';

import '../widgets/section_layout.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionLayout(
      eyebrow: 'About',
      title: '個人開発で得た実装力を、実務の小さな前進に使います。',
      body:
          'Flutter / Firebaseを中心に個人開発をしています。独学でiOSアプリを複数リリースし、1つのアプリではアクティブユーザー約5,000人の運用経験があります。',
    );
  }
}
