// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:control_examination/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FullScreenController extends GetxController {
  final FocusNode focusNode = FocusNode()..requestFocus();
  String lastKey = '';
  final studentInExamController = Get.find<StudentInExamController>();

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
      studentInExamController.markStudentCheating();
      return true;
    }

    return false;
  }

  bool isInFullScreen() {
    var result = js.context.callMethod('isFullScreen');
    return result ?? false;
  }

  @override
  void onClose() {
    removeListeners();
    exitFullScreen();
    super.onClose();
  }

  @override
  void onInit() async {
    await enterFullScreen();
    html.window.addEventListener('fullscreenchange', (event) {
      if (Hive.box('ExamMission').get('inExam', defaultValue: false)) {
        isInFullScreen() ? null : studentInExamController.markStudentCheating();
      }
    });
    super.onInit();
  }

  removeListeners() {
    html.window.removeEventListener('fullscreenchange', (event) => true, true);
  }

  void updateLastKey(String key) {
    lastKey = key;
    update();
  }
}
