import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:control_examination/controllers/surveys_controller.dart';

import '../../routes_manger.dart';

class SurveysScreen extends GetView<SurveysController> {
  const SurveysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: ColorManager.primary,
          title: Text(
            'Rate My Teacher',
            style: nunitoBold.copyWith(
              color: ColorManager.white,
              fontSize: 25,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: ColorManager.white,
            onPressed: () {
              Get.offAllNamed(Routes.homeScreen);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Instructions: Pick the option that best describes your experience in this class with the mentioned teacher.',
                style: nunitoBold.copyWith(),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                '4 = Strongly Agree | 3 = Agree | 2 = Somewhat Agree | 1 = Disagree',
                style: nunitoBold.copyWith(),
              ),
            ),
            // Equitable Learning Environment
            Text(
              'Equitable Learning Environment:',
              style: nunitoBold.copyWith(),
            ),
            const SizedBox(height: 10),
            _buildRatingQuestion(
                'You have a chance to join class discussions and activities.'),
            _buildRatingQuestion(
                'You use activities and lessons that work well for you.'),
            _buildRatingQuestion('You feel like you are being fairly treated.'),
            _buildRatingQuestion('You feel supported by your teacher.'),

            const SizedBox(height: 20),

            // High Expectations Environment
            Text(
              'High Expectations Environment:',
              style: nunitoBold.copyWith(),
            ),
            const SizedBox(height: 10),
            _buildRatingQuestion(
                'You understand what is expected of you in a way that is easy to understand.'),
            _buildRatingQuestion('You feel challenged by your teacher.'),
            _buildRatingQuestion(
                'You feel encouraged to create work you are proud of.'),
            _buildRatingQuestion(
                'You feel encouraged to think deeply and solve tough problems.'),
            _buildRatingQuestion(
                'You are given opportunities to take charge of your learning.'),

            const SizedBox(height: 20),

            // Supportive Learning Environment
            Text(
              'Supportive Learning Environment:',
              style: nunitoBold.copyWith(),
            ),
            const SizedBox(height: 10),
            _buildRatingQuestion(
                'Your classroom environment in that class is positive & friendly?'),
            _buildRatingQuestion(
                'You feel safe to ask questions or make mistakes without worrying.'),
            _buildRatingQuestion(
                'You feel helped when you are stuck or confused.'),
            _buildRatingQuestion(
                'You feel genuinely cared for and supported in class.'),

            const SizedBox(height: 20),

            // Active Learning Environment
            Text(
              'Active Learning Environment:',
              style: nunitoBold.copyWith(),
            ),
            const SizedBox(height: 10),
            _buildRatingQuestion(
                'You feel encouraged to share ideas and have discussions about them with your classmates.'),
            _buildRatingQuestion(
                'You connect what you are learning in class to things in real life.'),
            _buildRatingQuestion(
                'Lessons and activities are interesting so you want to join in.'),
            _buildRatingQuestion(
                'You work with classmates on fun projects or tasks.'),

            const SizedBox(height: 20),

            // Progress Monitoring and Feedback Environment
            Text(
              'Progress Monitoring and Feedback Environment:',
              style: nunitoBold.copyWith(),
            ),
            const SizedBox(height: 10),
            _buildRatingQuestion(
                'You get help to understand how you are doing in class.'),
            _buildRatingQuestion(
                'You get feedback that helps you improve your work.'),
            _buildRatingQuestion(
                'You are asked to explain or show what you have learned in class.'),
            _buildRatingQuestion('It is clear how your work is graded.'),

            const SizedBox(height: 20),

            // Well-Managed Learning Environment
            Text(
              'Well-Managed Learning Environment:',
              style: nunitoBold.copyWith(),
            ),
            const SizedBox(height: 10),
            _buildRatingQuestion('You are spoken kindly to.'),
            _buildRatingQuestion(
                'You know the class rules and you are helped to follow them.'),
            _buildRatingQuestion(
                'Your class runs smoothly without wasting time.'),
            _buildRatingQuestion(
                'Your class time is spent focusing on learning.'),

            const SizedBox(height: 20),

            // Digital Learning Environment
            Text(
              'Digital Learning Environment:',
              style: nunitoBold.copyWith(),
            ),
            const SizedBox(height: 10),
            _buildRatingQuestion(
                'You are taught how to use technology to find and learn new things.'),
            _buildRatingQuestion(
                'You are given cool tech-related projects like solving problems or creating something new.'),
            _buildRatingQuestion(
                'You use technology to help you and your classmates work together.'),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                controller.submitRating();
              },
              child: const Text('Submit Rating'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingQuestion(String question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: nunitoBold.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 10),
        GetBuilder<SurveysController>(
          builder: (_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(4, (index) {
                return Row(
                  children: [
                    Radio<int>(
                      value: index + 1,
                      groupValue: controller.ratings[question] ?? 0,
                      onChanged: (value) {
                        controller.updateRating(question, value!);
                      },
                    ),
                    Text(
                      '${index + 1}',
                      style: nunitoBold.copyWith(fontSize: 20),
                    ),
                  ],
                );
              }),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
