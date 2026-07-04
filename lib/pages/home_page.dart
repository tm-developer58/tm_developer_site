import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../sections/about_section.dart';
import '../sections/contact_section.dart';
import '../sections/hero_section.dart';
import '../sections/skills_section.dart';
import '../sections/work_style_section.dart';
import '../sections/works_section.dart';
import '../widgets/section_band.dart';
import '../widgets/site_footer.dart';
import '../widgets/site_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.content, super.key});

  final SiteContent content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SiteHeader(content: content),
              HeroSection(content: content),
              SectionBand(child: AboutSection(content: content.about)),
              SectionBand(
                tinted: true,
                child: SkillsSection(content: content.skills),
              ),
              SectionBand(child: WorksSection(content: content.works)),
              SectionBand(
                tinted: true,
                child: WorkStyleSection(content: content.workStyle),
              ),
              SectionBand(
                child: ContactSection(
                  content: content.contact,
                  email: content.email,
                ),
              ),
              SiteFooter(text: content.footerText),
            ],
          ),
        ),
      ),
    );
  }
}
