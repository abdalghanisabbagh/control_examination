import '../exam_mission/exam_mission_res_model.dart';

class StudentExamResModel {
  ExamMission? examMission;

  StudentExamResModel({this.examMission});

  StudentExamResModel.fromJson(Map<String, dynamic> json) {
    examMission = json['exam_mission'] != null
        ? ExamMission.fromJson(json['exam_mission'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (examMission != null) {
      data['exam_mission'] = examMission!.toJson();
    }
    return data;
  }
}
