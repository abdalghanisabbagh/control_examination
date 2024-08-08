import 'package:control_examination/controllers/controllers.dart';
import 'package:control_examination/routes_manger.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../configurations/constants/assets.dart';

class StudentExamWaitingScreen extends GetView<StudentExamController> {
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
    Get.find<StudentExamController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: ColorManager.primary,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                width: 20,
              ),
              BackButton(
                color: ColorManager.white,
                onPressed: () {
                  Get.delete<StudentQrCodeController>(force: true);
                  Get.back();
                },
              ),
              const SizedBox(
                width: 20,
              ),
              Image.asset(
                Assets.assetsLogosNIS5,
                height: 100,
              ),
              const Spacer(
                flex: 2,
              ),
              FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  '${controller.userProfile?.firstName} ${controller.userProfile?.secondName} ${controller.userProfile?.thirdName}',
                  style: nunitoBold.copyWith(
                    color: ColorManager.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              Row(
                children: [
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      '${controller.userProfile?.schoolResModel?.schoolType?.name}',
                      style: nunitoBold.copyWith(
                        color: ColorManager.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      ' ${controller.userProfile?.schoolResModel?.name}',
                      style: nunitoBold.copyWith(
                        color: ColorManager.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  '${controller.userProfile?.gradeResModel?.name}',
                  style: nunitoBold.copyWith(
                    color: ColorManager.white,
                    fontSize: 18,
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  ' / ${controller.cachedExamMission?.subjects?.name}',
                  style: nunitoBold.copyWith(
                    color: ColorManager.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
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
