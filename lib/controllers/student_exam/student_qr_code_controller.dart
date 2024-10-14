import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

import '../../configurations/app_links.dart';
import '../../models/student_exams/exam_link_res_model.dart';
import '../../models/uuid/uuid_res_model.dart';
import '../../resource_manager/ReusableWidget/show_dialogue.dart';
import '../../resource_manager/enums/req_type_enum.dart';
import '../../tools/response_handler.dart';
import '../controllers.dart';

/// this controller is responsible for the student in the exam
/// it contains the exam data and the exam duration
/// it also contains the transformation controller for the zooming
/// and the scroll controller for the scrolling
class StudentQrCodeController extends GetxController {
  /// this is the completer for the exam link
  final Completer<ExamLinkResModel> examLinkResModel =
      Completer<ExamLinkResModel>();

  /// this is the user profile
  final cachedUserProfile = Get.find<ProfileController>().cachedUserProfile;

  /// this is the exam mission
  final cachedExamMission = Get.find<ExamMissionController>().cachedExamMission;

  /// this is the loading status
  bool loading = false;

  /// this is the qr code
  String qrCode = '';

  /// this is the student exam controller
  final StudentExamController studentExamController = Get.find();

  /// this function is called when the student scans the qr code
  Future<void> checkStudent() async {
    /// get the uuid from the student exam controller
    UuidResModel uuid = await studentExamController.uuidResModel.future;

    /// get the exam link from the server
    final responseHandler = ResponseHandler<UuidResModel>();

    var response = await responseHandler.getResponse(
      path: '${StudentsLinks.studentUuid}/${uuid.iD}',
      converter: UuidResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    /// if there is an error show a dialog
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (r) {},
    );

    /// update the ui
    update();
    return;
  }

  @override
  void onClose() {
    /// delete the student exam controller
    Get.delete<StudentExamController>(force: true);
    super.onClose();
  }

  @override
  void onInit() async {
    /// get the uuid from the student exam controller
    UuidResModel uuid = await studentExamController.uuidResModel.future;

    /// create the qr code
    qrCode =
        'Name: ${cachedUserProfile?.firstName} ${cachedUserProfile?.secondName} ${cachedUserProfile?.thirdName}\n${uuid.iD}';
    update();
    super.onInit();
  }

  /// this function is called when the student presses the start exam button
  Future<bool> validateStudentToStartExam() async {
    /// set the loading status to true
    loading = true;
    bool isValid = false;
    update(['scan_done']);
    UuidResModel uuid = await studentExamController.uuidResModel.future;

    /// get the exam link from the server
    final responseHandler = ResponseHandler<ExamLinkResModel>();

    var response = await responseHandler.getResponse(
      path: '${StudentsLinks.validateStudent}/${uuid.iD}',
      converter: ExamLinkResModel.fromJson,
      params: {
        'examMissionId': cachedExamMission?.iD,
      },
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        /// if there is an error show a dialog
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (r) {
        isValid = true;
        examLinkResModel.complete(r);
      },
    );

    /// set the loading status to false
    loading = false;
    update(['scan_done']);
    return isValid;
  }
}
