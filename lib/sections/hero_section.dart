import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../models/app_work.dart';
import '../services/analytics/analytics_service.dart';
import '../theme/site_theme.dart';
import '../utils/url_launcher_helper.dart';
import '../widgets/metric_pill.dart';
import '../widgets/safe_asset_image.dart';
import '../widgets/section_heading.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    required this.content,
    required this.onContactPressed,
    super.key,
  });

  final SiteContent content;
  final VoidCallback onContactPressed;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: SiteColors.surface,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 56, 24, 0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: SiteSpacing.contentWidth,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 900;
                final copy = _HeroCopy(
                  content: content,
                  onContactPressed: onContactPressed,
                );
                final visual = _AppPreviewVisual(
                  apps: content.works.items,
                  panelTitle: content.hero.panelTitle,
                  panelBody: content.hero.panelBody,
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (isWide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 10, child: copy),
                          const SizedBox(width: 56),
                          Expanded(flex: 9, child: visual),
                        ],
                      )
                    else ...[
                      copy,
                      const SizedBox(height: 36),
                      visual,
                    ],
                    const SizedBox(height: 48),
                    _MetricsStrip(metrics: content.metrics),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({required this.content, required this.onContactPressed});

  final SiteContent content;
  final VoidCallback onContactPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SectionEyebrow(text: content.hero.eyebrow),
          const SizedBox(height: 18),
          Semantics(
            header: true,
            child: Text(
              content.hero.title,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                height: 1.14,
                fontWeight: FontWeight.w900,
                color: SiteColors.navy,
                letterSpacing: -1.6,
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            content.hero.body,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              height: 1.75,
              color: SiteColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () async {
                  await AnalyticsService.logContactClick(source: 'hero');
                  onContactPressed();
                },
                icon: const Icon(Icons.arrow_forward_rounded),
                label: Text(content.hero.primaryActionLabel),
              ),
              OutlinedButton.icon(
                onPressed: () async {
                  await AnalyticsService.logGithubClick(source: 'hero');
                  await launchExternalUri(Uri.parse(content.githubUrl));
                },
                icon: const Icon(Icons.code_rounded),
                label: Text(content.hero.secondaryActionLabel),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AppPreviewVisual extends StatelessWidget {
  const _AppPreviewVisual({
    required this.apps,
    required this.panelTitle,
    required this.panelBody,
  });

  final List<AppWork> apps;
  final String panelTitle;
  final String panelBody;

  @override
  Widget build(BuildContext context) {
    final shownApps = apps.take(3).toList(growable: false);
    return Semantics(
      container: true,
      label: '$panelTitle. $panelBody',
      child: ExcludeSemantics(
        child: Container(
          height: 460,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFEFF6FF), Color(0xFFF8FAFC)],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final cardWidth = math.min(210.0, constraints.maxWidth * 0.49);
                final cardHeight = 358.0;
                final alignments = const [
                  Alignment(-0.72, 0.32),
                  Alignment(0, -0.05),
                  Alignment(0.72, 0.25),
                ];
                final rotations = const [-0.085, 0.0, 0.085];

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: -55,
                      right: -35,
                      child: Container(
                        width: 190,
                        height: 190,
                        decoration: BoxDecoration(
                          color: SiteColors.blue.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    ...List.generate(shownApps.length, (index) {
                      return Align(
                        alignment: alignments[index],
                        child: Transform.rotate(
                          angle: rotations[index],
                          child: _PhonePreviewCard(
                            work: shownApps[index],
                            width: cardWidth,
                            height: cardHeight,
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _PhonePreviewCard extends StatelessWidget {
  const _PhonePreviewCard({
    required this.work,
    required this.width,
    required this.height,
  });

  final AppWork work;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 14),
      decoration: BoxDecoration(
        color: SiteColors.navy,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.7),
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x260F172A),
            blurRadius: 24,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 54,
            height: 5,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF475569),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SafeAssetImage(
                asset: work.screenshotAsset,
                semanticLabel: work.title,
                fallbackIcon: work.icon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricsStrip extends StatelessWidget {
  const _MetricsStrip({required this.metrics});

  final List<MetricContent> metrics;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SiteColors.surface,
        borderRadius: BorderRadius.circular(SiteSpacing.radius),
        border: Border.all(color: SiteColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F0F172A),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 640;
          final items = <Widget>[];

          for (var index = 0; index < metrics.length; index++) {
            final metric = metrics[index];
            if (index > 0) {
              items.add(
                isWide
                    ? const SizedBox(
                        height: 48,
                        child: VerticalDivider(
                          width: 1,
                          color: SiteColors.border,
                        ),
                      )
                    : const Divider(height: 1, color: SiteColors.border),
              );
            }
            final pill = Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: MetricPill(
                icon: metric.icon,
                value: metric.value,
                label: metric.label,
              ),
            );
            items.add(isWide ? Expanded(child: pill) : pill);
          }

          return isWide
              ? Row(children: items)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: items,
                );
        },
      ),
    );
  }
}
