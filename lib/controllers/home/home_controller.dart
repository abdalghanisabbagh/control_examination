import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../configurations/app_links.dart';
import '../../models/server_clock_model.dart';
import '../../models/student_exams/student_exam_res_model.dart';
import '../../models/student_exams/student_exams_res_model.dart';
import '../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../resource_manager/enums/req_type_enum.dart';
import '../../tools/response_handler.dart';
import '../controllers.dart';

class HomeController extends GetxController {
  bool loading = false;
  ScrollController scrollController = ScrollController();
  DateTime? serveclock;
  Timer? serverCLock;
  String serverTime = '00:00';
  List<StudentExamResModel> studentExams = [];
  Map<String?, List<StudentExamResModel>>? studentExamsResModel;
  int timerCounter = 0;
  final userProfile = Get.find<ProfileController>().cachedUserProfile;

  Future<void> getServerClock() async {
    ResponseHandler<ServerClockResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: AppLinks.baseUrlProd,
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
      studentExams.assignAll(r.exams!);
      studentExamsResModel = r.exams!.groupListsBy(
        (element) => element.examMission?.controlMissionResModel?.name,
      );
    });
    update(['exams']);
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
      DateTime servertimeDate = DateTime.parse(servertimeString);
      timerCounter = servertimeDate.millisecondsSinceEpoch;
      serverCLock = Timer.periodic(const Duration(seconds: 1), (timer) {
        timerCounter += 1000;
        serveclock = DateTime.fromMillisecondsSinceEpoch(timerCounter);
        serverTime = DateFormat('HH:mm:ss').format(serveclock!);
        // print(serverTime);
        serverTime = DateFormat('HH:mm:ss').format(serveclock!);
//debugPrint(serverTime);
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
