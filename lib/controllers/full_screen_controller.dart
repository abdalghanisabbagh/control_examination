// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:control_examination/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FullScreenController extends GetxController {
  /// Focus node to request focus and disable shortcuts.
  final FocusNode focusNode = FocusNode()..requestFocus();

  /// The last key that was pressed.
  String lastKey = '';

  /// The `StudentInExamController` instance.
  final studentInExamController = Get.find<StudentInExamController>();

  /// Enters full screen mode.
  Future<void> enterFullScreen() async {
    try {
      await html.window.document.documentElement?.requestFullscreen();
    } catch (e) {
      // debugPrint('Error entering full screen: $e');
    }
  }

  /// Exits full screen mode.
  void exitFullScreen() {
    try {
      html.document.exitFullscreen();
    } catch (e) {
      // debugPrint('Error exiting full screen: $e');
    }
  }

  /// Handles key events.
  ///
  /// If the key event is one of the following, it will mark the student as cheating:
  /// - Alt + any key
  /// - Ctrl + any key
  /// - Meta (Windows key or Command key) + any key
  /// - Shift + any key
  /// - Print Screen
  /// - Print
  /// - Browser Back
  /// - Browser Stop
  /// - F12
  /// - F5
  /// - F6
  /// - F4
  /// - Tab
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

  /// Checks if the app is in full screen mode.
  bool isInFullScreen() {
    var result = js.context.callMethod('isFullScreen');
    return result ?? false;
  }

  /// Called when the controller is about to be closed.
  /// This method will remove all event listeners from the window and exit full screen mode.
  @override
  void onClose() {
    // Remove all event listeners from the window
    removeListeners();
    // Exit full screen mode
    exitFullScreen();
    // Call the onClose method of the superclass
    super.onClose();
  }

  /// Called when the controller is initialized.
  ///
  /// This method will enter full screen mode, and add an event listener to the
  /// window to listen for full screen mode changes.
  ///
  /// When the full screen mode is changed, this method will check if the app is
  /// in full screen mode. If it is not, it will mark the student as cheating.
  @override
  void onInit() async {
    /// Enter full screen mode
    await enterFullScreen();

    /// Add an event listener to the window to listen for full screen mode changes
    html.window.addEventListener('fullscreenchange', (event) {
      /// Check if the app is in full screen mode
      if (isInFullScreen()) {
        /// If it is, do nothing
        return;
      }

      /// If it is not, mark the student as cheating
      studentInExamController.markStudentCheating();
    });

    /// Call the onInit method of the superclass
    super.onInit();
  }

  /// Removes the full screen change listener.
  ///
  /// This method is called when the controller is closed to remove the
  /// full screen change listener. This is important to avoid memory leaks
  /// and to prevent the controller from listening to the full screen mode
  /// changes when it is not needed.
  @mustCallSuper
  void removeListeners() {
    /// Remove the full screen change listener
    html.window.removeEventListener('fullscreenchange', (event) => true, true);
  }

  /// Updates the last key that was pressed.
  ///
  /// This method is used to keep track of the last key that was pressed by the
  /// student. It is used to prevent the student from cheating by pressing
  /// multiple keys at once.
  ///
  /// [key] is the key that was pressed.
  void updateLastKey(String key) {
    /// Update the last key that was pressed
    lastKey = key;

    /// Update the UI
    update();
  }
}
