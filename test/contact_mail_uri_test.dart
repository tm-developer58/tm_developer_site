import 'package:flutter_test/flutter_test.dart';
import 'package:tm_developer_site/content/site_content.dart';
import 'package:tm_developer_site/utils/contact_mail_uri.dart';

void main() {
  test('builds prefilled contact mailto uri', () {
    final uri = buildContactMailUri(
      content: SiteContent.ja.contact,
      recipient: SiteContent.ja.email,
      name: '  Test User  ',
      email: '  user@example.com  ',
      subject: '  App相談  ',
      message: '  Flutterアプリの改修を相談したいです。  ',
    );

    expect(uri.scheme, 'mailto');
    expect(uri.path, SiteContent.ja.email);
    expect(uri.queryParameters['subject'], 'App相談');
    expect(
      uri.queryParameters['body'],
      [
        'お名前: Test User',
        'メール: user@example.com',
        '',
        'Flutterアプリの改修を相談したいです。',
      ].join('\n'),
    );
  });
}
