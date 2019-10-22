import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:meta/meta.dart';

class ContextMenuPlugin {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel('plugins.sasid.me/context_menu',
        const StandardMethodCodec(), registrar.messenger);
    final ContextMenuPlugin instance = ContextMenuPlugin();
    channel.setMethodCallHandler(instance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'toggleDefaultContextMenu':
        final bool enable = call.arguments['enable'];
        return _toggleDefaultContextMenu(enable);
      default:
        throw PlatformException(
            code: 'Unimplemented',
            details: "The url_launcher plugin for web doesn't implement "
                "the method '${call.method}'");
    }
  }

  final preventContextMenuHandler = (html.Event e) => e.preventDefault();  
  final stopPropagationContextMenuHandler = (html.Event e) => e.stopPropagation();


  bool _toggleDefaultContextMenu(bool enable) {
    toggleContextMenu(enable);
    return true;
  }

  @visibleForTesting
  void toggleContextMenu(bool enable) {
    if (enable)
      html.document
          .removeEventListener('contextmenu', preventContextMenuHandler);
    else
      html.document
          .addEventListener('contextmenu', preventContextMenuHandler, false);
  }

  @visibleForTesting
  void toggleContextMenuEventPropagation(bool enable) {
    if (enable)
      html.document
          .removeEventListener('contextmenu', stopPropagationContextMenuHandler);
    else
      html.document
          .addEventListener('contextmenu', stopPropagationContextMenuHandler, false);
  }
}
