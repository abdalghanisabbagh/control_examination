class UuidResModel {
  int? active;

  String? createdAt;

  int? createdBy;
  int? examMissionId;
  int? iD;
  String? studentId;
  String? uUID;
  String? updatedAt;
  String? updatedBy;
  UuidResModel({
    this.iD,
    this.uUID,
    this.examMissionId,
    this.studentId,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });
  UuidResModel.fromJson(json) {
    iD = json['ID'];
    uUID = json['UUID'];
    examMissionId = json['ExamMissionId'];
    studentId = json['student_id'];
    active = json['active'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    createdBy = json['Created_by'];
    updatedBy = json['Updated_By'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['UUID'] = uUID;
    data['ExamMissionId'] = examMissionId;
    data['student_id'] = studentId;
    data['active'] = active;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['Created_by'] = createdBy;
    data['Updated_By'] = updatedBy;
    return data;
  }
}
