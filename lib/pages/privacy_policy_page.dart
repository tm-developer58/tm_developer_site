import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../widgets/site_footer.dart';
import '../widgets/site_header.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({required this.content, super.key});

  static const routeName = '/privacy';

  final SiteContent content;

  @override
  Widget build(BuildContext context) {
    final policy = content.privacyPolicy;

    return Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SiteHeader(content: content),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(24, 44, 24, 64),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 880),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            final navigator = Navigator.of(context);
                            if (navigator.canPop()) {
                              navigator.pop();
                              return;
                            }
                            navigator.pushReplacementNamed('/');
                          },
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('戻る'),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          policy.pageTitle,
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF111827),
                              ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          policy.lastUpdatedLabel,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: const Color(0xFF6B7280)),
                        ),
                        const SizedBox(height: 28),
                        _PolicyBodyText(policy.intro),
                        const SizedBox(height: 36),
                        ...policy.sections.expand(
                          (section) => [
                            _PolicySection(section: section),
                            const SizedBox(height: 28),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SiteFooter(content: content),
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
        Text(
          section.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: const Color(0xFF111827),
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
        height: 1.8,
        color: const Color(0xFF374151),
      ),
    );
  }
}
