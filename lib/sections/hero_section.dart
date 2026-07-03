import 'package:flutter/material.dart';

import '../utils/url_launcher_helper.dart';
import '../widgets/metric_pill.dart';
import '../widgets/section_heading.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 42, 24, 56),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 860;
              final content = [
                const Expanded(flex: 6, child: _HeroCopy()),
                if (isWide) const SizedBox(width: 48),
                const Expanded(flex: 4, child: _HeroCapabilityPanel()),
              ];

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content,
                );
              }

              return const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HeroCopy(),
                  SizedBox(height: 32),
                  _HeroCapabilityPanel(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy();

  @override
  Widget build(BuildContext context) {
    final headlineStyle = Theme.of(context).textTheme.displaySmall?.copyWith(
      height: 1.18,
      fontWeight: FontWeight.w800,
      color: const Color(0xFF111827),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SectionEyebrow(text: 'Flutter / Firebase Developer'),
        const SizedBox(height: 16),
        Text('小規模なアプリ開発・改修を、設計からリリースまで対応します。', style: headlineStyle),
        const SizedBox(height: 20),
        Text(
          '個人開発でiOSアプリを複数リリースしています。既存アプリの機能追加・修正、Firebase連携、App Storeリリース対応などに対応できます。',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            height: 1.7,
            color: const Color(0xFF4B5563),
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: () => launchExternalUri(
                Uri(
                  scheme: 'mailto',
                  path: 'tm.developer58@gmail.com',
                  queryParameters: {'subject': 'アプリ開発の相談'},
                ),
              ),
              icon: const Icon(Icons.mail_outline),
              label: const Text('相談する'),
            ),
            OutlinedButton.icon(
              onPressed: () => launchExternalUri(
                Uri.parse('https://github.com/tm-developer58'),
              ),
              icon: const Icon(Icons.code),
              label: const Text('GitHub'),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroCapabilityPanel extends StatelessWidget {
  const _HeroCapabilityPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.phone_iphone, color: Color(0xFF93C5FD), size: 42),
          const SizedBox(height: 28),
          Text(
            'Released Apps',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Flutter / Firebaseで設計・開発・リリース・運用まで経験しています。',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFD1D5DB),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 26),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              MetricPill(value: '3', label: '公開アプリ'),
              MetricPill(value: '5,000+', label: '運用ユーザー'),
              MetricPill(value: '2-3日', label: '週稼働目安'),
            ],
          ),
        ],
      ),
    );
  }
}
