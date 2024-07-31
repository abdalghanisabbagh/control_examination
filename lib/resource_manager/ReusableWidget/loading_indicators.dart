import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

abstract class LoadingIndicators {
  static Widget getLoadingIndicator() => SizedBox(
        height: 80,
        width: 80,
        child: Lottie.asset('animations/loading_aimation.json'),
      );
}
