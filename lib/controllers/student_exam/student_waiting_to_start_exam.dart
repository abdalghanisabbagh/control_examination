import 'dart:async';

import 'package:get/get.dart';

import '../../models/student_exams/exam_link_res_model.dart';
import '../../models/uuid/uuid_res_model.dart';
import '../controllers.dart';

/// StudentWaitingToStartExamController is a GetX controller that is used to
/// control the view of the student waiting to start the exam.
///
/// This controller is used to generate a QR code that the student needs to
/// scan to start the exam. The QR code is generated based on the user's name
/// and their UUID.
///
/// The controller also listens for the UUID to be generated and updates the
/// QR code when the UUID is generated.
class StudentWaitingToStartExamController extends GetxController {
  /// The cached exam mission of the student.
  final cachedExamMission = Get.find<ExamMissionController>().cachedExamMission;

  /// The cached user profile of the student.
  final cachedUserProfile = Get.find<ProfileController>().cachedUserProfile;

  /// A completer that completes when the exam link is generated.
  Completer<ExamLinkResModel> examLinkResModel = Completer<ExamLinkResModel>();

  /// A boolean indicating whether the QR code is being loaded.
  bool loading = false;

  /// The QR code that the student needs to scan to start the exam.
  String qrCode = '';

  /// The student exam controller that is used to generate the UUID.
  final StudentExamController studentExamController = Get.find();

  /// Called when the view is closed.
  ///
  /// This method deletes the [StudentExamController] when the view is closed.
  @override
  void onClose() {
    Get.delete<StudentExamController>(force: true);
    super.onClose();
  }

  @override

  /// Called when the view is initialized.
  ///
  /// This method is called when the view is initialized and is used to generate
  /// the UUID and update the QR code when the UUID is generated.
  @override
  void onInit() async {
    /// Generate the UUID and update the QR code when the UUID is generated.
    UuidResModel uuid = await studentExamController.uuidResModel.future;

    /// The QR code that the student needs to scan to start the exam.
    /// The QR code is generated based on the user's name and their UUID.
    qrCode =
        'Name: ${cachedUserProfile?.firstName} ${cachedUserProfile?.secondName} ${cachedUserProfile?.thirdName}\n${uuid.iD}';
    update();
    super.onInit();
  }
}
