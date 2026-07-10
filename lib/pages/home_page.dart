import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../sections/about_section.dart';
import '../sections/contact_section.dart';
import '../sections/hero_section.dart';
import '../sections/skills_section.dart';
import '../sections/work_style_section.dart';
import '../sections/works_section.dart';
import '../services/locale/site_language.dart';
import '../widgets/section_band.dart';
import '../widgets/site_footer.dart';
import '../widgets/site_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    required this.content,
    required this.language,
    required this.onLanguageChanged,
    super.key,
  });

  final SiteContent content;
  final SiteLanguage language;
  final ValueChanged<SiteLanguage> onLanguageChanged;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _topKey = GlobalKey();
  final _worksKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _workStyleKey = GlobalKey();
  final _contactKey = GlobalKey();

  Future<void> _scrollTo(GlobalKey key) async {
    final targetContext = key.currentContext;
    if (targetContext == null) {
      return;
    }
    await Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 520),
      curve: Curves.easeOutCubic,
      alignment: 0.02,
    );
  }

  void _openPrivacy() {
    Navigator.of(context).pushNamed(
      SiteLocaleRouting.pathFor(
        page: SitePage.privacy,
        language: widget.language,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              KeyedSubtree(
                key: _topKey,
                child: SiteHeader(
                  content: widget.content,
                  language: widget.language,
                  onLanguageChanged: widget.onLanguageChanged,
                  onBrandPressed: () => _scrollTo(_topKey),
                  onWorksPressed: () => _scrollTo(_worksKey),
                  onSkillsPressed: () => _scrollTo(_skillsKey),
                  onWorkStylePressed: () => _scrollTo(_workStyleKey),
                  onContactPressed: () => _scrollTo(_contactKey),
                ),
              ),
              HeroSection(
                content: widget.content,
                onContactPressed: () => _scrollTo(_contactKey),
              ),
              SectionBand(child: AboutSection(content: widget.content.about)),
              KeyedSubtree(
                key: _worksKey,
                child: SectionBand(
                  tinted: true,
                  child: WorksSection(content: widget.content.works),
                ),
              ),
              KeyedSubtree(
                key: _skillsKey,
                child: SectionBand(
                  child: SkillsSection(content: widget.content.skills),
                ),
              ),
              KeyedSubtree(
                key: _workStyleKey,
                child: SectionBand(
                  tinted: true,
                  child: WorkStyleSection(content: widget.content.workStyle),
                ),
              ),
              KeyedSubtree(
                key: _contactKey,
                child: SectionBand(
                  child: ContactSection(
                    content: widget.content.contact,
                    email: widget.content.email,
                  ),
                ),
              ),
              SiteFooter(
                content: widget.content,
                onPrivacyPressed: _openPrivacy,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
