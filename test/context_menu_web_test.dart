@TestOn('chrome') // Uses web-only Flutter SDK

import 'dart:html' as html;

import 'package:flutter_context_menu_web/context_menu.dart';
import 'package:flutter_context_menu_web/context_menu_plugin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  group('Controlling the Context Menu for Web', () {
    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      webPluginRegistry.registerMessageHandler();
      final Registrar registrar =
          webPluginRegistry.registrarFor(ContextMenuPlugin);
      ContextMenuPlugin.registerWith(registrar);
    });

    test('enabling the context menu returns true', () {
      expect(toggleDefaultContextMenu(true), completion(isTrue));
    });

    test('disabling the context menu returns true', () {
      expect(toggleDefaultContextMenu(true), completion(isTrue));
    });

    test('context menu does not appear when disabled', () {
      final ContextMenuPlugin urlLauncherPlugin = ContextMenuPlugin();
      urlLauncherPlugin.toggleContextMenuEventPropagation(false);

      bool called = false;
      html.window.addEventListener('contextmenu', (e) => called = true);
      expect(called, false);

      urlLauncherPlugin.toggleContextMenuEventPropagation(true);
      called = false;
      expect(called, true);
    });
  });
}
