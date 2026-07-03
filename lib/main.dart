import 'package:flutter/material.dart';

void main() {
  runApp(const TmDeveloperSiteApp());
}

class TmDeveloperSiteApp extends StatelessWidget {
  const TmDeveloperSiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TM Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1D4ED8)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'TM Developer',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const Expanded(
              child: Center(child: Text('Flutter / Firebase Developer')),
            ),
          ],
        ),
      ),
    );
  }
}
