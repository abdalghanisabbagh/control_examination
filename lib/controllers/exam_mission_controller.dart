import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/exam_mission/exam_mission_res_model.dart';

class ExamMissionController extends GetxController {
  String? _barcode;
  ExamMission? _cachedExamMission;

  String? get barcode => _barcode ?? getBarcodeFromHiveBox();

  ExamMission? get cachedExamMission =>
      _cachedExamMission ?? getExamMissionFromHiveBox();

  void deleteExamMissionFromHiveBox() {
    _cachedExamMission = null;
    Hive.box('ExamMission').clear();
  }

  String? getBarcodeFromHiveBox() {
    _barcode = Hive.box('ExamMission').containsKey("Barcode")
        ? Hive.box('ExamMission').get('Barcode')
        : null;
    return _barcode;
  }

  ExamMission? getExamMissionFromHiveBox() {
    var data = Hive.box('ExamMission').get('ExamMission');
    _cachedExamMission = Hive.box('ExamMission').containsKey("ExamMission")
        ? ExamMission.fromJson(jsonDecode(data))
        : null;
    return _cachedExamMission;
  }

  @override
  void onClose() {
    deleteExamMissionFromHiveBox();
    super.onClose();
  }

  void saveExamMissionToHiveBox({
    required ExamMission examMission,
    required String barcode,
  }) {
    _cachedExamMission = cachedExamMission;
    update();
    Hive.box('ExamMission')
        .put('ExamMission', jsonEncode(examMission.toJson()));
    Hive.box('ExamMission').put('Barcode', barcode);
  }
}
