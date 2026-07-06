import 'dart:async';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';

class FirebaseBootstrap {
  const FirebaseBootstrap._();

  static Future<bool> initialize() async {
    if (!FirebaseWebConfig.isConfigured) {
      return false;
    }

    await Firebase.initializeApp(options: FirebaseWebConfig.web);

    if (FirebaseWebConfig.appCheckSiteKey.isNotEmpty) {
      unawaited(_activateAppCheck());
    }

    return true;
  }

  static Future<void> _activateAppCheck() async {
    await FirebaseAppCheck.instance.activate(
      providerWeb: ReCaptchaV3Provider(FirebaseWebConfig.appCheckSiteKey),
    );
  }
}
