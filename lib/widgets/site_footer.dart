import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../pages/privacy_policy_page.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({required this.content, super.key});

  final SiteContent content;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF111827),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Wrap(
            spacing: 18,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                content.footerText,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFD1D5DB),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(
                  context,
                ).pushNamed(PrivacyPolicyPage.routeName),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFD1D5DB),
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 36),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(content.footerPrivacyLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
