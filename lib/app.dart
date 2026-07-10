import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'content/site_content.dart';
import 'pages/contact_page.dart';
import 'pages/home_page.dart';
import 'pages/privacy_policy_page.dart';
import 'services/locale/locale_preference_store.dart';
import 'services/locale/site_language.dart';
import 'services/metadata/site_metadata.dart';
import 'theme/site_theme.dart';

class TmDeveloperSiteApp extends StatefulWidget {
  const TmDeveloperSiteApp({
    this.initialPath,
    this.browserLocaleCodes,
    this.localePreferenceStore,
    super.key,
  });

  final String? initialPath;
  final Iterable<String>? browserLocaleCodes;
  final LocalePreferenceStore? localePreferenceStore;

  @override
  State<TmDeveloperSiteApp> createState() => _TmDeveloperSiteAppState();
}

class _TmDeveloperSiteAppState extends State<TmDeveloperSiteApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final LocalePreferenceStore _preferenceStore;
  late final _SiteRouteObserver _routeObserver;
  late final String _initialPath;
  late SiteLanguage _language;
  late String _currentPath;

  @override
  void initState() {
    super.initState();
    _preferenceStore =
        widget.localePreferenceStore ?? createLocalePreferenceStore();
    _routeObserver = _SiteRouteObserver(_handleRouteChanged);

    final incomingPath = widget.initialPath ?? Uri.base.path;
    final browserLocales =
        widget.browserLocaleCodes ??
        PlatformDispatcher.instance.locales.map(
          (locale) => locale.toLanguageTag(),
        );
    _initialPath = SiteLocaleRouting.resolveInitialPath(
      path: incomingPath,
      storedLanguage: _preferenceStore.read(),
      browserLocaleCodes: browserLocales,
    );
    _language = _languageForLocalizedPath(_initialPath);
    _currentPath = _initialPath;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: SiteContent.forLanguage(_language).pageTitle,
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      navigatorObservers: [_routeObserver],
      locale: Locale(_language.languageCode),
      supportedLocales: const [Locale('ja'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: buildSiteTheme(),
      initialRoute: _initialPath,
      onGenerateInitialRoutes: (initialRoute) => [_buildRoute(initialRoute)],
      onGenerateRoute: (settings) => _buildRoute(settings.name),
    );
  }

  MaterialPageRoute<void> _buildRoute(String? requestedPath) {
    final requestedPage = SiteLocaleRouting.pageForPath(
      requestedPath ?? _currentPath,
    );
    final explicitLanguage = SiteLocaleRouting.languageForExplicitPath(
      requestedPath ?? _currentPath,
    );
    final routeLanguage =
        explicitLanguage ??
        ((requestedPath ?? _currentPath) == '/' ? SiteLanguage.ja : _language);
    final path = SiteLocaleRouting.pathFor(
      page: requestedPage,
      language: routeLanguage,
    );
    final content = SiteContent.forLanguage(routeLanguage);

    return MaterialPageRoute<void>(
      settings: RouteSettings(name: path),
      builder: (_) => switch (requestedPage) {
        SitePage.home => HomePage(
          content: content,
          language: routeLanguage,
          onLanguageChanged: _changeLanguage,
        ),
        SitePage.contact => ContactPage(
          content: content,
          language: routeLanguage,
          onLanguageChanged: _changeLanguage,
        ),
        SitePage.privacy => PrivacyPolicyPage(
          content: content,
          language: routeLanguage,
          onLanguageChanged: _changeLanguage,
        ),
      },
    );
  }

  void _changeLanguage(SiteLanguage language) {
    if (language == _language) {
      return;
    }

    _preferenceStore.write(language);
    final targetPath = SiteLocaleRouting.switchPath(_currentPath, language);
    setState(() {
      _language = language;
      _currentPath = targetPath;
    });
    _navigatorKey.currentState?.pushReplacementNamed(targetPath);
  }

  void _handleRouteChanged(String? path) {
    if (path == null) {
      return;
    }
    final routeLanguage = _languageForLocalizedPath(path);
    final needsRebuild = routeLanguage != _language || path != _currentPath;
    if (needsRebuild) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          _language = routeLanguage;
          _currentPath = path;
        });
      });
    }
    _scheduleMetadataUpdate(path);
  }

  void _scheduleMetadataUpdate(String path) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      final page = SiteLocaleRouting.pageForPath(path);
      final language = _languageForLocalizedPath(path);
      final content = SiteContent.forLanguage(language);
      final title = switch (page) {
        SitePage.home => content.pageTitle,
        SitePage.contact => '${content.contact.title} | ${content.brandName}',
        SitePage.privacy =>
          '${content.privacyPolicy.pageTitle} | ${content.brandName}',
      };
      final description = switch (page) {
        SitePage.home => content.description,
        SitePage.contact => content.contact.body,
        SitePage.privacy => content.privacyPolicy.intro,
      };
      updateSiteMetadata(
        languageCode: language.languageCode,
        title: title,
        description: description,
        currentPath: path,
        japanesePath: SiteLocaleRouting.pathFor(
          page: page,
          language: SiteLanguage.ja,
        ),
        englishPath: SiteLocaleRouting.pathFor(
          page: page,
          language: SiteLanguage.en,
        ),
      );
    });
  }

  SiteLanguage _languageForLocalizedPath(String path) {
    return SiteLocaleRouting.languageForExplicitPath(path) ?? SiteLanguage.ja;
  }
}

class _SiteRouteObserver extends NavigatorObserver {
  _SiteRouteObserver(this.onChanged);

  final ValueChanged<String?> onChanged;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    onChanged(route.settings.name);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    onChanged(previousRoute?.settings.name);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    onChanged(newRoute?.settings.name);
  }
}
