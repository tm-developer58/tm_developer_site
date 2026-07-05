import '../content/site_content.dart';

Uri buildContactMailUri({
  required ContactContent content,
  required String recipient,
  required String name,
  required String email,
  required String subject,
  required String message,
}) {
  final body = [
    '${content.mailNamePrefix}: ${name.trim()}',
    '${content.mailEmailPrefix}: ${email.trim()}',
    '',
    message.trim(),
  ].join('\n');

  return Uri(
    scheme: 'mailto',
    path: recipient,
    queryParameters: {'subject': subject.trim(), 'body': body},
  );
}
