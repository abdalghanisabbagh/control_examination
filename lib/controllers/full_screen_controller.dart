// ignore: avoid_web_libraries_in_flutter
//import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
//import 'dart:js' as js;

import 'package:control_examination/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// FullScreenController is a GetxController that handles entering and exiting
/// full screen mode.
///
/// It also prevents the user from using certain keyboard shortcuts.
class FullScreenController extends GetxController {
  /// The focus node that is used to request focus on the page.
  final FocusNode focusNode = FocusNode()..requestFocus();

  /// The last key that was pressed.
  String lastKey = '';

  /// The StudentInExamController that is used to mark the student as cheating.
  final studentInExamController = Get.find<StudentInExamController>();

  /// Enters full screen mode.
  // Future<void> enterFullScreen() async {
  //   try {
  //     await html.window.document.documentElement?.requestFullscreen();
  //   } on Exception catch (e) {
  //     debugPrint('Error entering full screen: $e');
  //   }
  // }

  /// Exits full screen mode.
  // void exitFullScreen() {
  //   try {
  //     html.document.exitFullscreen();
  //   } on Exception catch (e) {
  //     debugPrint('Error exiting full screen: $e');
  //   }
  // }

  /// Checks if the user has pressed a key that is not allowed.
  ///
  /// If the user has pressed a key that is not allowed, it will mark the
  /// student as cheating.
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

  /// Checks if the browser is currently in full screen mode.
  // bool isInFullScreen() {
  //   // var result = js.context.callMethod('isFullScreen');
  //   // return result ?? false;
  // }

  @override
  void onClose() {
    removeListeners();
   // exitFullScreen();
    super.onClose();
  }

  @override
  void onInit() {
    // enterFullScreen().then((value) async {
    //   html.window.addEventListener('fullscreenchange', (event) {
    //     if (Hive.box('ExamMission').get('inExam', defaultValue: false)) {
    //       isInFullScreen()
    //           ? null
    //           : studentInExamController.markStudentCheating();
    //     }
    //   });
    // });
    super.onInit();
  }

  /// Removes the event listeners that were added in the onInit method.
  void removeListeners() {
    //html.window.removeEventListener('fullscreenchange', (event) => true, true);
  }

  /// Updates the lastKey variable with the new key.
  void updateLastKey(String key) {
    lastKey = key;
    update();
  }
}
