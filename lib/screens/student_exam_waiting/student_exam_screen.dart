import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/student_exam/student_in_exam_controller.dart';
import '../../resource_manager/color_manager.dart';
import '../../resource_manager/styles_manager.dart';

class StudentInExamScreen extends GetView<StudentInExamController> {
  const StudentInExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
        ),
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
