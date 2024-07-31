import 'package:control_examination/models/student_exams/student_exam_res_model.dart';

class StudentExamsResModel {
  List<StudentExamResModel>? exams;

  StudentExamsResModel({this.exams});

  StudentExamsResModel.fromJson(json) {
    exams = List<StudentExamResModel>.from(
        json.map((e) => StudentExamResModel.fromJson(e)).toList());
  }
}
