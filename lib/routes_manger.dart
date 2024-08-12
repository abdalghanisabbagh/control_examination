import 'package:get/get.dart';

import 'bindings/bindings.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/student_exam_waiting/student_exam_waiting_screen.dart';
import 'screens/student_exam_waiting/student_in_exam_screen.dart';
import 'screens/student_exam_waiting/student_qr_screen.dart';

class Routes {
  static const String homeScreen = "/home";
  static const String initialRoute = "/login";
  static const String loginForm = "/loginForm";
  static const String loginRoute = "/login";
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
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
      transition: Transition.fade,
      binding: HomeBindings(),
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: studentExamScreenWaiting,
      page: () => StudentExamWaitingScreen(),
      transition: Transition.fade,
      binding: StudentExamBinding(),
      bindings: [WebSocketBinding()],
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: studentExamScreenQRCode,
      page: () => StudentQrScreen(),
      transition: Transition.fade,
      binding: StudentQrCodeBinding(),
      bindings: [
        StudentExamBinding(),
        WebSocketBinding(),
      ],
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: studentExamScreen,
      page: () => const StudentInExamScreen(),
      transition: Transition.fade,
      binding: StudentInExamBinding(),
      bindings: [
        HomeBindings(),
        WebSocketBinding(),
        StudentQrCodeBinding(),
        StudentExamBinding()
      ],
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

  static const String studentExamScreen = "/studentExamScreen";
  static const String studentExamScreenQRCode = "/studentExamScreenQRCode";
  static const String studentExamScreenWaiting = "/studentExamScreenWaiting";
}
