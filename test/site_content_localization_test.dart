import 'package:flutter_test/flutter_test.dart';
import 'package:tm_developer_site/content/site_content.dart';
import 'package:tm_developer_site/services/locale/site_language.dart';

void main() {
  test('forLanguage selects the matching immutable content bundle', () {
    expect(SiteContent.forLanguage(SiteLanguage.ja), same(SiteContent.ja));
    expect(SiteContent.forLanguage(SiteLanguage.en), same(SiteContent.en));
  });

  test('Japanese and English bundles include navigation and policy labels', () {
    expect(SiteContent.ja.navigation.worksLabel, '実績');
    expect(SiteContent.en.navigation.worksLabel, 'Work');
    expect(
      SiteContent.ja.navigation.languageToggleSemanticsLabel,
      '英語表示に切り替える',
    );
    expect(
      SiteContent.en.navigation.languageToggleSemanticsLabel,
      'Switch to Japanese',
    );
    expect(SiteContent.ja.privacyPolicy.backToHomeLabel, 'トップへ戻る');
    expect(SiteContent.en.privacyPolicy.backToHomeLabel, 'Back to home');
  });

  test('both bundles cover every work item and privacy section', () {
    expect(SiteContent.ja.works.items, hasLength(3));
    expect(SiteContent.en.works.items, hasLength(3));
    expect(
      SiteContent.en.privacyPolicy.sections.length,
      SiteContent.ja.privacyPolicy.sections.length,
    );

    for (final work in SiteContent.en.works.items) {
      expect(work.title, isNotEmpty);
      expect(work.summary, isNotEmpty);
      expect(work.note, isNotEmpty);
      expect(work.iconAsset, startsWith('assets/apps/'));
      expect(work.screenshotAsset, startsWith('assets/apps/'));
    }
  });

  test('contact length messages interpolate label and limit', () {
    expect(
      SiteContent.ja.contact.maxLengthMessage('件名', 120),
      '件名は120文字以内で入力してください',
    );
    expect(
      SiteContent.en.contact.maxLengthMessage('Subject', 120),
      'Subject must be 120 characters or fewer',
    );
  });
}
