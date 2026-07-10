import 'analytics_service_stub.dart'
    if (dart.library.html) 'analytics_service_web.dart'
    as backend;

class AnalyticsEvents {
  const AnalyticsEvents._();

  static const contactClick = 'contact_click';
  static const contactSubmitSuccess = 'contact_submit_success';
  static const contactSubmitFailure = 'contact_submit_failure';
  static const contactRateLimited = 'contact_rate_limited';
  static const githubClick = 'github_click';
  static const appCardClick = 'app_card_click';
}

class AnalyticsService {
  const AnalyticsService._();

  static Future<void> logEvent(
    String name, {
    Map<String, Object?> parameters = const {},
  }) async {
    try {
      await backend.logAnalyticsEvent(name, parameters);
    } catch (_) {
      // Analytics must never prevent a user action from completing.
    }
  }

  static Future<void> logContactClick({required String source}) {
    return logEvent(
      AnalyticsEvents.contactClick,
      parameters: {'source': source},
    );
  }

  static Future<void> logGithubClick({required String source}) {
    return logEvent(
      AnalyticsEvents.githubClick,
      parameters: {'source': source},
    );
  }

  static Future<void> logContactSubmitSuccess() {
    return logEvent(AnalyticsEvents.contactSubmitSuccess);
  }

  static Future<void> logContactSubmitFailure({required String reason}) {
    return logEvent(
      AnalyticsEvents.contactSubmitFailure,
      parameters: {'reason': reason},
    );
  }

  static Future<void> logContactRateLimited() {
    return logEvent(AnalyticsEvents.contactRateLimited);
  }

  static Future<void> logAppCardClick({
    required String appName,
    required String url,
  }) {
    return logEvent(
      AnalyticsEvents.appCardClick,
      parameters: {'app_name': appName, 'url': url},
    );
  }
}
