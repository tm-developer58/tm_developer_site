/// Languages supported by the TM Developer site.
enum SiteLanguage {
  ja('ja'),
  en('en');

  const SiteLanguage(this.languageCode);

  final String languageCode;

  static SiteLanguage? fromStoredValue(String? value) {
    final normalized = value?.trim().toLowerCase();
    return switch (normalized) {
      'ja' => SiteLanguage.ja,
      'en' => SiteLanguage.en,
      _ => null,
    };
  }
}

/// Site pages that have localized routes.
enum SitePage { home, contact, privacy }

/// Pure routing and initial-locale rules for the localized site.
abstract final class SiteLocaleRouting {
  static const japaneseHomePath = '/';
  static const japaneseContactPath = '/contact';
  static const japanesePrivacyPath = '/privacy';
  static const englishHomePath = '/en';
  static const englishContactPath = '/en/contact';
  static const englishPrivacyPath = '/en/privacy';

  /// Resolves the language used for the initial location.
  ///
  /// Explicit localized paths always win. The root path has no language in its
  /// URL, so a valid stored manual choice is used first, followed by the first
  /// browser locale. Only locales beginning with `ja` select Japanese.
  static SiteLanguage resolveInitialLanguage({
    required String path,
    SiteLanguage? storedLanguage,
    String? storedLanguageCode,
    Iterable<String> browserLocaleCodes = const <String>[],
  }) {
    final explicitLanguage = languageForExplicitPath(path);
    if (explicitLanguage != null) {
      return explicitLanguage;
    }

    final savedLanguage =
        storedLanguage ?? SiteLanguage.fromStoredValue(storedLanguageCode);
    if (savedLanguage != null) {
      return savedLanguage;
    }

    final browserLocale = browserLocaleCodes.firstOrNull;
    return _isJapaneseLocale(browserLocale) ? SiteLanguage.ja : SiteLanguage.en;
  }

  /// Returns the canonical localized route for an incoming location.
  ///
  /// In particular, an English preference or English browser locale turns the
  /// language-neutral root path into `/en`.
  static String resolveInitialPath({
    required String path,
    SiteLanguage? storedLanguage,
    String? storedLanguageCode,
    Iterable<String> browserLocaleCodes = const <String>[],
  }) {
    final language = resolveInitialLanguage(
      path: path,
      storedLanguage: storedLanguage,
      storedLanguageCode: storedLanguageCode,
      browserLocaleCodes: browserLocaleCodes,
    );
    return pathFor(page: pageForPath(path), language: language);
  }

  /// Returns a language only when [path] explicitly identifies it.
  ///
  /// The root path intentionally returns `null` because it is the initial
  /// language-negotiation entry point.
  static SiteLanguage? languageForExplicitPath(String path) {
    return switch (_normalizePath(path)) {
      englishHomePath ||
      englishContactPath ||
      englishPrivacyPath => SiteLanguage.en,
      japaneseContactPath || japanesePrivacyPath => SiteLanguage.ja,
      _ => null,
    };
  }

  static SitePage pageForPath(String path) {
    return switch (_normalizePath(path)) {
      japaneseContactPath || englishContactPath => SitePage.contact,
      japanesePrivacyPath || englishPrivacyPath => SitePage.privacy,
      _ => SitePage.home,
    };
  }

  static String pathFor({
    required SitePage page,
    required SiteLanguage language,
  }) {
    return switch ((page, language)) {
      (SitePage.home, SiteLanguage.ja) => japaneseHomePath,
      (SitePage.contact, SiteLanguage.ja) => japaneseContactPath,
      (SitePage.privacy, SiteLanguage.ja) => japanesePrivacyPath,
      (SitePage.home, SiteLanguage.en) => englishHomePath,
      (SitePage.contact, SiteLanguage.en) => englishContactPath,
      (SitePage.privacy, SiteLanguage.en) => englishPrivacyPath,
    };
  }

  /// Returns the localized counterpart while preserving the current page.
  static String switchPath(String currentPath, SiteLanguage language) {
    return pathFor(page: pageForPath(currentPath), language: language);
  }

  static bool _isJapaneseLocale(String? value) {
    final normalized = value?.trim().toLowerCase();
    if (normalized == null || normalized.isEmpty) {
      return false;
    }
    return normalized.startsWith('ja');
  }

  static String _normalizePath(String value) {
    final parsed = Uri.tryParse(value);
    var path = parsed?.path ?? value;
    if (path.isEmpty) {
      return japaneseHomePath;
    }
    if (!path.startsWith('/')) {
      path = '/$path';
    }
    if (path.length > 1 && path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }
    return path;
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    if (!iterator.moveNext()) {
      return null;
    }
    return iterator.current;
  }
}
