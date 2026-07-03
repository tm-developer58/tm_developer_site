import 'package:flutter/material.dart';

import 'pages/home_page.dart';

class TmDeveloperSiteApp extends StatelessWidget {
  const TmDeveloperSiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TM Developer',
      debugShowCheckedModeBanner: false,
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
      home: const HomePage(),
    );
  }
}
