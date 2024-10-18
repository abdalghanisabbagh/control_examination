import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../configurations/constants/assets.dart';
import '../../controllers/controllers.dart';
import '../../routes_manger.dart';

class StudentExamWaitingScreen extends GetView<StudentExamController> {
  final int _start = Get.find<HomeController>()
      .serveClock!
      .difference(DateTime.parse(Get.find<ExamMissionController>()
          .cachedExamMission!
          .startTime
          .toString()))
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
        child: Column(
          children: [
            const Spacer(),
            SlideCountdown(
              onChanged: (value) => value.inSeconds <= 5 * 60
                  ? Get.offNamed(Routes.studentExamScreenQRCode)
                  : null,
              duration: Duration(seconds: _start),
              separatorType: SeparatorType.title,
              style: nunitoBold.copyWith(
                color: ColorManager.white,
                fontSize: 100,
              ),
              decoration: const BoxDecoration(
                color: ColorManager.bgSideMenu,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            const Spacer(),
            const Text(
              "With any attempt to leave the screen of examination, your exam will be CANCELLED immediately, and you will earn a score of Zero Grade!",
              // "If you try to go out from Exam screen,your exam will be CANCELED,Please don't try take screen (shot/record)",
              style: TextStyle(color: Colors.red, fontSize: 24),
            ).paddingSymmetric(horizontal: 300),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
