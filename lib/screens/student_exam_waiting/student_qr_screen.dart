import 'package:control_examination/configurations/constants/assets.dart';
import 'package:control_examination/controllers/controllers.dart';
import 'package:control_examination/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:slide_countdown/slide_countdown.dart';

class StudentQrScreen extends GetView<StudentQrCodeController> {
  final int _start = DateTime.parse(Get.find<ExamMissionController>()
          .cachedExamMission!
          .startTime
          .toString())
      .toUtc()
      .difference(DateTime.now().toUtc())
      .inSeconds
      .abs(); // Countdown starting value

  StudentQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Exam Waiting',
          style: nunitoSemiBold.copyWith(
            fontSize: 16,
            color: ColorManager.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorManager.primary,
      ),
      body: GetBuilder<StudentQrCodeController>(
        builder: (_) {
          return Center(
            child: Column(
              children: [
                const Spacer(
                  flex: 2,
                ),
                Expanded(
                  flex: 5,
                  child: PrettyQrView.data(
                    data: controller.qrCode,
                    decoration: const PrettyQrDecoration(
                      image: PrettyQrDecorationImage(
                        image: AssetImage(
                          Assets.assetsLogosNisLogo,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                Expanded(
                  flex: 3,
                  child: SlideCountdown(
                    onChanged: (value) => value.inSeconds <= 2 * 60
                        ? null // TODO: validate time and go to next screen
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
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
