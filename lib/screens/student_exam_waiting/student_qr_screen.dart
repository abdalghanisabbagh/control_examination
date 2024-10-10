import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../configurations/constants/assets.dart';
import '../../controllers/controllers.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../routes_manger.dart';

class StudentQrScreen extends GetView<StudentQrCodeController> {
  final ProfileController profileController = Get.find<ProfileController>();

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
                  Get.find<ExamMissionController>()
                      .deleteExamMissionFromHiveBox();
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
                  flex: 1,
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
                  flex: 1,
                ),
                const Text(
                  "With any attempt to leave the screen of examination, your exam will be CANCELLED immediately, and you will earn a score of Zero Grade!",
                  // "If you try to go out from Exam screen,your exam will be CANCELED,Please don't try take screen (shot/record)",
                  style: TextStyle(color: Colors.red, fontSize: 24),
                ).paddingSymmetric(horizontal: 300),
                const Spacer(
                  flex: 1,
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
