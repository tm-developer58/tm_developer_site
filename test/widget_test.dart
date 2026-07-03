import 'package:flutter_test/flutter_test.dart';

import 'package:tm_developer_site/main.dart';

void main() {
  testWidgets('shows developer landing page copy', (tester) async {
    await tester.pumpWidget(const TmDeveloperSiteApp());

    expect(find.text('TM Developer'), findsOneWidget);
    expect(find.text('Flutter / Firebase Developer'), findsOneWidget);
  });
}
