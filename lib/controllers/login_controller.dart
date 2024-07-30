import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_examination/controllers/controllers.dart';
import 'package:control_examination/resource_manager/enums/req_type_enum.dart';
import 'package:get/get.dart' hide Response;

import '../configurations/app_links.dart';
import '../models/login_response/login_res_model.dart';
import '../models/token_model.dart';
import '../resource_manager/ReusableWidget/show_dialgue.dart';
import '../services/token_service.dart';
import '../tools/response_handler.dart';

class LoginController extends GetxController {
  bool showPass = true;
  bool isLoading = false;
  bool isLogin = false;

  TokenService tokenService = Get.find<TokenService>();

  ProfileController profileController = Get.find<ProfileController>();

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

    response.fold((l) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: l.message,
        dialogType: DialogType.error,
      ).showDialogue(Get.context!);
      isLogin = false;
    }, (r) {
      tokenService.saveTokenModelToHiveBox(TokenModel(
        aToken: r.accessToken!,
        rToken: r.refreshToken!,
        dToken: DateTime.now().toIso8601String(),
      ));
      profileController.saveProfileToHiveBox(r.userProfile!);
      isLogin = true;
    });

    isLoading = false;
    update(['login_button']);
    return isLogin;
  }

  setShowPass() {
    showPass = !showPass;
    update(['pass_icon']);
  }
}
