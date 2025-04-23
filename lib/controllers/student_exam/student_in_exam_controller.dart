import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:control_examination/routes_manger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

import '../../resource_manager/ReusableWidget/show_dialogue.dart';
// import '../../configurations/app_links.dart';
// import '../../resource_manager/ReusableWidget/show_dialogue.dart';
// import '../../resource_manager/enums/req_type_enum.dart';
// import '../../tools/response_handler.dart';
import '../../routes_manger.dart';
import '../controllers.dart';

/// student in exam controller
/// this controller is responsible for the student in the exam
/// it contains the exam data and the exam duration
/// it also contains the transformation controller for the zooming
/// and the scroll controller for the scrolling
class StudentInExamController extends FullLifeCycleController
    with FullLifeCycleMixin {
  /// the current page number
  int currentPage = 0, documentPage = 0;

  /// the bytes of the document
  Uint8List? documentBytes;

  /// the duration of the exam
  final int examDuration =
      Get.find<ExamMissionController>().cachedExamMission!.duration!;

  /// the exam mission controller
  final ExamMissionController examMissionController =
      Get.find<ExamMissionController>();

  /// is the exam loading
  bool isLoadingExam = true;

  /// the pdf viewer controller
  PdfViewerController? pdfViewerController = PdfViewerController();

  /// the scroll controller
  final ScrollController scrollController = ScrollController();

  /// the student qr code controller
  final StudentQrCodeController studentQrCodeController =
      Get.find<StudentQrCodeController>();

  /// the transformation controller
  final TransformationController transformationController =
      TransformationController();

  /// the user profile
  final userProfile = Get.find<ProfileController>().cachedUserProfile;

  /// the x scale
  double _xScale = 1.0;

  /// the y scale
  double _yScale = 1.0;

  /// get the exam data
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

  /// mark the student as cheating
  void markStudentCheating() async {
    // final ResponseHandler responseHandler = ResponseHandler<void>();

    // await responseHandler.getResponse(
    //   path: '${StudentsLinks.studentCheating}/${examMissionController.barcode}',
    //   type: ReqTypeEnum.GET,
    //   converter: (_) {},
    // );
    // Get.find<HomeController>().onInit();

    Get.offAllNamed(Routes.homeScreen);
  }

  @override
  void onClose() {
    Get.delete<StudentQrCodeController>(force: true);
    Get.delete<StudentExamController>(force: true);
    markStudentCheating();

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

  /// zoom in
  void zoomIn() {
    if (_xScale >= 2.0 || _yScale >= 2.0) {
      return;
    }

    transformationController.value = Matrix4.identity()
      ..scale(_xScale += 0.1, _yScale += 0.1);
  }

  /// zoom out
  void zoomOut() {
    if (_xScale <= 1.0 || _yScale <= 1.0) {
      return;
    }
    transformationController.value = Matrix4.identity()
      ..scale(_xScale -= 0.1, _yScale -= 0.1);
  }
}
