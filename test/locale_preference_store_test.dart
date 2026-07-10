import 'package:flutter_test/flutter_test.dart';
import 'package:tm_developer_site/services/locale/locale_preference_store.dart';
import 'package:tm_developer_site/services/locale/site_language.dart';

void main() {
  test('VM fallback is safe and does not retain a preference', () {
    final store = createLocalePreferenceStore();

    expect(store.read(), isNull);
    expect(() => store.write(SiteLanguage.en), returnsNormally);
    expect(store.read(), isNull);
  });
}
