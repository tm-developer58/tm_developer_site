import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'content/site_content.dart';
import 'pages/home_page.dart';
import 'pages/privacy_policy_page.dart';

class TmDeveloperSiteApp extends StatelessWidget {
  const TmDeveloperSiteApp({super.key});

  static const _content = SiteContent.ja;
  static const _homeRoute = '/';

  static String get _initialRoute {
    return Uri.base.path == PrivacyPolicyPage.routeName
        ? PrivacyPolicyPage.routeName
        : _homeRoute;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _content.pageTitle,
      debugShowCheckedModeBanner: false,
      locale: const Locale('ja'),
      supportedLocales: const [Locale('ja'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: _initialRoute,
      routes: {
        _homeRoute: (_) => const HomePage(content: _content),
        PrivacyPolicyPage.routeName: (_) =>
            const PrivacyPolicyPage(content: _content),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        textTheme: Typography.blackCupertino.apply(
          bodyColor: const Color(0xFF182033),
          displayColor: const Color(0xFF182033),
        ),
        useMaterial3: true,
      ),
    );
  }
}
