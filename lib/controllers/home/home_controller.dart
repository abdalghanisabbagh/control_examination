import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../configurations/app_links.dart';
import '../../models/student_exams/student_exam_res_model.dart';
import '../../models/student_exams/student_exams_res_model.dart';
import '../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../resource_manager/enums/req_type_enum.dart';
import '../../tools/response_handler.dart';
import '../controllers.dart';

/// HomeController is a GetX controller that handles the home screen of the app.
/// It fetches the list of student exams and groups them by the exam mission name.
class HomeController extends GetxController {
  /// A flag that indicates whether the controller is currently loading data.
  bool loading = false;

  /// A scroll controller that is used to control the scroll of the list.
  ScrollController scrollController = ScrollController();

  /// A list of student exams.
  List<StudentExamResModel> studentExams = [];

  /// A map of exam mission names to the list of student exams that belong to that exam mission.
  Map<String?, List<StudentExamResModel>>? studentExamsResModel;

  /// A counter that is used to keep track of the number of polls that have been made.
  int timerCounter = 0;

  /// The cached user profile that is used to fetch the list of student exams.
  final userProfile = Get.find<ProfileController>().cachedUserProfile;

  /// Fetches the list of student exams.
  ///
  /// This method fetches the list of student exams and groups them by the exam mission name.
  ///
  /// The list of student exams is then stored in the [studentExams] list.
  /// The map of exam mission names to the list of student exams is stored in the [studentExamsResModel] map.
  Future<void> getStudentExams() async {
    /// Creates a new instance of [ResponseHandler] that is used to handle the response from the server.
    final responseHandler = ResponseHandler<StudentExamsResModel>();

    /// Makes a GET request to the server to fetch the list of student exams.
    ///
    /// The response is then handled by the [ResponseHandler] and the list of student exams is stored in the [studentExams] list.
    var response = await responseHandler.getResponse(
      /// The path of the request.
      path: StudentsLinks.studentExams,

      /// The converter that is used to convert the response from the server to a [StudentExamsResModel].
      converter: StudentExamsResModel.fromJson,

      /// The type of the request.
      type: ReqTypeEnum.GET,
    );

    /// If the response is an error, an error dialogue is shown to the user.
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (r) {
        /// Assigns the list of student exams to the [studentExams] list.
        studentExams.assignAll(r.exams!);

        /// Groups the list of student exams by the exam mission name and stores the result in the [studentExamsResModel] map.
        studentExamsResModel = r.exams!.groupListsBy(
          (element) => element.examMission?.controlMissionResModel?.name,
        );
      },
    );

    /// Updates the widgets that depend on the [studentExamsResModel] map.
    update(['exams']);
  }

  /// Initializes the controller and loads the student exams.
  ///
  /// This method is called when the controller is initialized.
  /// It calls the [getStudentExams] method to load the student exams
  /// and sets the [loading] flag to [true] until the data is loaded.
  /// It then updates the widgets that depend on the [studentExamsResModel] map.
  @override
  void onInit() async {
    super.onInit();
    loading = true;
    update();

    /// Loads the student exams.
    await Future.wait([
      // getServerClock(),
      getStudentExams(),
    ]);

    loading = false;
    update();
  }
}
