import '../exam_mission/exam_mission_res_model.dart';

class StudentExamResModel {
  ExamMission? examMission;

  int? isCheating;
  int? attendanceStatusId;

  StudentExamResModel({this.examMission, this.isCheating});

  StudentExamResModel.fromJson(Map<String, dynamic> json) {
    attendanceStatusId = json['AttendanceStatusId'];
    isCheating = json['isCheating'];
    examMission = json['exam_mission'] != null
        ? ExamMission.fromJson(json['exam_mission'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isCheating'] = isCheating;
    data['AttendanceStatusId'] = attendanceStatusId;
    if (examMission != null) {
      data['exam_mission'] = examMission!.toJson();
    }
    return data;
  }
}
