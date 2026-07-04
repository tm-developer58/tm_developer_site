import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../utils/url_launcher_helper.dart';
import '../widgets/metric_pill.dart';
import '../widgets/section_heading.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({required this.content, super.key});

  final SiteContent content;

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
                Expanded(flex: 6, child: _HeroCopy(content: this.content)),
                if (isWide) const SizedBox(width: 48),
                Expanded(
                  flex: 4,
                  child: _HeroCapabilityPanel(content: this.content),
                ),
              ];

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content,
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HeroCopy(content: this.content),
                  const SizedBox(height: 32),
                  _HeroCapabilityPanel(content: this.content),
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
  const _HeroCopy({required this.content});

  final SiteContent content;

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
        SectionEyebrow(text: content.hero.eyebrow),
        const SizedBox(height: 16),
        Text(content.hero.title, style: headlineStyle),
        const SizedBox(height: 20),
        Text(
          content.hero.body,
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
                  path: content.email,
                  queryParameters: {'subject': content.hero.mailSubject},
                ),
              ),
              icon: const Icon(Icons.mail_outline),
              label: Text(content.hero.primaryActionLabel),
            ),
            OutlinedButton.icon(
              onPressed: () => launchExternalUri(Uri.parse(content.githubUrl)),
              icon: const Icon(Icons.code),
              label: Text(content.hero.secondaryActionLabel),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroCapabilityPanel extends StatelessWidget {
  const _HeroCapabilityPanel({required this.content});

  final SiteContent content;

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
            content.hero.panelTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content.hero.panelBody,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFD1D5DB),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 26),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: content.metrics
                .map(
                  (metric) =>
                      MetricPill(value: metric.value, label: metric.label),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
