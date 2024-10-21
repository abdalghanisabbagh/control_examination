import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../models/login_response/user_profile_model.dart';

/// this controller is responsible for the user profile
/// it contains the user data and the user role
/// and it has methods to get, save and delete the user profile
class ProfileController extends GetxController {
  UserProfileModel? _cachedUserProfile;

  /// this method gets the user profile from the hive box
  /// it returns the user profile model
  UserProfileModel? get cachedUserProfile =>
      _cachedUserProfile ?? getProfileFromHiveBox();

  /// this method deletes the user profile from the hive box
  /// it returns a future
  Future<void> deleteProfileFromHiveBox() async {
    _cachedUserProfile = null;
    update();
    await Hive.box('Profile').clear();
  }

  /// this method gets the user profile from the hive box
  /// it returns the user profile model
  UserProfileModel? getProfileFromHiveBox() {
    var data = Hive.box('Profile').get('Profile');
    _cachedUserProfile = Hive.box('Profile').containsKey("Profile")
        ? UserProfileModel.fromJson(jsonDecode(data))
        : null;
    return _cachedUserProfile;
  }

  /// this method saves the user profile to the hive box
  /// it takes the user profile model as a parameter
  /// and returns a future
  Future<void> saveProfileToHiveBox(UserProfileModel cachedUserProfile) async {
    _cachedUserProfile = cachedUserProfile;
    update();
    await Hive.box('Profile')
        .put('Profile', jsonEncode(cachedUserProfile.toJson()));
  }
}
