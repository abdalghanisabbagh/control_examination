import 'package:flutter/material.dart';
import 'dart:js' as js;

import 'package:flutter/services.dart';

class FullScreenPage extends StatefulWidget {
  @override
  _FullScreenPageState createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage> {
  final FocusNode _focusNode = FocusNode();
  String _lastKey = 'None';

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  void enterFullScreen() {
    try {
      js.context.callMethod('enterFullScreen');
    } catch (e) {
      print('Error entering full screen: $e');
    }
  }

  void exitFullScreen() {
    try {
      js.context.callMethod('exitFullScreen');
    } catch (e) {
      print('Error exiting full screen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Screen Page'),
      ),
      body: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent) {
            setState(() {
              _lastKey = event.logicalKey.debugName ?? 'Unknown';
              debugPrint('Key pressed: ${event.logicalKey.debugName}');
            });
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: enterFullScreen,
                child: const Text('Enter Full Screen'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: exitFullScreen,
                child: const Text('Exit Full Screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
