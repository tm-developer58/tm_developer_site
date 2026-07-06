import 'dart:async';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';

class FirebaseBootstrap {
  const FirebaseBootstrap._();

  static Future<bool> initialize() async {
    if (!FirebaseWebConfig.isConfigured) {
      return false;
    }

    try {
      await Firebase.initializeApp(options: FirebaseWebConfig.web);
    } catch (error, stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'firebase bootstrap',
          context: ErrorDescription('while initializing Firebase'),
        ),
      );
      return false;
    }

    if (FirebaseWebConfig.appCheckSiteKey.isNotEmpty) {
      unawaited(
        _activateAppCheck().catchError((Object error, StackTrace stackTrace) {
          FlutterError.reportError(
            FlutterErrorDetails(
              exception: error,
              stack: stackTrace,
              library: 'firebase bootstrap',
              context: ErrorDescription('while activating Firebase App Check'),
            ),
          );
        }),
      );
    }

    return true;
  }

  static Future<void> _activateAppCheck() async {
    await FirebaseAppCheck.instance.activate(
      providerWeb: ReCaptchaV3Provider(FirebaseWebConfig.appCheckSiteKey),
    );
  }
}
