import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import 'package:flutter/services.dart';

class FullScreenController extends GetxController {
  String lastKey = '';
  void enterFullScreen() {
    try {
      html.window.document.documentElement?.requestFullscreen();
    } catch (e) {
      debugPrint('Error entering full screen: $e');
    }
  }

  void exitFullScreen() {
    try {
      html.document.exitFullscreen();
    } catch (e) {
      debugPrint('Error exiting full screen: $e');
    }
  }

  bool isFullScreen() {
    debugPrint('Is full screen: ${html.document.fullscreenElement != null}');
    return html.document.fullscreenElement != null;
  }

  bool handleKeyEvent(KeyEvent event) {
    if (HardwareKeyboard.instance.isAltPressed ||
        HardwareKeyboard.instance.isControlPressed ||
        HardwareKeyboard.instance.isMetaPressed ||
        HardwareKeyboard.instance.isShiftPressed ||
        HardwareKeyboard.instance
            .isLogicalKeyPressed(LogicalKeyboardKey.printScreen) ||
        HardwareKeyboard.instance
            .isLogicalKeyPressed(LogicalKeyboardKey.print) ||
        HardwareKeyboard.instance
            .isLogicalKeyPressed(LogicalKeyboardKey.browserBack) ||
        HardwareKeyboard.instance
            .isLogicalKeyPressed(LogicalKeyboardKey.browserStop) ||
        HardwareKeyboard.instance.isLogicalKeyPressed(LogicalKeyboardKey.f12) ||
        HardwareKeyboard.instance.isLogicalKeyPressed(LogicalKeyboardKey.f5) ||
        HardwareKeyboard.instance.isLogicalKeyPressed(LogicalKeyboardKey.f6) ||
        HardwareKeyboard.instance.isLogicalKeyPressed(LogicalKeyboardKey.f4) ||
        HardwareKeyboard.instance.isLogicalKeyPressed(LogicalKeyboardKey.tab)) {
      debugPrint("Key pressed: ${event.logicalKey.debugName}");
      return true;
    }

    if (HardwareKeyboard.instance.isLogicalKeyPressed(LogicalKeyboardKey.f11)) {
      if (isFullScreen()) {
        exitFullScreen();
      } else {
        enterFullScreen();
      }
      return true;
    }

    return false; 
  }

  void updateLastKey(String key) {
    lastKey = key;
    update(); 
  }
}
