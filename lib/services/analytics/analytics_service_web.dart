import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:web/web.dart' as web;

Future<void> logAnalyticsEvent(
  String name,
  Map<String, Object?> parameters,
) async {
  final hostname = web.window.location.hostname;
  if (hostname == 'localhost' || hostname == '127.0.0.1' || hostname.isEmpty) {
    return;
  }

  const trackerName = 'tmAnalyticsTrackEvent';
  if (!globalContext.hasProperty(trackerName.toJS).toDart) {
    return;
  }

  final tracker = globalContext.getProperty<JSFunction>(trackerName.toJS);
  tracker.callAsFunction(globalContext, name.toJS, parameters.jsify());
}
