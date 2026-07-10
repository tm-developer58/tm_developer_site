import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../services/locale/site_language.dart';
import '../theme/site_theme.dart';

class SiteHeader extends StatelessWidget {
  const SiteHeader({
    required this.content,
    required this.language,
    required this.onLanguageChanged,
    this.onBrandPressed,
    this.onWorksPressed,
    this.onSkillsPressed,
    this.onWorkStylePressed,
    this.onContactPressed,
    super.key,
  });

  final SiteContent content;
  final SiteLanguage language;
  final ValueChanged<SiteLanguage> onLanguageChanged;
  final VoidCallback? onBrandPressed;
  final VoidCallback? onWorksPressed;
  final VoidCallback? onSkillsPressed;
  final VoidCallback? onWorkStylePressed;
  final VoidCallback? onContactPressed;

  @override
  Widget build(BuildContext context) {
    final navigation = content.navigation;
    final navigationItems = [
      _NavigationItem(navigation.worksLabel, onWorksPressed),
      _NavigationItem(navigation.skillsLabel, onSkillsPressed),
      _NavigationItem(navigation.workStyleLabel, onWorkStylePressed),
    ];

    return Material(
      color: SiteColors.surface.withValues(alpha: 0.96),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: SiteColors.border)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SiteSpacing.page,
            vertical: 14,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: SiteSpacing.contentWidth,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth >= 820;
                  final brand = _BrandButton(
                    label: content.brandName,
                    onPressed: onBrandPressed,
                  );
                  final actions = <Widget>[
                    ...navigationItems.map(
                      (item) => _HeaderLink(
                        label: item.label,
                        onPressed: item.onPressed,
                      ),
                    ),
                    _LanguageToggle(
                      language: language,
                      semanticLabel: navigation.languageToggleSemanticsLabel,
                      onChanged: onLanguageChanged,
                    ),
                    FilledButton(
                      onPressed: onContactPressed,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 44),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                      ),
                      child: Text(navigation.contactLabel),
                    ),
                  ];

                  if (isDesktop) {
                    return Row(
                      children: [
                        brand,
                        const Spacer(),
                        ...actions.expand(
                          (action) => [action, const SizedBox(width: 6)],
                        ),
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: brand,
                            ),
                          ),
                          _LanguageToggle(
                            language: language,
                            semanticLabel:
                                navigation.languageToggleSemanticsLabel,
                            onChanged: onLanguageChanged,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 4,
                        runSpacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          ...navigationItems.map(
                            (item) => _HeaderLink(
                              label: item.label,
                              onPressed: item.onPressed,
                            ),
                          ),
                          FilledButton(
                            onPressed: onContactPressed,
                            style: FilledButton.styleFrom(
                              minimumSize: const Size(0, 42),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                            ),
                            child: Text(navigation.contactLabel),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationItem {
  const _NavigationItem(this.label, this.onPressed);

  final String label;
  final VoidCallback? onPressed;
}

class _BrandButton extends StatelessWidget {
  const _BrandButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: SiteColors.navy,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          alignment: Alignment.centerLeft,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: SiteColors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text(
                'TM',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: SiteColors.navy,
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderLink extends StatelessWidget {
  const _HeaderLink({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: SiteColors.textMuted,
        minimumSize: const Size(0, 44),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
      child: Text(label),
    );
  }
}

class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle({
    required this.language,
    required this.semanticLabel,
    required this.onChanged,
  });

  final SiteLanguage language;
  final String semanticLabel;
  final ValueChanged<SiteLanguage> onChanged;

  @override
  Widget build(BuildContext context) {
    final nextLanguage = language == SiteLanguage.ja
        ? SiteLanguage.en
        : SiteLanguage.ja;
    return Semantics(
      button: true,
      label: semanticLabel,
      child: OutlinedButton(
        onPressed: () => onChanged(nextLanguage),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(60, 42),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          side: const BorderSide(color: SiteColors.border),
        ),
        child: Text(language == SiteLanguage.ja ? 'JA' : 'EN'),
      ),
    );
  }
}
