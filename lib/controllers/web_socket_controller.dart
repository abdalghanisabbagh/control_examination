import 'package:control_examination/controllers/student_exam/student_waiting_to_start_exam.dart';
import 'package:control_examination/models/student_exams/exam_link_res_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../configurations/app_links.dart';
import '../routes_manger.dart';
import '../services/token_service.dart';
import 'controllers.dart';
import 'full_screen_controller.dart';

class WebSocketController extends GetxController {
  final ProfileController profileController = Get.find();
  late io.Socket socket;

  /// Closes the socket and disposes of it.
  ///
  /// This is important to avoid memory leaks and to disconnect the
  /// socket from the server.
  void closeSocket() {
    socket.dispose();
  }

  /// Initializes the socket and connects to the server.
  ///
  /// This method will create a new socket with the given auth token and
  /// connect to the server. It will also set up the necessary event
  /// listeners for the socket.
  void initSocket() {
    socket = io.io(
      AppLinks.baseUrlDev,
      io.OptionBuilder()
          .setAuth(
            {
              'Authorization':
                  'Bearer ${Get.find<TokenService>().tokenModel?.aToken}',
            },
          )
          .setTransports(['websocket']) // for Flutter or Dart VM
          .enableAutoConnect() // enable auto-connection
          .build(),
    )
      ..onConnect(
        (_) {
          // Handle connection event
        },
      )
      ..onDisconnect(
        (_) {
          // Handle disconnection event
          Get.delete<WebSocketController>(force: true);
          Get.offAllNamed(Routes.initialRoute);
        },
      )
      ..on(
        'error',
        (error) {
          // Handle error event
          if (error['status'] == 400) {
            Get.delete<WebSocketController>(force: true);
            Get.offAllNamed(Routes.initialRoute);
          }
        },
      )
      ..on(
        'room_event',
        (roomEvent) {
          // Handle room event
          if (roomEvent['eventType'] == 1 || roomEvent['eventType'] == 0) {
            if (roomEvent['studentId'] ==
                profileController.cachedUserProfile?.iD) {
              // If the event is for the current student, go back to the home
              // screen
              Get.delete<FullScreenController>(force: true);
              Get.find<HomeController>().onInit();
              Get.offAllNamed(Routes.homeScreen);
            }
          }
        },
      )
      ..on(
        'start_exam',
        (startExam) {
          // Handle start exam event
          if (startExam['studentId'] ==
              profileController.cachedUserProfile?.iD) {
            // If the event is for the current student, go to the student exam
            // screen
            Get.find<StudentWaitingToStartExamController>()
                .examLinkResModel
                .complete(
                  ExamLinkResModel(
                    examLink: startExam['examUrl'],
                  ),
                );
            Hive.box('ExamMission').put('inExam', true);
            Get.offNamed(Routes.studentExamScreen);
          }
        },
      );
  }

  /// Closes the socket and disposes of it when the controller is closed.
  ///
  /// This is important to avoid memory leaks and to disconnect the socket
  /// from the server.
  @override
  void onClose() {
    closeSocket();
    super.onClose();
  }

  /// Initializes the socket and adds event listeners to it.
  ///
  /// This method is called when the controller is initialized.
  @override
  void onInit() {
    // Initialize the socket and add event listeners to it.
    initSocket();
    super.onInit();
  }
}
