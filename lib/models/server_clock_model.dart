class ServerClockResModel {
  String? data;

  ServerClockResModel({this.data});

  ServerClockResModel.fromJson(json) {
    data = json;
  }
}
