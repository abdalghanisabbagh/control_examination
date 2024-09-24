import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../controllers/window_size_controller.dart';
import '../services/token_service.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(),
      permanent: true,
    );
    LoginBinding().dependencies();
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(
      TokenService(),
      permanent: true,
    );

    Get.put(
      ExamMissionController(),
      permanent: true,
    );

    Get.put<ProfileController>(
      ProfileController(),
      permanent: true,
    );

    Get.put<SideMenuController>(
      SideMenuController(),
      permanent: true,
    );

    Get.put<WindowSizeController>(
      WindowSizeController(),
      permanent: true,
    );
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(
      LoginController(),
      permanent: true,
    );
  }
}

class StudentExamBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StudentExamController>(
      StudentExamController(),
      permanent: true,
    );
  }
}

class StudentInExamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentInExamController>(
      () => StudentInExamController(),
      fenix: true,
    );
  }
}

class StudentQrCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StudentQrCodeController>(
      StudentQrCodeController(),
      permanent: true,
    );
  }
}

class WebSocketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebSocketController>(
      () => WebSocketController(),
      fenix: true,
    );
  }
}
