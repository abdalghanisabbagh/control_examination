import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/exam_mission/exam_mission_res_model.dart';

/// ExamMissionController is a GetX controller that is used to control the view of the exam mission.
///
/// This controller is used to fetch the exam mission from the server and store it in the Hive box.
///
/// The controller also listens for the exam mission to be generated and updates the UI when the exam mission is generated.
class ExamMissionController extends GetxController {
  /// The barcode of the exam mission
  String? _barcode;

  /// The cached exam mission
  ExamMission? _cachedExamMission;

  /// The barcode of the exam mission
  ///
  /// This method will fetch the barcode from the Hive box if it exists, otherwise it will return null.
  String? get barcode => _barcode ?? getBarcodeFromHiveBox();

  /// The cached exam mission
  ///
  /// This method will fetch the exam mission from the Hive box if it exists, otherwise it will return null.
  ExamMission? get cachedExamMission =>
      _cachedExamMission ?? getExamMissionFromHiveBox();

  /// Deletes the exam mission from the Hive box
  ///
  /// This method will delete the exam mission from the Hive box and set the
  /// [_cachedExamMission] to null.
  void deleteExamMissionFromHiveBox() {
    /// Set the [_cachedExamMission] to null
    _cachedExamMission = null;

    /// Clear the Hive box
    Hive.box('ExamMission').clear();
  }

  /// Fetches the barcode from the Hive box
  ///
  /// This method will fetch the barcode from the Hive box if it exists, otherwise it will return null.
  ///
  /// The barcode is stored in the Hive box with the key "Barcode".
  ///
  /// If the barcode exists in the Hive box, it will be returned as a string.
  /// Otherwise, null will be returned.
  String? getBarcodeFromHiveBox() {
    /// Check if the barcode exists in the Hive box
    if (Hive.box('ExamMission').containsKey("Barcode")) {
      /// Fetch the barcode from the Hive box
      _barcode = Hive.box('ExamMission').get('Barcode');
    } else {
      /// Set the barcode to null if it does not exist in the Hive box
      _barcode = null;
    }

    /// Return the barcode
    return _barcode;
  }

  /// Fetches the exam mission from the Hive box
  ///
  /// This method will fetch the exam mission from the Hive box if it exists, otherwise it will return null.
  ///
  /// The exam mission is stored in the Hive box with the key "ExamMission". If it exists, it will be
  /// returned as an ExamMission object. Otherwise, null will be returned.
  ExamMission? getExamMissionFromHiveBox() {
    /// Check if the exam mission exists in the Hive box
    if (Hive.box('ExamMission').containsKey("ExamMission")) {
      /// Fetch the exam mission from the Hive box
      var data = Hive.box('ExamMission').get('ExamMission');

      /// Decode the json string to an ExamMission object
      _cachedExamMission = ExamMission.fromJson(jsonDecode(data));
    } else {
      /// Set the exam mission to null if it does not exist in the Hive box
      _cachedExamMission = null;
    }

    /// Return the exam mission
    return _cachedExamMission;
  }

  /// This method will be called when the controller is closed.
  ///
  /// It will delete the exam mission from the Hive box when the controller is closed.
  ///
  /// This is important to make sure that the exam mission is deleted from the Hive box
  /// when the controller is closed, otherwise the exam mission will remain in the Hive box
  /// even after the controller is closed.
  @override
  void onClose() {
    /// Delete the exam mission from the Hive box
    deleteExamMissionFromHiveBox();

    /// Call the onClose method of the superclass
    super.onClose();
  }

  /// Saves the exam mission to the Hive box
  ///
  /// This method will save the exam mission to the Hive box and update the UI.
  ///
  /// The exam mission is stored in the Hive box with the key "ExamMission".
  /// The barcode is stored in the Hive box with the key "Barcode".
  void saveExamMissionToHiveBox({
    /// The exam mission to be saved to the Hive box
    required ExamMission examMission,

    /// The barcode to be saved to the Hive box
    required String barcode,
  }) {
    /// Update the cached exam mission
    _cachedExamMission = examMission;

    /// Update the UI
    update();

    /// Save the exam mission to the Hive box
    Hive.box('ExamMission')
        .put('ExamMission', jsonEncode(examMission.toJson()));

    /// Save the barcode to the Hive box
    Hive.box('ExamMission').put('Barcode', barcode);
  }
}
