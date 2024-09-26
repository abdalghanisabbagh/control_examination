import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

import '../../configurations/app_links.dart';
import '../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../resource_manager/enums/req_type_enum.dart';
import '../../routes_manger.dart';
import '../../tools/response_handler.dart';
import '../controllers.dart';
import 'student_waiting_to_start_exam.dart';

class StudentInExamController extends FullLifeCycleController
    with FullLifeCycleMixin {
  /// The current page number of the PDF document
  int currentPage = 0;

  /// The page number of the document that is currently being viewed
  int documentPage = 0;

  /// The bytes of the PDF document
  Uint8List? documentBytes;

  /// The duration of the exam in minutes
  final int examDuration =
      Get.find<ExamMissionController>().cachedExamMission!.duration!;

  /// The exam mission controller
  final ExamMissionController examMissionController =
      Get.find<ExamMissionController>();

  /// The loading state of the exam
  bool isLoadingExam = true;

  /// The PDF viewer controller
  PdfViewerController? pdfViewerController = PdfViewerController();

  /// The scroll controller for the PDF viewer
  final ScrollController scrollController = ScrollController();

  /// The controller for the student waiting to start exam screen
  final StudentWaitingToStartExamController
      studentWaitingToStartExamController =
      Get.find<StudentWaitingToStartExamController>();

  /// The transformation controller for the PDF viewer
  final TransformationController transformationController =
      TransformationController();

  /// The user profile
  final userProfile = Get.find<ProfileController>().cachedUserProfile;

  /// The x and y scale of the PDF viewer
  double _xScale = 1.0;
  double _yScale = 1.0;

  /// Fetches the PDF document from the server
  ///
  /// This method makes a GET request to the server to fetch the PDF document for the exam.
  ///
  /// The PDF document is stored in the [documentBytes] variable.
  ///
  /// If the request fails, an error dialogue is shown to the user.
  ///
  /// This method is called when the [StudentInExamController] is initialized.
  Future<void> getExamData() async {
    try {
      // Get the link for the PDF document from the server
      var link =
          await studentWaitingToStartExamController.examLinkResModel.future;

      // Make a GET request to the server to fetch the PDF document
      var response = await Dio().get(link.examLink!,
          options: Options(responseType: ResponseType.bytes));

      // Store the PDF document in the documentBytes variable
      documentBytes = response.data;

      // Update the UI to show the PDF document
      update();
    } catch (e) {
      // Show an error dialogue if the request fails
      MyAwesomeDialogue(
        title: 'Error',
        desc: "$e",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }
    return;
  }

  /// Marks the student as cheating
  ///
  /// This method makes a GET request to the server to mark the student as cheating.
  ///
  /// The request is made to the [StudentsLinks.studentCheating] path with the
  /// student's barcode as a parameter.
  ///
  /// If the request is successful, the user is navigated to the [Routes.homeScreen]
  /// route.
  ///
  /// This method is called when the user leaves the screen while an exam is in
  /// progress.
  void markStudentCheating() async {
    final ResponseHandler responseHandler = ResponseHandler<void>();

    await responseHandler.getResponse(
      /// The path of the request.
      path: '${StudentsLinks.studentCheating}/${examMissionController.barcode}',

      /// The type of the request.
      type: ReqTypeEnum.GET,

      /// The converter that is used to convert the response from the server to
      /// a void type.
      converter: (_) {},
    );

    /// Navigates the user to the [Routes.homeScreen] route.
    Get.find<HomeController>().onInit();
    Get.offAllNamed(Routes.homeScreen);
  }

  /// Closes the [StudentInExamController] and removes it from the GetX framework.
  ///
  /// This method is called when the user leaves the screen while an exam is in
  /// progress.
  ///
  /// This method deletes the [StudentWaitingToStartExamController] and the
  /// [StudentExamController] from the GetX framework using the [Get.delete] method.
  ///
  /// This method also calls the [super.onClose] method to close the controller.
  @override
  void onClose() {
    // Delete the StudentWaitingToStartExamController and the StudentExamController
    // from the GetX framework.
    Get.delete<StudentWaitingToStartExamController>(force: true);
    Get.delete<StudentExamController>(force: true);

    // Close the controller.
    super.onClose();
  }

  /// Called when the GetX framework detaches the [StudentInExamController]
  /// from the widget tree.
  ///
  /// This method is called when the user leaves the screen while an exam is in
  /// progress.
  ///
  /// This method calls the [markStudentCheating] method to mark the student as
  /// cheating if the student leaves the screen while an exam is in progress.
  @override
  void onDetached() {
    markStudentCheating();
  }

  /// Called when the GetX framework hides the [StudentInExamController]
  /// from the widget tree.
  ///
  /// This method is called when the user leaves the screen while an exam is in
  /// progress.
  ///
  /// This method calls the [markStudentCheating] method to mark the student as
  /// cheating if the student leaves the screen while an exam is in progress.
  @override
  void onHidden() {
    markStudentCheating();
  }

  /// Called when the GetX framework removes the [StudentInExamController]
  /// from the widget tree.
  ///
  /// This method is called when the user leaves the screen while an exam is in
  /// progress.
  ///
  /// This method calls the [markStudentCheating] method to mark the student as
  /// cheating if the student leaves the screen while an exam is in progress.
  @override
  void onInactive() {
    /// Marks the student as cheating if the student leaves the screen while an
    /// exam is in progress.
    markStudentCheating();
  }

  /// Initializes the [StudentInExamController].
  ///
  /// This method is called when the [StudentInExamController] is initialized.
  ///
  /// This method waits for the [getExamData] method to complete and then calls
  /// the [onInit] method of the superclass.
  @override
  void onInit() async {
    // Wait for the getExamData method to complete
    await Future.wait([
      getExamData(),
    ]);

    // Call the onInit method of the superclass
    super.onInit();
  }

  /// Called when the GetX framework puts the [StudentInExamController] in the
  /// paused state.
  ///
  /// This method is called when the user leaves the screen while an exam is in
  /// progress.
  ///
  /// This method calls the [markStudentCheating] method to mark the student as
  /// cheating if the student leaves the screen while an exam is in progress.
  @override
  void onPaused() {
    /// Marks the student as cheating if the student leaves the screen while an
    /// exam is in progress.
    markStudentCheating();
  }

  @override
  void onResumed() {}

  /// Zooms in the PDF viewer.
  ///
  /// This method is called when the user clicks the zoom in button.
  ///
  /// This method checks if the zoom level is already at the maximum value.
  /// If it is, it does nothing.
  /// If it is not, it scales the PDF viewer by 0.1.
  void zoomIn() {
    if (_xScale >= 2.0 || _yScale >= 2.0) {
      return;
    }

    transformationController.value = Matrix4.identity()
      ..scale(_xScale += 0.1, _yScale += 0.1);
  }

  /// Zooms out the PDF viewer.
  ///
  /// This method is called when the user clicks the zoom out button.
  ///
  /// This method checks if the zoom level is already at the minimum value.
  /// If it is, it does nothing.
  /// If it is not, it scales the PDF viewer by -0.1.
  void zoomOut() {
    if (_xScale <= 1.0 || _yScale <= 1.0) {
      return;
    }
    transformationController.value = Matrix4.identity()
      ..scale(_xScale -= 0.1, _yScale -= 0.1);
  }
}
