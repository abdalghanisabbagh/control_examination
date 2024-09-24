import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../configurations/app_links.dart';
import '../routes_manger.dart';
import '../services/token_service.dart';
import 'controllers.dart';
import 'full_screen_controller.dart';

class WebSocketController extends GetxController {
  final ProfileController profileController = Get.find();
  late io.Socket socket;

  void closeSocket() {
    socket.dispose();
  }

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
        (_) {},
      )
      ..onDisconnect(
        (_) {
          Get.delete<WebSocketController>(force: true);
          Get.offAllNamed(Routes.initialRoute);
        },
      )
      ..on(
        'error',
        (error) {
          if (error['status'] == 400) {
            Get.delete<WebSocketController>(force: true);
            Get.offAllNamed(Routes.initialRoute);
          }
        },
      )
      ..on(
        'room_event',
        (roomEvent) {
          if (roomEvent['eventType'] == 1 || roomEvent['eventType'] == 0) {
            if (roomEvent['studentId'] ==
                profileController.cachedUserProfile?.iD) {
              Get.delete<FullScreenController>(force: true);
              Get.find<HomeController>().onInit();
              Get.offAllNamed(Routes.homeScreen);
            }
          }
        },
      );
  }

  @override
  void onClose() {
    closeSocket();
    super.onClose();
  }

  @override
  void onInit() {
    initSocket();
    super.onInit();
  }
}
