import 'package:cloud_firestore/cloud_firestore.dart';

class ContactMessage {
  const ContactMessage({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    this.status = 'new',
    this.source = 'contact_form',
  });

  final String name;
  final String email;
  final String subject;
  final String message;
  final String status;
  final String source;

  Map<String, Object?> toFirestoreData({Object? createdAt}) {
    return {
      'name': name.trim(),
      'email': email.trim(),
      'subject': subject.trim(),
      'message': message.trim(),
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'status': status,
      'source': source,
    };
  }
}
