import 'package:control_examination/screens/login/login_screen.dart';
import 'package:get/get.dart';

import 'bindings/bindings.dart';

class Routes {
  static const String initialRoute = "/loginScreen";
  static const String loginRoute = "/loginScreen";
  static const String loginForm = "/loginForm";

  // static const String nextExams = "/NextExams";
  // static const String allExams = "/AllExams";
  // static const String attendance = "/Attendance";
  // static const String studentsInExamRoom = "/StudentsInExamRoom";

  static List<GetPage> routes = [
    GetPage(
      name: loginRoute,
      page: () => const LoginScreen(),
      transition: Transition.fade,
      binding: LoginBinding(),
      transitionDuration: const Duration(seconds: 1),
    ),
    // GetPage(
    //   binding: NextExamBindings(),
    //   name: nextExams,
    //   page: () => const NextExamsPage(),
    //   transitionDuration: const Duration(seconds: 1),
    // ),
    // GetPage(
    //   name: allExams,
    //   page: () => const AllExams(),
    //   transitionDuration: const Duration(seconds: 1),
    // ),
    // GetPage(
    //   name: attendance,
    //   page: () => const Attendance(),
    //   transitionDuration: const Duration(seconds: 1),
    // ),
    // GetPage(
    //   binding: StudentsInExamRoomBinding(),
    //   name: studentsInExamRoom,
    //   page: () => const StudentsInExamRoomScreen(),
    //   transitionDuration: const Duration(seconds: 1),
    // ),
  ];
}
