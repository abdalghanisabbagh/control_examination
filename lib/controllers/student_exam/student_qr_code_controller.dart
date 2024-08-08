import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

import '../../configurations/app_links.dart';
import '../../models/student_exams/exam_link_res_model.dart';
import '../../models/uuid/uuid_res_model.dart';
import '../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../resource_manager/enums/req_type_enum.dart';
import '../../tools/response_handler.dart';
import '../controllers.dart';

class StudentQrCodeController extends GetxController {
  bool loading = false;
  final StudentExamController studentExamController = Get.find();
  final cachedUserProfile = Get.find<ProfileController>().cachedUserProfile;
  final cahechedExamMission =
      Get.find<ExamMissionController>().cachedExamMission;
  String qrCode = '';

  Completer<ExamLinkResModel> examLinkResModel = Completer<ExamLinkResModel>();

  Future<void> checkStudent() async {
    UuidResModel uuid = await studentExamController.uuidResModel.future;

    final responseHandler = ResponseHandler<UuidResModel>();

    var response = await responseHandler.getResponse(
      path: '${StudentsLinks.studentUuid}/${uuid.iD}',
      converter: UuidResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
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

    update();
    return;
  }

  @override
  void onClose() {
    Get.delete<StudentExamController>(force: true);
    super.onClose();
  }

  @override
  void onInit() async {
    UuidResModel uuid = await studentExamController.uuidResModel.future;
    qrCode =
        'Name: ${cachedUserProfile?.firstName} ${cachedUserProfile?.secondName} ${cachedUserProfile?.thirdName}\n${uuid.iD}';
    update();
    super.onInit();
  }

  Future<bool> validtaeStudentToStartExam() async {
    loading = true;
    bool isValid = false;
    update(['scan_done']);
    UuidResModel uuid = await studentExamController.uuidResModel.future;

    final responseHandler = ResponseHandler<ExamLinkResModel>();

    var response = await responseHandler.getResponse(
      path: '${StudentsLinks.validateStudent}/${uuid.iD}',
      converter: ExamLinkResModel.fromJson,
      params: {
        'examMissionId': cahechedExamMission?.iD,
      },
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
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

    loading = false;
    update(['scan_done']);
    return isValid;
  }
}
