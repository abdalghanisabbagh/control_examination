import 'package:control_examination/controllers/full_screen_controller.dart';
import 'package:control_examination/resource_manager/ReusableWidget/loading_indicators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../configurations/constants/assets.dart';
import '../../controllers/student_exam/student_in_exam_controller.dart';
import '../../resource_manager/color_manager.dart';
import '../../resource_manager/styles_manager.dart';

class StudentInExamScreen extends GetView<StudentInExamController> {
  const StudentInExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FullScreenController>(
      init: FullScreenController(),
      builder: (fullScreenController) {
        return KeyboardListener(
          focusNode: fullScreenController.focusNode,
          onKeyEvent: (KeyEvent event) {
            if (event is KeyDownEvent) {
              // fullScreenController.handleKeyEvent(event);
              // fullScreenController
              //     .updateLastKey(event.logicalKey.debugName ?? 'Unknown');
              // debugPrint('Key pressed: ${event.logicalKey.debugName}');
            }
          },
          child: Scaffold(
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
                        Hive.box('ExamMission').put('inExam', false);
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
                        ' / ${controller.examMissionController.cachedExamMission?.subjects?.name}',
                        style: nunitoBold.copyWith(
                          color: ColorManager.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.zoom_in,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        controller.zoomIn();
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.zoom_out,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        controller.zoomOut();
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GetBuilder<StudentInExamController>(
                      builder: (context) {
                        return controller.documentBytes == null
                            ? const SizedBox.shrink()
                            : SlideCountdown(
                                decoration: const BoxDecoration(),
                                duration:
                                    Duration(minutes: controller.examDuration),
                                style: nunitoRegular.copyWith(
                                  color: ColorManager.white,
                                  fontSize: 20,
                                ),
                              );
                      },
                    ),
                    Lottie.asset('animations/time_animation.json'),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
            body: GetBuilder<StudentInExamController>(
              builder: (_) {
                return controller.documentBytes == null
                    ? Center(
                        child: LoadingIndicators.getLoadingIndicator(),
                      )
                    : PdfDocumentLoader.openData(
                        controller.documentBytes!,
                        documentBuilder: (context, pdfDocument, pageCount) {
                          controller.documentPage = pageCount;
                          return Scrollbar(
                            controller: controller.scrollController,
                            thumbVisibility: true,
                            trackVisibility: true,
                            child: ListView.builder(
                              controller: controller.scrollController,
                              itemCount: pageCount,
                              itemBuilder: (context, index) {
                                controller.currentPage = index;
                                return Container(
                                  color: Colors.black12,
                                  child: InteractiveViewer(
                                    transformationController:
                                        controller.transformationController,
                                    panEnabled: false,
                                    scaleEnabled: false,
                                    child: PdfPageView(
                                      pdfDocument: pdfDocument,
                                      pageNumber: index + 1,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        );
      },
    );
  }
}
