import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../models/app_work.dart';
import '../services/analytics/analytics_service.dart';
import '../theme/site_theme.dart';
import '../utils/url_launcher_helper.dart';
import 'info_label.dart';
import 'safe_asset_image.dart';

class AppWorkCard extends StatelessWidget {
  const AppWorkCard({required this.work, required this.content, super.key});

  final AppWork work;
  final WorksContent content;

  Future<void> _openAppStore() async {
    await AnalyticsService.logAppCardClick(appName: work.title, url: work.url);
    await launchExternalUri(Uri.parse(work.url));
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: '${work.title}. ${work.summary}',
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        color: SiteColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SiteSpacing.radius),
          side: const BorderSide(color: SiteColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFEFF6FF), Color(0xFFF8FAFC)],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -48,
                    right: -28,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: SiteColors.blue.withValues(alpha: 0.06),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Center(
                    child: FractionallySizedBox(
                      heightFactor: 0.88,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x240F172A),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SafeAssetImage(
                            key: ValueKey(
                              'work-screenshot-${work.screenshotAsset}',
                            ),
                            asset: work.screenshotAsset,
                            fit: BoxFit.contain,
                            semanticLabel: work.title,
                            fallbackIcon: work.icon,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 18,
                    bottom: 18,
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x260F172A),
                            blurRadius: 14,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: SafeAssetImage(
                        asset: work.iconAsset,
                        semanticLabel: work.title,
                        fallbackIcon: work.icon,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    work.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: SiteColors.navy,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    work.summary,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: SiteColors.textMuted,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 18),
                  InfoLabel(label: content.techLabel, value: work.tech),
                  const SizedBox(height: 8),
                  InfoLabel(label: content.roleLabel, value: content.roleValue),
                  const SizedBox(height: 16),
                  InfoLabel(label: content.focusLabel, value: work.note),
                  const SizedBox(height: 20),
                  OutlinedButton.icon(
                    onPressed: _openAppStore,
                    icon: const Icon(Icons.open_in_new_rounded, size: 18),
                    label: Text(content.appStoreButtonLabel),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
