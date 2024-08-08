import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

import '../../configurations/app_links.dart';
import '../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../resource_manager/enums/req_type_enum.dart';
import '../../tools/response_handler.dart';
import '../controllers.dart';

class StudentInExamController extends FullLifeCycleController
    with FullLifeCycleMixin {
  final int examDuration =
      Get.find<ExamMissionController>().cachedExamMission!.duration!;
  final StudentQrCodeController studentQrCodeController =
      Get.find<StudentQrCodeController>();

  final ExamMissionController examMissionController =
      Get.find<ExamMissionController>();

  final userProfile = Get.find<ProfileController>().cachedUserProfile;

  Uint8List? documentBytes;

  PdfViewerController? pdfViewerController = PdfViewerController();

  int currentPage = 0, documentPage = 0;

  bool isLoadingExam = true;

  double _xScale = 1.0;

  double _yScale = 1.0;
  final ScrollController scrollController = ScrollController();
  final TransformationController transformationController =
      TransformationController();
  Future<void> getExamData() async {
    try {
      var link = await studentQrCodeController.examLinkResModel.future;
      var response = await Dio().get(link.examLink!,
          options: Options(responseType: ResponseType.bytes));
      documentBytes = response.data;
      update();
    } catch (e) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "$e",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }
    return;
  }

  void markStudentCheating() async {
    final ResponseHandler responseHandler = ResponseHandler<void>();

    responseHandler.getResponse(
      path: '${StudentsLinks.studentCheating}/${examMissionController.barcode}',
      type: ReqTypeEnum.GET,
      converter: (_) {},
    );
  }

  @override
  void onClose() {
    Get.delete<StudentQrCodeController>(force: true);
    Get.delete<StudentExamController>(force: true);

    super.onClose();
  }

  @override
  void onDetached() {
    markStudentCheating();
  }

  @override
  void onHidden() {
    markStudentCheating();
  }

  @override
  void onInactive() {
    markStudentCheating();
  }

  @override
  void onInit() async {
    await Future.wait([
      getExamData(),
    ]);
    super.onInit();
  }

  @override
  void onPaused() {
    markStudentCheating();
  }

  @override
  void onResumed() {}

  void zoomIn() {
    if (_xScale >= 2.0 || _yScale >= 2.0) {
      return;
    }

    transformationController.value = Matrix4.identity()
      ..scale(_xScale += 0.1, _yScale += 0.1);
  }

  void zoomOut() {
    if (_xScale <= 1.0 || _yScale <= 1.0) {
      return;
    }
    transformationController.value = Matrix4.identity()
      ..scale(_xScale -= 0.1, _yScale -= 0.1);
  }
}
