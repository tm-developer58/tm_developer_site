import 'analytics_service_stub.dart'
    if (dart.library.html) 'analytics_service_web.dart'
    as backend;

class AnalyticsEvents {
  const AnalyticsEvents._();

  static const contactClick = 'contact_click';
  static const githubClick = 'github_click';
  static const appCardClick = 'app_card_click';
}

class AnalyticsService {
  const AnalyticsService._();

  static Future<void> logEvent(
    String name, {
    Map<String, Object?> parameters = const {},
  }) {
    return backend.logAnalyticsEvent(name, parameters);
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
