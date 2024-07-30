import 'student_res_model.dart';

class StudentsResModel {
  List<StudentResModel>? students;

  StudentsResModel({this.students});

  StudentsResModel.fromJson(json) {
    students = List<StudentResModel>.from(
        json.map((e) => StudentResModel.fromJson(e)).toList());
  }
}
