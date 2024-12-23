import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../models/token_model.dart';

class TokenService extends GetxController {
  TokenModel? _tokenModel;

  TokenModel? get tokenModel => _tokenModel ?? getTokenModelFromHiveBox();

  Future<void> deleteTokenModelFromHiveBox() async {
    _tokenModel = null;
    await Hive.box('Token').clear();
  }

  TokenModel? getTokenModelFromHiveBox() {
    _tokenModel = Hive.box('Token').containsKey('Token')
        ? TokenModel.fromJson(jsonDecode(Hive.box('Token').get('Token')))
        : null;
    return _tokenModel;
  }

  void saveNewAccessToken(TokenModel tokenModel) {
    _tokenModel = tokenModel;
    Hive.box('Token').put('Token', jsonEncode(tokenModel.toJson()));
  }

  void saveTokenModelToHiveBox(TokenModel tokenModel) {
    _tokenModel = tokenModel;
    Hive.box('Token').put('Token', jsonEncode(tokenModel.toJson()));
  }
}
