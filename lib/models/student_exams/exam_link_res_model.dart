class ExamLinkResModel {
  String? examLink;

  ExamLinkResModel({this.examLink});

  ExamLinkResModel.fromJson(json) {
    examLink = json;
  }
}
