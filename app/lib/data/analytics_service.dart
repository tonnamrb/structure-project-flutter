import 'package:flutter/foundation.dart';

/// Simple analytics facade to track spec-defined events.
/// Replace implementation to hook into Firebase Analytics or similar.
class AnalyticsService {
  void logEvent(String name, {Map<String, dynamic>? params}) {
    // For now, just print to console for visibility during development.
    debugPrint('[Analytics] $name ${params ?? ''}');
  }
}
