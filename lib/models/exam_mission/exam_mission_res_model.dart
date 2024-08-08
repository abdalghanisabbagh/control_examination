import '../control_mission/control_mission_res_model.dart';
import '../exam_has_exam_mission/exam_room_has_exam_mission.dart';
import '../subject/subject_res_model.dart';

class ExamMission {
  List<ExamRoomHasExamMission>? examRoomHasExamMission;
  int? iD;
  String? startTime;
  String? endTime;
  int? duration;
  String? month;

  String? pdf;

  String? pdfV2;

  bool? period;

  String? year;

  SubjectResModel? subjects;

  ControlMissionResModel? controlMissionResModel;

  ExamMission({
    this.examRoomHasExamMission,
    this.iD,
    this.subjects,
    this.month,
    this.year,
    this.period,
    this.duration,
    this.pdf,
    this.pdfV2,
    this.startTime,
    this.endTime,
    this.controlMissionResModel,
  });

  ExamMission.fromJson(json) {
    if (json['control_mission'] != null) {
      controlMissionResModel =
          ControlMissionResModel.fromJson(json['control_mission']);
    }
    if (json['exam_room_has_exam_mission'] != null) {
      examRoomHasExamMission = <ExamRoomHasExamMission>[];
      json['exam_room_has_exam_mission'].forEach((v) {
        examRoomHasExamMission!.add(ExamRoomHasExamMission.fromJson(v));
      });
    }
    iD = json['ID'];
    month = json['Month'];

    year = json['Year'];

    period = json['Period'];

    duration = json['duration'];

    pdf = json['pdf'];

    pdfV2 = json['pdf_V2'];

    startTime = json['start_time'];
    endTime = json['end_time'];
    duration = json['duration'];
    subjects = json['subjects'] != null
        ? SubjectResModel.fromJson(json['subjects'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['duration'] = duration;
    data['Month'] = month;
    data['Year'] = year;
    data['Period'] = period;
    data['pdf'] = pdf;
    data['pdf_V2'] = pdfV2;
    if (examRoomHasExamMission != null) {
      data['exam_room_has_exam_mission'] =
          examRoomHasExamMission!.map((v) => v.toJson()).toList();
    }

    if (controlMissionResModel != null) {
      data['control_mission'] = controlMissionResModel!.toJson();
    }
    data['ID'] = iD;
    if (subjects != null) {
      data['subjects'] = subjects!.toJson();
    }
    return data;
  }
}
