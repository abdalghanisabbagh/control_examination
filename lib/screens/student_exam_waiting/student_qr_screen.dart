import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../configurations/constants/assets.dart';
import '../../controllers/controllers.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../resource_manager/ReusableWidget/show_dialogue.dart';
import '../../routes_manger.dart';
import 'dart:html' as html;

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
      body: GetBuilder<StudentQrCodeController>(
        builder: (_) {
          return Center(
            child: Column(
              children: [
                const Spacer(
                  flex: 1,
                ),
                // Expanded(
                //   flex: 5,
                //   child: controller.qrCode.isEmpty
                //       ? Center(
                //           child: LoadingIndicators.getLoadingIndicator(),
                //         )
                //       : PrettyQrView.data(
                //           data: controller.qrCode,
                //         ),
                // ),
                const Spacer(
                  flex: 1,
                ),
                const Text(
                  "Please ask your proctor to open your exam. ",
                  // "If you try to go out from Exam screen,your exam will be CANCELED,Please don't try take screen (shot/record)",
                  style: TextStyle(color: ColorManager.primary, fontSize: 24),
                ).paddingSymmetric(horizontal: 300),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 1,
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
                                      List<html.Element> allElements =
                                          html.document.querySelectorAll('*');
                                      for (var element in allElements) {
                                        bool isAiExist = setupCheatingDetection(
                                            element: element.outerHtml);
                                        if (isAiExist) {
                                          MyAwesomeDialogue(
                                            title: 'Error',
                                            desc:
                                                "Kindly Uninstall or disable AI tools and try again",
                                            dialogType: DialogType.error,
                                          ).showDialogue(
                                              Get.key.currentContext!);

                                          return;
                                        }
                                      }
                                      final bool isValid = await controller
                                          .validateStudentToStartExam();
                                      if (isValid) {
                                        Hive.box('ExamMission')
                                            .put('inExam', true);
                                        Get.offNamed(Routes.studentExamScreen);
                                      }
                                    },
                                    child: Text(
                                      'Start Exam',
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

  bool setupCheatingDetection({required String? element}) {
    if (element?.contains('gpt') == true) {
      return true;
    } else if (element?.contains('monica') == true) {
      return true;
    } else if (element?.contains('gemini') == true) {
      return true;
    } else if (element?.contains('deepseek') == true) {
      return true;
    } else {
      false;
    }
    return false;
    // html.window.addEventListener('visibilitychange', (event) {
    //   var isInActive = js.context.callMethod('isInActive');
    //   print('isInActive ${isInActive}');
    //   if (isInActive) {
    //     studentInExamController.markStudentCheating();
    //   }
    // });
    //
    // html.window.addEventListener('blur', (event) {
    //   studentInExamController.markStudentCheating();
    // });
    //
    // html.window.addEventListener('resize', (event) {
    //   if (html.window.innerHeight! < 300 || html.window.innerWidth! < 300) {
    //     studentInExamController.markStudentCheating();
    //   }
    // });
  }
}
