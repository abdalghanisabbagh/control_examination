import 'package:control_examination/controllers/controllers.dart';
import 'package:control_examination/routes_manger.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configurations/constants/assets.dart';

class ExamFinishedScreen extends StatelessWidget {
  const ExamFinishedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cahechedExamMission =
        Get.find<ExamMissionController>().cachedExamMission;
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: ColorManager.primary,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    Assets.assetsLogosNIS5,
                    height: 100,
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      '${controller.cachedUserProfile?.firstName} ${controller.cachedUserProfile?.secondName} ${controller.cachedUserProfile?.thirdName}',
                      style: nunitoBold.copyWith(
                        color: ColorManager.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          '${controller.cachedUserProfile?.schoolResModel?.schoolType?.name}',
                          style: nunitoBold.copyWith(
                            color: ColorManager.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          ' ${controller.cachedUserProfile?.schoolResModel?.name}',
                          style: nunitoBold.copyWith(
                            color: ColorManager.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      '${controller.cachedUserProfile?.gradeResModel?.name}',
                      style: nunitoBold.copyWith(
                        color: ColorManager.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Spacer(),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      '${cahechedExamMission?.subjects?.name}',
                      style: nunitoBold.copyWith(
                        color: ColorManager.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Exam Finished',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.homeScreen);
                  },
                  child: const Text('Finish Exam'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
