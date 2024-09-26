// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:get/get.dart';

/// A GetX controller that is used to control the window size.
///
/// This class listens to the window resize event and updates the
/// [windowWidth] and [windowHeight] properties when the window is
/// resized.
///
/// The [windowWidth] and [windowHeight] properties are used to store the
/// current width and height of the window.
///
/// The [onInit] method is overridden and is used to set up the event
/// listener for the window resize event.
class WindowSizeController extends GetxController {
  /// The current width of the window.
  var windowWidth = html.window.innerWidth!.toDouble();

  /// The current height of the window.
  var windowHeight = html.window.innerHeight!.toDouble();

  @override
  void onInit() {
    super.onInit();
    // Listen to window resize events
    html.window.onResize.listen((event) {
      windowWidth = html.window.innerWidth!.toDouble();
      windowHeight = html.window.innerHeight!.toDouble();

      // Update the UI
      update();
    });
  }
}
