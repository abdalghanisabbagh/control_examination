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
            'Surveys',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Please rate the teacher (1 to 5):',
                style: nunitoBold.copyWith(),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'How would you rate the teacher’s interaction?',
              style: nunitoBold.copyWith(),
            ),
            const SizedBox(height: 20),

            GetBuilder<SurveysController>(
              builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(5, (index) {
                    return Row(
                      children: [
                        Radio<int>(
                          value: index + 1,
                          groupValue: controller.interactionRating.value,
                          onChanged: (value) {
                            controller.interactionRating.value = value!;
                            controller
                                .update(); 
                          },
                        ),
                        Text(
                          '${index + 1}',
                          style: nunitoBold.copyWith(),
                        ),
                      ],
                    );
                  }),
                );
              },
            ),

            const SizedBox(height: 20),

            Text(
              'How would you rate the teacher’s understanding of the material?',
              style: nunitoBold.copyWith(),
            ),
            const SizedBox(height: 20),

            GetBuilder<SurveysController>(
              builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(5, (index) {
                    return Row(
                      children: [
                        Radio<int>(
                          value: index + 1,
                          groupValue: controller.understandingRating.value,
                          onChanged: (value) {
                            controller.understandingRating.value = value!;
                            controller
                                .update(); 
                          },
                        ),
                        Text(
                          '${index + 1}',
                          style: nunitoBold.copyWith(),
                        ),
                      ],
                    );
                  }),
                );
              },
            ),

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
}
