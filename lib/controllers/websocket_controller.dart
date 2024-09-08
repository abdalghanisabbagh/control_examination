import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../services/services.dart';
import 'controllers.dart';

class WebSocketController extends GetxController {
  final exam = Get.find<ExamMissionController>().cachedExamMission;
  late io.Socket socket;
  final token = Get.find<TokenService>().tokenModel;

  @override
  void onClose() {
    socket.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    _connectToWebSocket();
  }

  void _connectToWebSocket() {
    /* 
    socket = io.io(
        'http://localhost:3000',
        io.OptionBuilder().setTransports(['websocket']).setAuth({
          'authorization': '${token?.aToken}',
        }).setQuery({
          'roomid': '${exam?.examRoomHasExamMission?.first.examRoom?.iD}'
        }).build())
      ..onConnect((_) {
        debugPrint('connected');
      })
      ..onDisconnect((_) {
        debugPrint('disconnected');
      })
      ..on('joinRoom', (data) {
        debugPrint('User joined $data');
      })
      ..on('leaveRoom', (data) {
        debugPrint('User left $data');
      })
      ..on('userLeft', (data) {
        debugPrint('User left $data');
      })
      ..on('newUser', (data) {
        debugPrint('User joined $data');
      })
      ..on('onEvent', (data) {
        debugPrint('onEvent $data');
      })
      ..onError((data) {
        debugPrint('onError $data');
      })
      ..connect();
   */
  }
}
