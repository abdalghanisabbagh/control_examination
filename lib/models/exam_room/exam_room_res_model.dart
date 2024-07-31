class ExamRoom {
  int? iD;
  String? name;

  ExamRoom({this.iD, this.name});

  ExamRoom.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    return data;
  }
}
