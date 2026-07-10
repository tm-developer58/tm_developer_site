import 'package:web/web.dart' as web;

import 'locale_preference_store.dart';
import 'site_locale.dart';

LocalePreferenceStore createLocalePreferenceStore() {
  return const _WebLocalePreferenceStore();
}

class _WebLocalePreferenceStore implements LocalePreferenceStore {
  const _WebLocalePreferenceStore();

  @override
  SiteLanguage? read() {
    try {
      return SiteLanguage.fromStoredValue(
        web.window.localStorage.getItem(siteLanguageStorageKey),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  void write(SiteLanguage language) {
    try {
      web.window.localStorage.setItem(
        siteLanguageStorageKey,
        language.languageCode,
      );
    } catch (_) {
      // Language switching must remain usable even when storage is disabled.
    }
  }
}
