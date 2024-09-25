import 'dart:async';

import 'package:get/get.dart';

import '../../models/student_exams/exam_link_res_model.dart';
import '../../models/uuid/uuid_res_model.dart';
import '../controllers.dart';

class StudentWaitingToStartExamController extends GetxController {
  final cachedExamMission = Get.find<ExamMissionController>().cachedExamMission;
  final cachedUserProfile = Get.find<ProfileController>().cachedUserProfile;
  Completer<ExamLinkResModel> examLinkResModel = Completer<ExamLinkResModel>();
  bool loading = false;
  String qrCode = '';
  final StudentExamController studentExamController = Get.find();

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
}
