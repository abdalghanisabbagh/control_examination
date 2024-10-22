// ignore: avoid_web_libraries_in_flutter
//import 'dart:html' as html;

import 'package:get/get.dart';

/// WindowSizeController is a GetxController that provides the current width and height of the window
/// it listens to window resize events and updates the values accordingly
class WindowSizeController extends GetxController {
  /// The current width of the window
 // var windowWidth = html.window.innerWidth!.toDouble();

  /// The current height of the window
 // var windowHeight = html.window.innerHeight!.toDouble();

  /// Listens to window resize events and updates the values accordingly
  @override
  void onInit() {
    super.onInit();
    // Listen to window resize events
    // html.window.onResize.listen((event) {
    //   windowWidth = html.window.innerWidth!.toDouble();
    //   windowHeight = html.window.innerHeight!.toDouble();

    //   update();
    // });
  }
}
