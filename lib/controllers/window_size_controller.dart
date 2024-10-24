// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// /// WindowSizeController هو GetxController الذي يوفر العرض والارتفاع الحاليين للنافذة
// /// يستمع لأحداث تغيير حجم النافذة ويقوم بتحديث القيم وفقًا لذلك
// class WindowSizeController extends GetxController {
//   /// العرض الحالي للنافذة
//   double windowWidth = 0.0;

//   /// الارتفاع الحالي للنافذة
//   double windowHeight = 0.0;

//   @override
//   void onInit() {
//     super.onInit();
//     // تعيين القيم الأولية
//     updateWindowSize();

//     // إضافة مستمع لتغيير حجم النافذة
//     WidgetsBinding.instance.platformDispatcher.onMetricsChanged =
//         updateWindowSize;
//   }

//   /// تحديث القيم للعرض والارتفاع الحاليين
//   void updateWindowSize() {
//     final size = MediaQueryData.fromView(
//             WidgetsBinding.instance.platformDispatcher.views.first)
//         .size;
//     windowWidth = size.width;
//     windowHeight = size.height;
//     update();
//   }
// }
