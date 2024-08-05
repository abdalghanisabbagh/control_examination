class ControlMissionResModel {
  int? iD;
  String? name;

  ControlMissionResModel({this.iD, this.name});

  ControlMissionResModel.fromJson(json) {
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
