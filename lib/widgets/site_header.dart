import 'package:flutter/material.dart';

import '../content/site_content.dart';

class SiteHeader extends StatelessWidget {
  const SiteHeader({required this.content, super.key});

  final SiteContent content;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final brand = Text(
                content.brandName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF111827),
                ),
              );
              final labels = Wrap(
                spacing: 18,
                runSpacing: 8,
                children: content.headerLabels
                    .map((label) => _HeaderLabel(text: label))
                    .toList(),
              );

              if (constraints.maxWidth >= 860) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [brand, labels],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [brand, const SizedBox(height: 12), labels],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HeaderLabel extends StatelessWidget {
  const _HeaderLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: const Color(0xFF4B5563),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
