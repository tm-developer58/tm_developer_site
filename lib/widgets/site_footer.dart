import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../theme/site_theme.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({
    required this.content,
    required this.onPrivacyPressed,
    super.key,
  });

  final SiteContent content;
  final VoidCallback onPrivacyPressed;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: SiteColors.navy,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: SiteSpacing.contentWidth,
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 24,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  content.footerText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFCBD5E1),
                  ),
                ),
                TextButton(
                  onPressed: onPrivacyPressed,
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  child: Text(content.footerPrivacyLabel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
