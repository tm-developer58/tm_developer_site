import 'site_locale.dart';
import 'locale_preference_store_stub.dart'
    if (dart.library.js_interop) 'locale_preference_store_web.dart'
    as backend;

const siteLanguageStorageKey = 'tm_developer_site_language';

/// Persists the language explicitly selected by the visitor.
abstract interface class LocalePreferenceStore {
  SiteLanguage? read();

  void write(SiteLanguage language);
}

LocalePreferenceStore createLocalePreferenceStore() {
  return backend.createLocalePreferenceStore();
}
