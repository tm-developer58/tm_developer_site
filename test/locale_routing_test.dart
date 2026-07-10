import 'package:flutter_test/flutter_test.dart';
import 'package:tm_developer_site/services/locale/site_language.dart';

void main() {
  group('SiteLocaleRouting.resolveInitialLanguage', () {
    test('explicit localized routes override stored and browser languages', () {
      expect(
        SiteLocaleRouting.resolveInitialLanguage(
          path: '/en/contact',
          storedLanguage: SiteLanguage.ja,
          browserLocaleCodes: const ['ja-JP'],
        ),
        SiteLanguage.en,
      );
      expect(
        SiteLocaleRouting.resolveInitialLanguage(
          path: '/privacy',
          storedLanguage: SiteLanguage.en,
          browserLocaleCodes: const ['en-US'],
        ),
        SiteLanguage.ja,
      );
    });

    test('root uses a saved manual selection before browser locale', () {
      expect(
        SiteLocaleRouting.resolveInitialLanguage(
          path: '/',
          storedLanguage: SiteLanguage.en,
          browserLocaleCodes: const ['ja-JP'],
        ),
        SiteLanguage.en,
      );
      expect(
        SiteLocaleRouting.resolveInitialLanguage(
          path: '/',
          storedLanguageCode: 'ja',
          browserLocaleCodes: const ['en-US'],
        ),
        SiteLanguage.ja,
      );
    });

    test('root resolves to the canonical localized home path', () {
      expect(
        SiteLocaleRouting.resolveInitialPath(
          path: '/',
          browserLocaleCodes: const ['en-US'],
        ),
        '/en',
      );
      expect(
        SiteLocaleRouting.resolveInitialPath(
          path: '/',
          browserLocaleCodes: const ['ja-JP'],
        ),
        '/',
      );
    });

    test('only browser locales beginning with ja select Japanese', () {
      expect(
        SiteLocaleRouting.resolveInitialLanguage(
          path: '/',
          browserLocaleCodes: const ['ja-JP'],
        ),
        SiteLanguage.ja,
      );
      expect(
        SiteLocaleRouting.resolveInitialLanguage(
          path: '/',
          browserLocaleCodes: const ['en-US', 'ja-JP'],
        ),
        SiteLanguage.en,
      );
      expect(
        SiteLocaleRouting.resolveInitialLanguage(path: '/'),
        SiteLanguage.en,
      );
    });

    test('invalid saved values fall back to the browser locale', () {
      expect(
        SiteLocaleRouting.resolveInitialLanguage(
          path: '/',
          storedLanguageCode: 'fr',
          browserLocaleCodes: const ['ja'],
        ),
        SiteLanguage.ja,
      );
    });
  });

  group('localized paths', () {
    test('maps every page and language to its canonical path', () {
      expect(
        SiteLocaleRouting.pathFor(
          page: SitePage.home,
          language: SiteLanguage.ja,
        ),
        '/',
      );
      expect(
        SiteLocaleRouting.pathFor(
          page: SitePage.contact,
          language: SiteLanguage.ja,
        ),
        '/contact',
      );
      expect(
        SiteLocaleRouting.pathFor(
          page: SitePage.privacy,
          language: SiteLanguage.ja,
        ),
        '/privacy',
      );
      expect(
        SiteLocaleRouting.pathFor(
          page: SitePage.home,
          language: SiteLanguage.en,
        ),
        '/en',
      );
      expect(
        SiteLocaleRouting.pathFor(
          page: SitePage.contact,
          language: SiteLanguage.en,
        ),
        '/en/contact',
      );
      expect(
        SiteLocaleRouting.pathFor(
          page: SitePage.privacy,
          language: SiteLanguage.en,
        ),
        '/en/privacy',
      );
    });

    test('language switching preserves the current page', () {
      expect(
        SiteLocaleRouting.switchPath('/contact', SiteLanguage.en),
        '/en/contact',
      );
      expect(
        SiteLocaleRouting.switchPath('/en/privacy', SiteLanguage.ja),
        '/privacy',
      );
      expect(SiteLocaleRouting.switchPath('/en/', SiteLanguage.ja), '/');
    });

    test('path parsing ignores query, fragment, and a trailing slash', () {
      expect(
        SiteLocaleRouting.pageForPath('/en/contact/?source=header#form'),
        SitePage.contact,
      );
      expect(
        SiteLocaleRouting.languageForExplicitPath('/en/privacy/'),
        SiteLanguage.en,
      );
    });
  });

  test('stored values accept only supported language codes', () {
    expect(SiteLanguage.fromStoredValue(' JA '), SiteLanguage.ja);
    expect(SiteLanguage.fromStoredValue('en'), SiteLanguage.en);
    expect(SiteLanguage.fromStoredValue('en-US'), isNull);
    expect(SiteLanguage.fromStoredValue(null), isNull);
  });
}
