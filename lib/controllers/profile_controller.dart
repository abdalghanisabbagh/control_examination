import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../models/login_response/user_profile_model.dart';

/// ProfileController is a GetX controller that is used to control the user profile data.
///
/// The controller has the following properties:
/// - [cachedUserProfile] is a UserProfileModel object that contains the user profile data.
///
/// The controller has the following methods:
/// - [deleteProfileFromHiveBox] is a method that is used to delete the user profile from the Hive box.
/// - [getProfileFromHiveBox] is a method that is used to fetch the user profile from the Hive box.
/// - [saveProfileToHiveBox] is a method that is used to save the user profile to the Hive box.
class ProfileController extends GetxController {
  UserProfileModel? _cachedUserProfile;

  /// The cached user profile data.
  ///
  /// This property is used to store the user profile data in memory.
  /// It is fetched from the Hive box when the controller is initialized.
  UserProfileModel? get cachedUserProfile =>
      _cachedUserProfile ?? getProfileFromHiveBox();

  /// Deletes the user profile from the Hive box.
  ///
  /// This method is used to delete the user profile from the Hive box.
  /// It is called when the user logs out.
  Future<void> deleteProfileFromHiveBox() async {
    _cachedUserProfile = null;
    await Hive.box('Profile').clear();
  }

  /// Fetches the user profile from the Hive box.
  ///
  /// This method is used to fetch the user profile from the Hive box.
  /// It checks if the user profile exists in the Hive box and returns it.
  UserProfileModel? getProfileFromHiveBox() {
    var data = Hive.box('Profile').get('Profile');
    _cachedUserProfile = Hive.box('Profile').containsKey("Profile")
        ? UserProfileModel.fromJson(jsonDecode(data))
        : null;
    return _cachedUserProfile;
  }

  /// Saves the user profile to the Hive box.
  ///
  /// This method is used to save the user profile to the Hive box.
  /// It is called when the user profile is updated.
  void saveProfileToHiveBox(UserProfileModel cachedUserProfile) {
    update();
    Hive.box('Profile').put('Profile', jsonEncode(cachedUserProfile.toJson()));
  }
}
