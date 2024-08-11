import '../class_room/class_room_res_model.dart';
import '../cohort/cohort_res_model.dart';
import '../grade_response/grade_res_model.dart';

class StudentResModel {
  int? active;

  int? blbId;

  ClassRoomResModel? classRoomResModel;
  int? cohortID;
  String? cohortName;
  CohortResModel? cohortResModel;
  String? createdAt;
  int? createdBy;
  String? email;
  String? firstName;
  String? gradeName;
  GradeResModel? gradeResModel;
  int? gradesID;
  int? iD;
  String? religion;
  int? schoolClassID;
  String? schoolClassName;
  int? schoolsID;
  String? secondLang;
  String? secondName;
  String? thirdName;
  DateTime? updatedAt;
  int? updatedBy;
  StudentResModel(
      {this.iD,
      this.blbId,
      this.gradesID,
      this.gradeName,
      this.schoolsID,
      this.cohortID,
      this.cohortName,
      this.schoolClassID,
      this.schoolClassName,
      this.firstName,
      this.secondName,
      this.thirdName,
      this.email,
      this.secondLang,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.gradeResModel,
      this.classRoomResModel,
      this.cohortResModel,
      this.active,
      this.religion});
  StudentResModel.fromJson(json) {
    iD = json['ID'];
    blbId = json['Blb_Id'];
    gradesID = json['Grades_ID'];
    schoolsID = json['Schools_ID'];
    cohortID = json['Cohort_ID'];
    schoolClassID = json['School_Class_ID'];
    firstName = json['First_Name'];
    secondName = json['Second_Name'];
    thirdName = json['Third_Name'];
    email = json['Email'];
    secondLang = json['Second_Lang'];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
    updatedBy = json['Updated_By'];
    updatedAt = json['Updated_At'];
    religion = json['Religion'];
    gradeResModel =
        json['grades'] == null ? null : GradeResModel.fromJson(json['grades']);
    classRoomResModel = json['school_class'] == null
        ? null
        : ClassRoomResModel.fromJson(json['school_class']);
    cohortResModel =
        json['cohort'] == null ? null : CohortResModel.fromJson(json['cohort']);
    active = json['Active'];
  }
}
