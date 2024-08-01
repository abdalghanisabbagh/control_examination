import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_examination/configurations/app_links.dart';
import 'package:control_examination/controllers/controllers.dart';
import 'package:control_examination/models/uuid/uuid_res_model.dart';
import 'package:control_examination/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../resource_manager/enums/req_type_enum.dart';
import '../../tools/response_handler.dart';

class StudentExamController extends GetxController {
  final cachedExamMission = Get.find<ExamMissionController>().cachedExamMission;
  final uuid = const Uuid();
  UuidResModel? uuidResModel;

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
        uuidResModel = r;
      },
    );
    update();
    return;
  }

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
