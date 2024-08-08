import '../exam_mission/exam_mission_res_model.dart';

class StudentExamResModel {
  int? attendanceStatusId;

  String? barcode;

  ExamMission? examMission;
  int? isCheating;
  StudentExamResModel({this.examMission, this.isCheating});
  StudentExamResModel.fromJson(json) {
    barcode = json['Barcode'];
    attendanceStatusId = json['AttendanceStatusId'];
    isCheating = json['isCheating'];
    examMission = json['exam_mission'] != null
        ? ExamMission.fromJson(json['exam_mission'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Barcode'] = barcode;
    data['isCheating'] = isCheating;
    data['AttendanceStatusId'] = attendanceStatusId;
    if (examMission != null) {
      data['exam_mission'] = examMission!.toJson();
    }
    return data;
  }
}
