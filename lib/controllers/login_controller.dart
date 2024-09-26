import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart' hide Response;
import 'package:package_info_plus/package_info_plus.dart';

import '../configurations/app_links.dart';
import '../models/login_response/login_res_model.dart';
import '../models/token_model.dart';
import '../resource_manager/ReusableWidget/show_dialgue.dart';
import '../resource_manager/enums/req_type_enum.dart';
import '../services/token_service.dart';
import '../tools/response_handler.dart';
import 'controllers.dart';

/// LoginController is a GetX controller that is used to control the login screen.
///
/// The controller has the following properties:
/// - [isLoading] is a boolean that indicates whether the login request is in progress.
/// - [isLogin] is a boolean that indicates whether the login request was successful.
/// - [packageInfo] is a PackageInfo object that contains the package name and version.
/// - [profileController] is a ProfileController object that is used to save the user profile to the Hive box.
/// - [showPass] is a boolean that indicates whether the password is shown or hidden.
/// - [tokenService] is a TokenService object that is used to save the token to the Hive box.
///
/// The controller has the following methods:
/// - [login] is a method that is used to make a login request to the server.
/// - [onInit] is a method that is called when the controller is initialized and is used to get the package info from the PackageInfo.fromPlatform() method.
/// - [setShowPass] is a method that is used to show or hide the password.
class LoginController extends GetxController {
  /// isLoading is a boolean that indicates whether the login request is in progress.
  bool isLoading = false;

  /// isLogin is a boolean that indicates whether the login request was successful.
  bool isLogin = false;

  /// packageInfo is a PackageInfo object that contains the package name and version.
  PackageInfo? packageInfo;

  /// profileController is a ProfileController object that is used to save the user profile to the Hive box.
  ProfileController profileController = Get.find<ProfileController>();

  /// showPass is a boolean that indicates whether the password is shown or hidden.
  bool showPass = true;

  /// tokenService is a TokenService object that is used to save the token to the Hive box.
  TokenService tokenService = Get.find<TokenService>();

  /// login is a method that is used to make a login request to the server.
  ///
  /// The method takes two parameters: [username] and [password].
  ///
  /// The method returns a boolean value that indicates whether the login request was successful.
  Future<bool> login(String username, String password) async {
    isLoading = true;
    update(['login_button']);
    ResponseHandler<LoginResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: AuthLinks.studentLogin,
      converter: LoginResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "userName": username,
        "password": password,
      },
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.context!);
        isLogin = false;
      },
      (r) {
        tokenService.saveTokenModelToHiveBox(
          TokenModel(
            aToken: r.accessToken!,
            rToken: r.refreshToken!,
          ),
        );
        profileController.saveProfileToHiveBox(r.userProfile!);
        Get.put<WebSocketController>(
          WebSocketController(),
          permanent: true,
        );
        isLogin = true;
      },
    );

    isLoading = false;
    update(['login_button']);
    return isLogin;
  }

  /// onInit is a method that is called when the controller is initialized and is used to get the package info from the PackageInfo.fromPlatform() method.
  ///
  /// This method is overridden from the [GetxController] class and is used to initialize the controller.
  /// It is called when the controller is initialized and is used to get the package info from the PackageInfo.fromPlatform() method.
  /// The package info is then stored in the [packageInfo] property.
  @override
  void onInit() async {
    super.onInit();
    packageInfo = await PackageInfo.fromPlatform();
    update();
  }

  /// setShowPass is a method that is used to show or hide the password.
  ///
  /// This method is called when the user clicks the show/hide password button.
  /// It toggles the [showPass] property and updates the UI.
  void setShowPass() {
    /// Toggle the showPass property
    showPass = !showPass;

    /// Update the UI
    update(['pass_icon']);
  }
}
