import 'package:flutter/material.dart';

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
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SiteHeader(),
              HeroSection(),
              SectionBand(child: AboutSection()),
              SectionBand(tinted: true, child: SkillsSection()),
              SectionBand(child: WorksSection()),
              SectionBand(tinted: true, child: WorkStyleSection()),
              SectionBand(child: ContactSection()),
              SiteFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
