import '../exam_room/exam_room_res_model.dart';

class ExamRoomHasExamMission {
  ExamRoom? examRoom;

  ExamRoomHasExamMission({this.examRoom});

  ExamRoomHasExamMission.fromJson(Map<String, dynamic> json) {
    examRoom =
        json['exam_room'] != null ? ExamRoom.fromJson(json['exam_room']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (examRoom != null) {
      data['exam_room'] = examRoom!.toJson();
    }
    return data;
  }
}
