import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../models/contact_message.dart';

class ContactSubmissionNotConfiguredException implements Exception {
  const ContactSubmissionNotConfiguredException();
}

class FirebaseContactMessageSender {
  const FirebaseContactMessageSender([this._firestore]);

  static const collectionName = 'contactMessages';

  final FirebaseFirestore? _firestore;

  Future<void> send(ContactMessage message) async {
    if (Firebase.apps.isEmpty) {
      throw const ContactSubmissionNotConfiguredException();
    }

    final firestore = _firestore ?? FirebaseFirestore.instance;
    await firestore.collection(collectionName).add(message.toFirestoreData());
  }
}
