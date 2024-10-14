import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/exam_mission/exam_mission_res_model.dart';

/// this controller is responsible for the exam mission
/// it contains the exam data and the exam barcode
class ExamMissionController extends GetxController {
  /// the barcode of the exam mission
  String? _barcode;

  /// the cached exam mission
  ExamMission? _cachedExamMission;

  /// get the barcode of the exam mission
  /// if it is not cached, it will be retrieved from the hive box
  String? get barcode => _barcode ?? getBarcodeFromHiveBox();

  /// get the exam mission
  /// if it is not cached, it will be retrieved from the hive box
  ExamMission? get cachedExamMission =>
      _cachedExamMission ?? getExamMissionFromHiveBox();

  /// delete the exam mission from the hive box
  void deleteExamMissionFromHiveBox() {
    _cachedExamMission = null;
    Hive.box('ExamMission').clear();
  }

  /// get the barcode from the hive box
  String? getBarcodeFromHiveBox() {
    _barcode = Hive.box('ExamMission').containsKey("Barcode")
        ? Hive.box('ExamMission').get('Barcode')
        : null;
    return _barcode;
  }

  /// get the exam mission from the hive box
  ExamMission? getExamMissionFromHiveBox() {
    var data = Hive.box('ExamMission').get('ExamMission');
    _cachedExamMission = Hive.box('ExamMission').containsKey("ExamMission")
        ? ExamMission.fromJson(jsonDecode(data))
        : null;
    return _cachedExamMission;
  }

  /// on close, delete the exam mission from the hive box
  @override
  void onClose() {
    deleteExamMissionFromHiveBox();
    super.onClose();
  }

  /// save the exam mission to the hive box
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
