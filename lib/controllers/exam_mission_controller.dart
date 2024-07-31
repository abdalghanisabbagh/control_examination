import 'dart:convert';

import 'package:control_examination/models/exam_mission/exam_mission_res_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExamMissionController extends GetxController {
  ExamMission? _cachedExamMission;

  ExamMission? get cachedExamMission =>
      _cachedExamMission ?? getExamMissionFromHiveBox();

  void deleteExamMissionFromHiveBox() {
    _cachedExamMission = null;
    Hive.box('ExamMission').clear();
  }

  ExamMission? getExamMissionFromHiveBox() {
    var data = Hive.box('ExamMission').get('ExamMission');
    _cachedExamMission = Hive.box('ExamMission').containsKey("ExamMission")
        ? ExamMission.fromJson(jsonDecode(data))
        : null;
    return _cachedExamMission;
  }

  void saveExamMissionToHiveBox(ExamMission cachedExamMission) {
    update();
    Hive.box('ExamMission')
        .put('ExamMission', jsonEncode(cachedExamMission.toJson()));
  }
}
