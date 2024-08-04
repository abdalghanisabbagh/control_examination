import 'package:control_examination/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/full_screen_controller.dart';

// ignore: must_be_immutable
class FullScreenPage extends GetView<FullScreenController> {
  final FocusNode _focusNode = FocusNode()..requestFocus();

  FullScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent) {
          controller.handleKeyEvent(event);
          controller.updateLastKey(event.logicalKey.debugName ?? 'Unknown');
          debugPrint('Key pressed: ${event.logicalKey.debugName}');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Full Screen Page'),
        ),
        body: Center(
          child: GetBuilder<FullScreenController>(
            builder: (_) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: controller.enterFullScreen,
                    child: const Text('Enter Full Screen'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: controller.exitFullScreen,
                    child: const Text('Exit Full Screen'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Last Key Pressed: ${controller.lastKey}',
                    style: nunitoBoldStyle(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
