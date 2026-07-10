import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tm_developer_site/app.dart';
import 'package:tm_developer_site/content/site_content.dart';
import 'package:tm_developer_site/widgets/app_work_card.dart';
import 'package:tm_developer_site/widgets/contact_form.dart';
import 'package:tm_developer_site/widgets/safe_asset_image.dart';

void main() {
  testWidgets('shows developer landing page copy', (tester) async {
    await tester.pumpWidget(
      const TmDeveloperSiteApp(browserLocaleCodes: ['ja-JP']),
    );

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

    await tester.pumpWidget(
      const TmDeveloperSiteApp(browserLocaleCodes: ['ja-JP']),
    );

    expect(find.text('相談する'), findsWidgets);
    expect(find.text('コーヒータイマー'), findsOneWidget);
  });

  testWidgets('work preview preserves the full portrait image', (tester) async {
    final work = SiteContent.ja.works.items.first;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: 380,
              child: AppWorkCard(work: work, content: SiteContent.ja.works),
            ),
          ),
        ),
      ),
    );

    final preview = tester.widget<SafeAssetImage>(
      find.byKey(ValueKey('work-screenshot-${work.screenshotAsset}')),
    );
    expect(preview.fit, BoxFit.contain);
  });

  testWidgets('shows validation messages on the contact form', (tester) async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController(text: 'invalid-email');
    final subjectController = TextEditingController();
    final messageController = TextEditingController();

    addTearDown(nameController.dispose);
    addTearDown(emailController.dispose);
    addTearDown(subjectController.dispose);
    addTearDown(messageController.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ContactForm(
            formKey: formKey,
            content: SiteContent.ja.contact,
            nameController: nameController,
            emailController: emailController,
            subjectController: subjectController,
            messageController: messageController,
            onSubmit: () => formKey.currentState!.validate(),
          ),
        ),
      ),
    );

    await tester.tap(find.text(SiteContent.ja.contact.submitLabel));
    await tester.pump();

    expect(find.text(SiteContent.ja.contact.requiredMessage), findsWidgets);
    expect(
      find.text(SiteContent.ja.contact.invalidEmailMessage),
      findsOneWidget,
    );
  });
}
