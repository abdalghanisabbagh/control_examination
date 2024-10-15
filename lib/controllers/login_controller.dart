import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart' hide Response;
import 'package:package_info_plus/package_info_plus.dart';

import '../configurations/app_links.dart';
import '../models/login_response/login_res_model.dart';
import '../models/token_model.dart';
import '../resource_manager/ReusableWidget/show_dialogue.dart';
import '../resource_manager/enums/req_type_enum.dart';
import '../services/token_service.dart';
import '../tools/response_handler.dart';
import 'controllers.dart';

/// this controller is responsible for the login process
/// it contains the login function and the related UI state
class LoginController extends GetxController {
  /// package info of the app
  PackageInfo? packageInfo;

  /// whether the login button is loading or not
  bool isLoading = false;

  /// whether the user is logged in or not
  bool isLogin = false;

  /// the profile controller
  ProfileController profileController = Get.find<ProfileController>();

  /// whether to show the password or not
  bool showPass = true;

  /// the token service
  TokenService tokenService = Get.find<TokenService>();

  /// the login function
  /// it will be called when the user presses the login button
  /// it will get the user name and password from the UI
  /// it will call the login API and handle the response
  /// if the response is success it will save the token to the hive box
  /// and navigate to the home page
  /// if the response is error it will show a dialog with the error message
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
        isLogin = true;
      },
    );

    isLoading = false;
    update(['login_button']);
    return isLogin;
  }

  /// override the onInit function
  /// it will be called when the controller is initialized
  /// it will get the package info of the app
  @override
  void onInit() async {
    super.onInit();
    packageInfo = await PackageInfo.fromPlatform();
    update();
  }

  /// the function to show or hide the password
  /// it will be called when the user presses the show password button
  /// it will toggle the showPass variable
  /// and update the UI
  void setShowPass() {
    showPass = !showPass;
    update(['pass_icon']);
  }
}
