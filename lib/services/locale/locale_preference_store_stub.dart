import 'locale_preference_store.dart';
import 'site_locale.dart';

LocalePreferenceStore createLocalePreferenceStore() {
  return const _NoOpLocalePreferenceStore();
}

class _NoOpLocalePreferenceStore implements LocalePreferenceStore {
  const _NoOpLocalePreferenceStore();

  @override
  SiteLanguage? read() => null;

  @override
  void write(SiteLanguage language) {}
}
