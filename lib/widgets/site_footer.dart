import 'package:flutter/material.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF111827),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFFD1D5DB)),
          ),
        ),
      ),
    );
  }
}
