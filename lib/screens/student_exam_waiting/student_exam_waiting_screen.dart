import 'package:control_examination/controllers/controllers.dart';
import 'package:control_examination/resource_manager/index.dart';
import 'package:control_examination/routes_manger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_countdown/slide_countdown.dart';

class StudentExamWaitingScreen extends StatelessWidget {
  final int _start = DateTime.parse(Get.find<ExamMissionController>()
          .cachedExamMission!
          .startTime
          .toString())
      .toUtc()
      .difference(DateTime.now().toUtc())
      .inSeconds
      .abs(); // Countdown starting value

  StudentExamWaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Waiting For QR Code',
          style: nunitoSemiBold.copyWith(
            fontSize: 16,
            color: ColorManager.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorManager.primary,
      ),
      body: Center(
        child: SlideCountdown(
          onChanged: (value) => value.inSeconds <= 5 * 60
              ? Get.offNamed(Routes.studentExamScreenQRCode)
              : null,
          duration: Duration(seconds: _start),
          style: nunitoBold.copyWith(
            color: ColorManager.white,
            fontSize: 100,
          ),
          decoration: BoxDecoration(
            color: ColorManager.bgSideMenu,
          ),
        ),
      ),
    );
  }
}
