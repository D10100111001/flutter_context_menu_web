import 'dart:async';

import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('plugins.sasid.me/context_menu');

/// Checks whether the specified URL can be handled by some app installed on the
/// device.
Future<bool> toggleDefaultContextMenu(bool enable) async {
  if (enable == null) {
    return false;
  }
  return await _channel.invokeMethod<bool>(
    'toggleDefaultContextMenu',
    <String, Object>{'enable': enable},
  );
}
