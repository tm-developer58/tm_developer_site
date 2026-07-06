import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../sections/contact_section.dart';
import '../widgets/section_band.dart';
import '../widgets/site_footer.dart';
import '../widgets/site_header.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({required this.content, super.key});

  static const routeName = '/contact';

  final SiteContent content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SiteHeader(content: content),
            SectionBand(
              child: ContactSection(
                content: content.contact,
                email: content.email,
              ),
            ),
            SiteFooter(content: content),
          ],
        ),
      ),
    );
  }
}
