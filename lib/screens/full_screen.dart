import 'package:flutter/material.dart';
import 'dart:js' as js;

class FullScreenPage extends StatefulWidget {
  @override
  _FullScreenPageState createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage> {
  @override


  void _enterFullScreen() {
    try {
      js.context.callMethod('enterFullScreen');
    } catch (e) {
      print('Error entering full screen: $e');
    }
  }

  void _exitFullScreen() {
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
        title: Text('Full Screen Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _enterFullScreen,
              child: Text('Enter Full Screen'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _exitFullScreen,
              child: Text('Exit Full Screen'),
            ),
          ],
        ),
      ),
    );
  }
}