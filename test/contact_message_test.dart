import 'package:flutter_test/flutter_test.dart';
import 'package:tm_developer_site/models/contact_message.dart';
import 'package:tm_developer_site/services/contact/contact_message_sender.dart';

void main() {
  test('builds trimmed firestore contact message data', () {
    const message = ContactMessage(
      name: '  Test User  ',
      email: '  user@example.com  ',
      subject: '  App相談  ',
      message: '  Flutterアプリの改修を相談したいです。  ',
    );

    expect(message.toFirestoreData(createdAt: 'server-time'), {
      'name': 'Test User',
      'email': 'user@example.com',
      'subject': 'App相談',
      'message': 'Flutterアプリの改修を相談したいです。',
      'createdAt': 'server-time',
      'status': 'new',
      'source': 'contact_form',
    });
  });

  test('uses contactMessages collection', () {
    expect(FirebaseContactMessageSender.collectionName, 'contactMessages');
  });
}
