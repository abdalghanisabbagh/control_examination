import 'barcode_res_model.dart';

class BarcodesResModel {
  List<BarcodeResModel>? barcodes;

  BarcodesResModel({this.barcodes});

  BarcodesResModel.fromJson(json) {
    barcodes = List<BarcodeResModel>.from(
        json.map((e) => BarcodeResModel.fromJson(e)).toList());
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> data = [];
    data = barcodes!.map((v) => v.toJson()).toList();
    return data;
  }
}
