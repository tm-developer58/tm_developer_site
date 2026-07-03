import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tm_developer_site/main.dart';

void main() {
  testWidgets('shows developer landing page copy', (tester) async {
    await tester.pumpWidget(const TmDeveloperSiteApp());

    expect(find.text('TM Developer'), findsOneWidget);
    expect(find.text('Flutter / Firebase Developer'), findsOneWidget);
  });

  testWidgets('renders on a mobile width without layout overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const TmDeveloperSiteApp());

    expect(find.text('相談する'), findsOneWidget);
    expect(find.text('コーヒータイマー'), findsOneWidget);
  });
}
