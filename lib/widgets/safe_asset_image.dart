import 'package:flutter/material.dart';

import '../theme/site_theme.dart';

class SafeAssetImage extends StatelessWidget {
  const SafeAssetImage({
    required this.asset,
    this.fit = BoxFit.cover,
    this.semanticLabel,
    this.fallbackIcon = Icons.phone_iphone_rounded,
    super.key,
  });

  final String asset;
  final BoxFit fit;
  final String? semanticLabel;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      fit: fit,
      semanticLabel: semanticLabel,
      errorBuilder: (context, error, stackTrace) => ColoredBox(
        color: SiteColors.surfaceMuted,
        child: Center(
          child: Icon(fallbackIcon, color: SiteColors.blue, size: 36),
        ),
      ),
    );
  }
}
