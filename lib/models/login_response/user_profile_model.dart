import 'package:control_examination/models/school/school_res_model.dart';

import '../grade_response/grade_res_model.dart';

class UserProfileModel {
  int? active;

  int? blbId;

  // ClassRoomResModel? classRoomResModel;

  int? cohortID;
  String? cohortName;
  String? userName;
  // CohortResModel? cohortResModel;
  // BarcodesResModel? barcodesResModel;
  String? createdAt;
  int? createdBy;
  String? email;
  String? firstName;
  String? gradeName;
  GradeResModel? gradeResModel;
  SchoolResModel? schoolResModel;
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
  UserProfileModel({
    this.iD,
    this.blbId,
    this.userName,
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
    this.schoolResModel,
    // this.barcodesResModel,
    // this.classRoomResModel,
    // this.cohortResModel,
    this.active,
    this.religion,
  });

  UserProfileModel.fromJson(json) {
    iD = json['ID'];
    userName = json['User_Name'];
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
    schoolResModel = json['schools'] == null
        ? null
        : SchoolResModel.fromJson(json['schools']);
    // barcodesResModel = json['student_barcode'] == null
    //     ? null
    // : BarcodesResModel.fromJson(json['student_barcode']);
    // classRoomResModel = json['school_class'] == null
    //     ? null
    //     : ClassRoomResModel.fromJson(json['school_class']);
    // cohortResModel =
    //     json['cohort'] == null ? null : CohortResModel.fromJson(json['cohort']);
    // active = json['Active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Blb_Id'] = blbId;
    data['User_Name'] = userName;
    data['Grades_ID'] = gradesID;
    data['Schools_ID'] = schoolsID;
    data['Cohort_ID'] = cohortID;
    data['School_Class_ID'] = schoolClassID;
    data['First_Name'] = firstName;
    data['Second_Name'] = secondName;
    data['Third_Name'] = thirdName;
    data['Email'] = email;
    data['Second_Lang'] = secondLang;
    data['Created_By'] = createdBy;
    data['Created_At'] = createdAt;
    data['Updated_By'] = updatedBy;
    data['Updated_At'] = updatedAt;
    data['Religion'] = religion;
    if (gradeResModel != null) {
      data['grades'] = gradeResModel!.toJson();
    }
    if (schoolResModel != null) {
      data['schools'] = schoolResModel!.toJson();
    }
    // if (barcodesResModel != null) {
    //   data['student_barcode'] = barcodesResModel!.toJson();
    // }
    // if (classRoomResModel != null) {
    //   data['school_class'] = classRoomResModel!.toJson();
    // }
    // if (cohortResModel != null) {
    //   data['cohort'] = cohortResModel!.toJson();
    // }
    data['Active'] = active;
    return data;
  }
}
