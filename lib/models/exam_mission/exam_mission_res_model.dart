import '../exam_has_exam_mission/exam_room_has_exam_mission.dart';
import '../exam_room/exam_room_res_model.dart';

class ExamMission {
  List<ExamRoomHasExamMission>? examRoomHasExamMission;
  int? iD;
  String? startTime;
  String? endTime;
  int? duration;
  ExamRoom? subjects;

  ExamMission({this.examRoomHasExamMission, this.iD, this.subjects});

  ExamMission.fromJson(json) {
    if (json['exam_room_has_exam_mission'] != null) {
      examRoomHasExamMission = <ExamRoomHasExamMission>[];
      json['exam_room_has_exam_mission'].forEach((v) {
        examRoomHasExamMission!.add(ExamRoomHasExamMission.fromJson(v));
      });
    }
    iD = json['ID'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    duration = json['duration'];
    subjects =
        json['subjects'] != null ? ExamRoom.fromJson(json['subjects']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (examRoomHasExamMission != null) {
      data['exam_room_has_exam_mission'] =
          examRoomHasExamMission!.map((v) => v.toJson()).toList();
    }
    data['ID'] = iD;
    if (subjects != null) {
      data['subjects'] = subjects!.toJson();
    }
    return data;
  }
}