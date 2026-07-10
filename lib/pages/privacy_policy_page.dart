import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../services/locale/site_language.dart';
import '../theme/site_theme.dart';
import '../widgets/site_footer.dart';
import '../widgets/site_header.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({
    required this.content,
    required this.language,
    required this.onLanguageChanged,
    super.key,
  });

  static const routeName = '/privacy';

  final SiteContent content;
  final SiteLanguage language;
  final ValueChanged<SiteLanguage> onLanguageChanged;

  void _open(BuildContext context, SitePage page) {
    final path = SiteLocaleRouting.pathFor(page: page, language: language);
    Navigator.of(context).pushReplacementNamed(path);
  }

  @override
  Widget build(BuildContext context) {
    final policy = content.privacyPolicy;
    void openHome() => _open(context, SitePage.home);

    return Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SiteHeader(
                content: content,
                language: language,
                onLanguageChanged: onLanguageChanged,
                onBrandPressed: openHome,
                onWorksPressed: openHome,
                onSkillsPressed: openHome,
                onWorkStylePressed: openHome,
                onContactPressed: () => _open(context, SitePage.contact),
              ),
              ColoredBox(
                color: SiteColors.canvas,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 64, 24, 80),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 920),
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          color: SiteColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: SiteColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton.icon(
                              onPressed: openHome,
                              icon: const Icon(Icons.arrow_back_rounded),
                              label: Text(policy.backToHomeLabel),
                            ),
                            const SizedBox(height: 24),
                            Semantics(
                              header: true,
                              child: Text(
                                policy.pageTitle,
                                style: Theme.of(context).textTheme.displaySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: SiteColors.navy,
                                      letterSpacing: -1,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              policy.lastUpdatedLabel,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: SiteColors.textMuted),
                            ),
                            const SizedBox(height: 30),
                            _PolicyBodyText(policy.intro),
                            const SizedBox(height: 42),
                            ...policy.sections.expand(
                              (section) => [
                                _PolicySection(section: section),
                                const SizedBox(height: 32),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SiteFooter(content: content, onPrivacyPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  const _PolicySection({required this.section});

  final PrivacyPolicySection section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(
            section.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: SiteColors.navy,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _PolicyBodyText(section.body),
      ],
    );
  }
}

class _PolicyBodyText extends StatelessWidget {
  const _PolicyBodyText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        height: 1.85,
        color: SiteColors.textMuted,
      ),
    );
  }
}
