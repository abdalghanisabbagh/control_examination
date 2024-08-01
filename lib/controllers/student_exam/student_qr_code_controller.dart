import 'package:control_examination/controllers/controllers.dart';
import 'package:get/get.dart';

class StudentQrCodeController extends GetxController {
  final cachedUserProfile = Get.find<ProfileController>().cachedUserProfile;
  final cahechedExamMission =
      Get.find<ExamMissionController>().cachedExamMission;
  late String qrCode = 'test';

  @override
  void onInit() {
    qrCode =
        '${cachedUserProfile?.firstName} ${cachedUserProfile?.secondName} ${cachedUserProfile?.thirdName}';
    super.onInit();
  }
}
