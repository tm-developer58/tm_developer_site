import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../sections/contact_section.dart';
import '../services/locale/site_language.dart';
import '../widgets/section_band.dart';
import '../widgets/site_footer.dart';
import '../widgets/site_header.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({
    required this.content,
    required this.language,
    required this.onLanguageChanged,
    super.key,
  });

  static const routeName = '/contact';

  final SiteContent content;
  final SiteLanguage language;
  final ValueChanged<SiteLanguage> onLanguageChanged;

  void _open(BuildContext context, SitePage page) {
    final path = SiteLocaleRouting.pathFor(page: page, language: language);
    Navigator.of(context).pushReplacementNamed(path);
  }

  @override
  Widget build(BuildContext context) {
    void openHome() => _open(context, SitePage.home);
    return Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SiteHeader(
                content: content,
                language: language,
                onLanguageChanged: onLanguageChanged,
                onBrandPressed: openHome,
                onWorksPressed: openHome,
                onSkillsPressed: openHome,
                onWorkStylePressed: openHome,
                onContactPressed: () {},
              ),
              SectionBand(
                child: ContactSection(
                  content: content.contact,
                  email: content.email,
                ),
              ),
              SiteFooter(
                content: content,
                onPrivacyPressed: () => _open(context, SitePage.privacy),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
