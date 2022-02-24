import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fpjs_pro_plugin/region.dart';

class FpjsProPlugin {
  static var isInitialized = false;
  static const channelName = 'fpjs_pro_plugin';
  static const MethodChannel _channel = MethodChannel(channelName);

  /// Initializes the native FingerprintJS Pro client
  /// Throws a [PlatformError] if [apiKey] is missing
  static Future<void> initFpjs(String apiKey,
      {String? endpoint, Region? region}) async {
    await _channel.invokeMethod('init', {
      'apiToken': apiKey,
      'endpoint': endpoint,
      'region': region?.stringValue,
    });
    isInitialized = true;
  }

  /// Returns the visitor id generated by the native FingerprintJS Pro client
  /// Support [tags](https://dev.fingerprintjs.com/docs/quick-start-guide#tagging-your-requests)
  /// Throws a [PlatformError] if identification request fails for any reason
  static Future<String?> getVisitorId({Map<String, dynamic>? tags}) async {
    if (!isInitialized) {
      throw Exception(
          'You need to initialize the FPJS Client first by calling the "initFpjs" method');
    }

    final String? visitorId = await _channel.invokeMethod('getVisitorId');
    return visitorId;
  }
}
