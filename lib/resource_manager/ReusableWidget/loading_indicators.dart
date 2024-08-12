import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

abstract class LoadingIndicators {
  static Widget getLoadingIndicator([Color? color]) => SizedBox(
        height: 50,
        width: 50,
        child: LoadingIndicator(
          colors: color != null ? [color] : [],
          indicatorType: Indicator.ballRotateChase,
        ),
      );
}
