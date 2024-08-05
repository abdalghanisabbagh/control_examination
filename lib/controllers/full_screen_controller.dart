// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FullScreenController extends GetxController {
  final FocusNode focusNode = FocusNode()..requestFocus();

  String lastKey = '';
  Future<void> enterFullScreen() async {
    try {
      await html.window.document.documentElement?.requestFullscreen();
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

  bool isFullScreen() {
    debugPrint('Is full screen: ${html.document.fullscreenElement != null}');
    return html.document.fullscreenElement != null;
  }

  @override
  void onClose() {
    exitFullScreen();
    super.onClose();
  }

  @override
  void onInit() async {
    await enterFullScreen();
    super.onInit();
  }

  void updateLastKey(String key) {
    lastKey = key;
    update();
  }
}
