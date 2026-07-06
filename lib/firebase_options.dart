import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseWebConfig {
  const FirebaseWebConfig._();

  static const apiKey = String.fromEnvironment(
    'FIREBASE_WEB_API_KEY',
    defaultValue: 'AIzaSyAly_3Tzd_UDqtvzgQI-N3CSZKiB_Z_lR8',
  );
  static const appId = String.fromEnvironment(
    'FIREBASE_WEB_APP_ID',
    defaultValue: '1:474657305392:web:d51ad38c8047d8f1578ef5',
  );
  static const messagingSenderId = String.fromEnvironment(
    'FIREBASE_WEB_MESSAGING_SENDER_ID',
    defaultValue: '474657305392',
  );
  static const projectId = String.fromEnvironment(
    'FIREBASE_PROJECT_ID',
    defaultValue: 'tm-developer-site',
  );
  static const authDomain = String.fromEnvironment(
    'FIREBASE_WEB_AUTH_DOMAIN',
    defaultValue: 'tm-developer-site.firebaseapp.com',
  );
  static const storageBucket = String.fromEnvironment(
    'FIREBASE_WEB_STORAGE_BUCKET',
    defaultValue: 'tm-developer-site.firebasestorage.app',
  );
  static const measurementId = String.fromEnvironment(
    'FIREBASE_WEB_MEASUREMENT_ID',
    defaultValue: 'G-NREKF9VCL6',
  );
  static const appCheckSiteKey = String.fromEnvironment(
    'FIREBASE_APP_CHECK_RECAPTCHA_SITE_KEY',
    defaultValue: '6LcpAEctAAAAAKIRedEDkZkCaA7pj76LZaJZBqqE',
  );

  static bool get isConfigured {
    return kIsWeb &&
        apiKey.isNotEmpty &&
        appId.isNotEmpty &&
        messagingSenderId.isNotEmpty &&
        projectId.isNotEmpty;
  }

  static FirebaseOptions get web {
    if (!isConfigured) {
      throw StateError('Firebase web configuration is missing.');
    }

    return FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      authDomain: authDomain.isEmpty ? null : authDomain,
      storageBucket: storageBucket.isEmpty ? null : storageBucket,
      measurementId: measurementId.isEmpty ? null : measurementId,
    );
  }
}
