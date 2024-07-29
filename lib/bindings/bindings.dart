import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../controllers/home/home_controller.dart';
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

    Get.put<ProfileController>(
      ProfileController(),
      permanent: true,
    );

    Get.put<SideMenuController>(
      SideMenuController(),
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
