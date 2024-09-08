// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:get/get.dart';

class WindowSizeController extends GetxController {
  var windowWidth = html.window.innerWidth!.toDouble();
  var windowHeight = html.window.innerHeight!.toDouble();

  @override
  void onInit() {
    super.onInit();
    // Listen to window resize events
    html.window.onResize.listen((event) {
      windowWidth = html.window.innerWidth!.toDouble();
      windowHeight = html.window.innerHeight!.toDouble();

      update();
    });
  }
}
