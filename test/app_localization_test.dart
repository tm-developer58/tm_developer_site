import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tm_developer_site/app.dart';
import 'package:tm_developer_site/content/site_content.dart';
import 'package:tm_developer_site/services/locale/locale_preference_store.dart';
import 'package:tm_developer_site/services/locale/site_language.dart';

void main() {
  Future<void> pumpApp(
    WidgetTester tester, {
    required String initialPath,
    required Iterable<String> browserLocaleCodes,
    required _FakeLocalePreferenceStore store,
  }) async {
    tester.view.physicalSize = const Size(1440, 1200);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(
      TmDeveloperSiteApp(
        initialPath: initialPath,
        browserLocaleCodes: browserLocaleCodes,
        localePreferenceStore: store,
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('Japanese browser locale shows Japanese at the root', (
    tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final store = _FakeLocalePreferenceStore();

    await pumpApp(
      tester,
      initialPath: '/',
      browserLocaleCodes: const ['ja-JP'],
      store: store,
    );

    expect(find.text(SiteContent.ja.hero.title), findsOneWidget);
    expect(find.text(SiteContent.en.hero.title), findsNothing);
    expect(store.writes, isEmpty);
  });

  testWidgets('non-Japanese browser locale shows English at the root', (
    tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final store = _FakeLocalePreferenceStore();

    await pumpApp(
      tester,
      initialPath: '/',
      browserLocaleCodes: const ['en-US'],
      store: store,
    );

    expect(find.text(SiteContent.en.hero.title), findsOneWidget);
    expect(find.text(SiteContent.ja.hero.title), findsNothing);
    expect(find.text('EN'), findsOneWidget);
  });

  testWidgets('saved manual selection wins over browser locale at the root', (
    tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final store = _FakeLocalePreferenceStore(SiteLanguage.en);

    await pumpApp(
      tester,
      initialPath: '/',
      browserLocaleCodes: const ['ja-JP'],
      store: store,
    );

    expect(find.text(SiteContent.en.hero.title), findsOneWidget);
    expect(find.text(SiteContent.ja.hero.title), findsNothing);
  });

  testWidgets('explicit English contact route shows the English form', (
    tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final store = _FakeLocalePreferenceStore(SiteLanguage.ja);

    await pumpApp(
      tester,
      initialPath: '/en/contact',
      browserLocaleCodes: const ['ja-JP'],
      store: store,
    );

    expect(find.text(SiteContent.en.contact.title), findsOneWidget);
    expect(find.text(SiteContent.en.contact.formOptionTitle), findsOneWidget);
    expect(find.text(SiteContent.ja.contact.title), findsNothing);
  });

  testWidgets('header language toggle updates content and saves selection', (
    tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final store = _FakeLocalePreferenceStore();

    await pumpApp(
      tester,
      initialPath: '/',
      browserLocaleCodes: const ['ja-JP'],
      store: store,
    );

    await tester.tap(find.text('JA'));
    await tester.pumpAndSettle();

    expect(find.text(SiteContent.en.hero.title), findsOneWidget);
    expect(find.text('EN'), findsOneWidget);
    expect(store.value, SiteLanguage.en);
    expect(store.writes, [SiteLanguage.en]);
  });
}

class _FakeLocalePreferenceStore implements LocalePreferenceStore {
  _FakeLocalePreferenceStore([this.value]);

  SiteLanguage? value;
  final List<SiteLanguage> writes = [];

  @override
  SiteLanguage? read() => value;

  @override
  void write(SiteLanguage language) {
    value = language;
    writes.add(language);
  }
}
