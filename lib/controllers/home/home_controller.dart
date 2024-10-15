import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../configurations/app_links.dart';
import '../../models/student_exams/student_exam_res_model.dart';
import '../../models/student_exams/student_exams_res_model.dart';
import '../../resource_manager/ReusableWidget/show_dialogue.dart';
import '../../resource_manager/enums/req_type_enum.dart';
import '../../tools/response_handler.dart';
import '../controllers.dart';

/// this class is the controller for the home page
/// it contains the logic for getting the student exams and
/// displaying the server clock
class HomeController extends GetxController {
  /// flag to indicate if the data is loading
  bool loading = false;

  /// scroll controller for the exams list
  ScrollController scrollController = ScrollController();

  /// the server clock
  DateTime? serveClock;

  /// the timer for the server clock
  Timer? serverCLock;

  /// the string representation of the server clock
  String serverTime = '00:00';

  /// the list of student exams
  List<StudentExamResModel> studentExams = [];

  /// the map of student exams grouped by mission name
  Map<String?, List<StudentExamResModel>>? studentExamsResModel;

  /// the counter for the server clock
  int timerCounter = 0;

  /// the user profile
  final userProfile = Get.find<ProfileController>().cachedUserProfile;

  /// get the server clock from the server
  /// and start the timer
  // Future<void> getServerClock() async {
  //   ResponseHandler<ServerClockResModel> responseHandler = ResponseHandler();

  //   var response = await responseHandler.getResponse(
  //     path: AppLinks.baseUrlProd,
  //     converter: ServerClockResModel.fromJson,
  //     type: ReqTypeEnum.GET,
  //   );

  //   response.fold((failure) {
  //     /// handel error
  //     MyAwesomeDialogue(
  //       title: 'Error',
  //       desc: "${failure.code} ::${failure.message}",
  //       dialogType: DialogType.error,
  //     ).showDialogue(Get.key.currentContext!);
  //   }, (result) {
  //     debugPrint(result.data);
  //     startServerClock(result.data);
  //     update();
  //   });
  // }

  /// get the student exams from the server
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

  /// on init
  @override
  void onInit() async {
    super.onInit();
    loading = true;
    update();
    await Future.wait([
      // getServerClock(),
      getStudentExams(),
    ]);

    loading = false;
    update();
  }

  /// start the server clock
  void startServerClock(String? serverTimeString) async {
    if (serverTimeString != null) {
      DateTime serverTimeDate = DateTime.parse(serverTimeString);
      timerCounter = serverTimeDate.millisecondsSinceEpoch;
      serverCLock = Timer.periodic(const Duration(seconds: 1), (timer) {
        timerCounter += 1000;
        serveClock = DateTime.fromMillisecondsSinceEpoch(timerCounter);
        serverTime = DateFormat('HH:mm:ss').format(serveClock!);
        // print(serverTime);
        serverTime = DateFormat('HH:mm:ss').format(serveClock!);
//debugPrint(serverTime);
        update();
      });
    }
  }

  /// stop the server clock
  void stopServerClock() {
    if (serverCLock != null) {
      serverCLock!.cancel();
      serverCLock = null;
      debugPrint('Server clock stopped');
      update();
    }
  }
}
