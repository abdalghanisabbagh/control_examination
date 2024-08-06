import 'package:control_examination/controllers/full_screen_controller.dart';
import 'package:control_examination/resource_manager/ReusableWidget/loading_indicators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

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
              appBar: AppBar(
                leading: BackButton(
                  color: ColorManager.white,
                  onPressed: () {
                    Hive.box('ExamMission').put('inExam', false);
                    Get.back();
                  },
                ),
                title: Text(
                  'Student Exam',
                  style: nunitoSemiBold.copyWith(
                    fontSize: 16,
                    color: ColorManager.white,
                  ),
                ),
                centerTitle: true,
                elevation: 0,
                backgroundColor: ColorManager.primary,
              ),
              body: GetBuilder<StudentInExamController>(
                builder: (_) {
                  return controller.documentBytes == null
                      ? Center(
                          child: LoadingIndicators.getLoadingIndicator(),
                        )
                      : Stack(
                          children: [
                            PdfDocumentLoader.openData(
                              controller.documentBytes!,
                              documentBuilder:
                                  (context, pdfDocument, pageCount) {
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
                                          transformationController: controller
                                              .transformationController,
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
                            ),
                            Container(
                              color: Colors.black54,
                              child: Row(
                                children: [
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
                                  const Spacer(),
                                  /*   Row(
                                  children: [
                                    Container(
                                      color: Colors.black,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 16),
                                      child: GetBuilder<ExamController>(
                                          key: UniqueKey(),
                                          tag: 'page_number',
                                          id: 'page_number',
                                          builder: (controller) {
                                            return Text(
                                              "${controller.currentPage + 1}/${controller.documentPage} page",
                                              style: const TextStyle(color: Colors.white),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                                */
                                  const SizedBox(
                                    width: 250,
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                },
              ),
            ),
          );
        });
  }
}
