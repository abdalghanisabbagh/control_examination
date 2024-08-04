import 'package:control_examination/controllers/full_screen_controller.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../services/token_service.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );
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
    Get.put<FullScreenController>(
      FullScreenController(),
      permanent: true,
    );
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
      fenix: true,
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

class StudentQrCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentQrCodeController>(
      () => StudentQrCodeController(),
      fenix: true,
    );
  }
}

class WebSocketBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WebSocketController>(
      WebSocketController(),
      permanent: true,
    );
  }
}

// class NextExamBindings extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<NextExamController>(
//       () => NextExamController(),
//       fenix: true,
//     );
//   }
//}

// class StudentsInExamRoomBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<StudentsInExamRoomController>(
//       () => StudentsInExamRoomController(),
//       fenix: true,
//     );
//   }
// }
