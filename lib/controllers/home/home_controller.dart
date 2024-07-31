import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_examination/controllers/controllers.dart';
import 'package:control_examination/models/server_clock_model.dart';
import 'package:control_examination/models/student_exams/student_exams_res_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../configurations/app_links.dart';
import '../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../resource_manager/enums/req_type_enum.dart';
import '../../tools/response_handler.dart';

class HomeController extends GetxController {
  bool loading = false;

  final userProfile = Get.find<ProfileController>().cachedUserProfile;

  Timer? serverCLock;
  StudentExamsResModel? studentExamsResModel;
  int timerCounter = 0;
  String serverTime = '00:00';
  DateTime? serveclock;
  Future<void> getServerClock() async {
    ResponseHandler<ServerClockResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: AppLinks.baseUrl,
      converter: ServerClockResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((fauilr) {
      /// handel error
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }, (result) {
      debugPrint(result.data);
      startServerClock(result.data);
      update();
    });
  }

  Future<void> getStudentExams() async {
    final responseHandler = ResponseHandler<StudentExamsResModel>();

    var response = await responseHandler.getResponse(
      path: StudentsLinks.studentExams,
      converter: StudentExamsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((l) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: l.message,
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }, (r) {
      studentExamsResModel = r;
    });
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    loading = true;
    update();
    await Future.wait([
      getServerClock(),
      getStudentExams(),
    ]);

    loading = false;
    update();
  }

  void startServerClock(String? servertimeString) async {
    if (servertimeString != null) {
      DateTime servertimeDate = DateTime.parse(servertimeString).toUtc();
      timerCounter = servertimeDate.millisecondsSinceEpoch;
      serverCLock = Timer.periodic(const Duration(seconds: 1), (timer) {
        timerCounter += 1000;
        serveclock = DateTime.fromMillisecondsSinceEpoch(timerCounter).toUtc();
        serverTime = DateFormat('HH:mm:ss').format(serveclock!);
        print(serverTime);
        serverTime = DateFormat('HH:mm:ss')
            .format(serveclock!);  
        debugPrint(serverTime);
        update();
      });
    }
  }
   void stopServerClock() {
    if (serverCLock != null) {
      serverCLock!.cancel();
      serverCLock = null;
      debugPrint('Server clock stopped');
      update();
    }
  }
}
