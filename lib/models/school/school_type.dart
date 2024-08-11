class SchoolTypeResModel {
  String? name;

  SchoolTypeResModel({this.name});

  SchoolTypeResModel.fromJson(json) {
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    return data;
  }
}
