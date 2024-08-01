import 'package:flutter/material.dart';

import '../../resource_manager/color_manager.dart';
import '../../resource_manager/styles_manager.dart';

class StudentExamScreen extends StatelessWidget {
  const StudentExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Exam',
          style: nunitoSemiBold.copyWith(
            fontSize: 16,
            color: ColorManager.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorManager.primary,
      ),
      body: const Center(
        child: Text('Welcome to the Student Exam Page'),
      ),
    );
  }
}
