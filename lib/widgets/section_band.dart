import 'package:flutter/material.dart';

import '../theme/site_theme.dart';

class SectionBand extends StatelessWidget {
  const SectionBand({required this.child, this.tinted = false, super.key});

  final Widget child;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: tinted ? SiteColors.canvas : SiteColors.surface,
      padding: const EdgeInsets.symmetric(
        horizontal: SiteSpacing.page,
        vertical: SiteSpacing.section,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: SiteSpacing.contentWidth),
          child: child,
        ),
      ),
    );
  }
}
