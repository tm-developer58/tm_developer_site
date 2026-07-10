import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../models/contact_message.dart';

class ContactSubmissionNotConfiguredException implements Exception {
  const ContactSubmissionNotConfiguredException();
}

class ContactRateLimitedException implements Exception {
  const ContactRateLimitedException();
}

class ContactSubmissionFailedException implements Exception {
  const ContactSubmissionFailedException();
}

abstract interface class ContactMessageSender {
  Future<void> send(ContactMessage message);
}

class FirebaseContactMessageSender implements ContactMessageSender {
  const FirebaseContactMessageSender([this._functions]);

  static const functionName = 'submitContactMessage';
  static const region = 'asia-northeast1';

  final FirebaseFunctions? _functions;

  @override
  Future<void> send(ContactMessage message) async {
    if (Firebase.apps.isEmpty) {
      throw const ContactSubmissionNotConfiguredException();
    }

    final functions =
        _functions ?? FirebaseFunctions.instanceFor(region: region);
    try {
      await functions
          .httpsCallable(functionName)
          .call<Map<String, Object?>>(message.toCallableData());
    } on FirebaseFunctionsException catch (error) {
      if (error.code == 'resource-exhausted') {
        throw const ContactRateLimitedException();
      }
      throw const ContactSubmissionFailedException();
    }
  }
}
