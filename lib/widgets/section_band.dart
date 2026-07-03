import 'package:flutter/material.dart';

class SectionBand extends StatelessWidget {
  const SectionBand({required this.child, this.tinted = false, super.key});

  final Widget child;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: tinted ? const Color(0xFFF0F4F8) : const Color(0xFFF7F8FA),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 54),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: child,
        ),
      ),
    );
  }
}
