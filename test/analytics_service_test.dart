import 'package:flutter_test/flutter_test.dart';
import 'package:tm_developer_site/services/analytics/analytics_service.dart';

void main() {
  test('contact conversion events use stable non-PII names', () {
    expect(AnalyticsEvents.contactSubmitSuccess, 'contact_submit_success');
    expect(AnalyticsEvents.contactSubmitFailure, 'contact_submit_failure');
    expect(AnalyticsEvents.contactRateLimited, 'contact_rate_limited');
  });
}
