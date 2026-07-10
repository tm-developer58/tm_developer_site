import 'package:flutter/material.dart';

import '../theme/site_theme.dart';

class InfoLabel extends StatelessWidget {
  const InfoLabel({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label: $value',
      child: ExcludeSemantics(
        child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: SiteColors.textMuted,
              height: 1.5,
            ),
            children: [
              TextSpan(
                text: '$label: ',
                style: const TextStyle(
                  color: SiteColors.navy,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(text: value),
            ],
          ),
        ),
      ),
    );
  }
}
