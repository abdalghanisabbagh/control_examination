import 'package:control_examination/controllers/controllers.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../configurations/constants/assets.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../routes_manger.dart';

class StudentQrScreen extends GetView<StudentQrCodeController> {
  final ProfileController profileController = Get.find<ProfileController>();
  final int _start = DateTime.parse(Get.find<ExamMissionController>()
              .cachedExamMission!
              .startTime
              .toString())
          .toUtc()
          .isBefore(DateTime.now().toUtc())
      ? 0
      : DateTime.parse(Get.find<ExamMissionController>()
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
                  '${controller.cachedUserProfile?.firstName} ${controller.cachedUserProfile?.secondName} ${controller.cachedUserProfile?.thirdName}',
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
                      '${controller.cachedUserProfile?.schoolResModel?.schoolType?.name}',
                      style: nunitoBold.copyWith(
                        color: ColorManager.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      ' ${controller.cachedUserProfile?.schoolResModel?.name}',
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
                  '${controller.cachedUserProfile?.gradeResModel?.name}',
                  style: nunitoBold.copyWith(
                    color: ColorManager.white,
                    fontSize: 18,
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  ' / ${controller.cahechedExamMission?.subjects?.name}',
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
                  child: controller.qrCode.isEmpty
                      ? Center(
                          child: LoadingIndicators.getLoadingIndicator(),
                        )
                      : PrettyQrView.data(
                          data: controller.qrCode,
                        ),
                ),
                const Spacer(
                  flex: 2,
                ),
                Expanded(
                  flex: 3,
                  child: _start == 0
                      ? const SizedBox.shrink()
                      : SlideCountdown(
                          onChanged: (value) => value.inSeconds <= 2 * 60
                              ? null // TODO: validate
                              : value.inSeconds == 0
                                  ? Get.offNamed(Routes.studentExamScreen)
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
                Expanded(
                  flex: 3,
                  child: controller.qrCode.isEmpty
                      ? const SizedBox.shrink()
                      : GetBuilder<StudentQrCodeController>(
                          id: 'scan_done',
                          builder: (_) {
                            return controller.loading
                                ? Center(
                                    child:
                                        LoadingIndicators.getLoadingIndicator(),
                                  )
                                : ElevatedButton(
                                    onPressed: () async {
                                      final bool isValid = await controller
                                          .validtaeStudentToStartExam();
                                      if (isValid) {
                                        Hive.box('ExamMission')
                                            .put('inExam', true);
                                        Get.offNamed(Routes.studentExamScreen);
                                      }
                                    },
                                    child: Text(
                                      'Scan Done?',
                                      style: nunitoBold.copyWith(
                                        color: ColorManager.white,
                                      ),
                                    ),
                                  );
                          },
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
