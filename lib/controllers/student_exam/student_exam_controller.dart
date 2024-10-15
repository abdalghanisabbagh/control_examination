import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../configurations/app_links.dart';
import '../../models/uuid/uuid_res_model.dart';
import '../../resource_manager/ReusableWidget/show_dialogue.dart';
import '../../resource_manager/enums/req_type_enum.dart';
import '../../tools/response_handler.dart';
import '../controllers.dart';

/// this controller is responsible for creating a uuid for the student
/// and saving it to the server
class StudentExamController extends GetxController {
  /// this is the exam mission that the student is currently taking
  final cachedExamMission = Get.find<ExamMissionController>().cachedExamMission;

  /// this is the user profile of the student
  final userProfile = Get.find<ProfileController>().cachedUserProfile;

  /// this is the uuid that will be created
  final uuid = const Uuid();

  /// this is the completer that will be completed with the uuid
  Completer<UuidResModel> uuidResModel = Completer<UuidResModel>();

  /// this function will be called when the controller is initialized
  /// it will create a uuid and save it to the server
  Future<void> createUuid() async {
    final responseHandler = ResponseHandler<UuidResModel>();

    var response = await responseHandler.getResponse(
      path: StudentsLinks.studentUuid,
      converter: UuidResModel.fromJson,
      body: {
        "UUID": uuid.v1(),
        "ExamMissionId": cachedExamMission?.iD,
      },
      type: ReqTypeEnum.POST,
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
        uuidResModel.complete(r);
      },
    );
    update();
    return;
  }

  /// this is the function that will be called when the controller is initialized
  @override
  void onInit() async {
    super.onInit();
    await Future.wait(
      [
        createUuid(),
      ],
    );
  }
}
