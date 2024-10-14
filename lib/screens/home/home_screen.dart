import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_examination/controllers/window_size_controller.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configurations/constants/assets.dart';
import '../../controllers/controllers.dart';
import '../../extensions/string_extension.dart';
import '../../models/student_exams/student_exam_res_model.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../resource_manager/ReusableWidget/show_dialogue.dart';
import '../../routes_manger.dart';
import '../../services/services.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WindowSizeController>(
      builder: (windowSizeController) {
        return GetBuilder<HomeController>(
          builder: (_) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(200),
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
                      Image.asset(
                        Assets.assetsLogosNIS5,
                        height: 100,
                        filterQuality: FilterQuality.high,
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          '${controller.userProfile?.firstName} ${controller.userProfile?.secondName} ${controller.userProfile?.thirdName}',
                          style: nunitoBold.copyWith(
                            color: ColorManager.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              '${controller.userProfile?.schoolResModel?.schoolType?.name}',
                              style: nunitoBold.copyWith(
                                color: ColorManager.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              ' ${controller.userProfile?.schoolResModel?.name}',
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
                          '${controller.userProfile?.gradeResModel?.name}',
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
              body: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      color: ColorManager.primary,
                    ),
                    child: SizedBox(
                      width: windowSizeController.windowWidth * 0.26,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              'Welcome To NIS Examination Center',
                              style: nunitoBold.copyWith(
                                color: ColorManager.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ).paddingSymmetric(horizontal: 20),
                          ),
                          const SizedBox(height: 20),
                          const Divider(),
                          GetBuilder<HomeController>(
                            id: 'exams',
                            builder: (_) {
                              if (controller.loading) {
                                return Center(
                                  child: LoadingIndicators.getLoadingIndicator(
                                    ColorManager.background,
                                  ),
                                );
                              } else {
                                if (controller.studentExams.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'No exams available',
                                      style: nunitoBold.copyWith(
                                          color: ColorManager.white),
                                    ),
                                  );
                                } else {
                                  return SizedBox(
                                    height: Get.height * 0.65,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: List.generate(
                                          controller.studentExamsResModel!
                                              .entries.length,
                                          (index) {
                                            final String controlMissionName =
                                                controller.studentExamsResModel!
                                                    .entries
                                                    .toList()[index]
                                                    .key!;
                                            List<StudentExamResModel>
                                                examsInControlMission =
                                                controller.studentExamsResModel!
                                                    .entries
                                                    .toList()[index]
                                                    .value;
                                            return DecoratedBox(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                backgroundBlendMode:
                                                    BlendMode.screen,
                                                color: ColorManager.primary,
                                              ),
                                              child: ListTile(
                                                title: Text(
                                                  controlMissionName,
                                                  style: nunitoBold.copyWith(
                                                    color: ColorManager.white,
                                                  ),
                                                ),
                                                subtitle: Column(
                                                  children: [
                                                    ...examsInControlMission
                                                        .map(
                                                      (exam) => InkWell(
                                                        onTap: () {
                                                          Get.find<
                                                                  ExamMissionController>()
                                                              .saveExamMissionToHiveBox(
                                                                  examMission: exam
                                                                      .examMission!,
                                                                  barcode: exam
                                                                      .barcode!);
                                                          if (exam.isCheating ==
                                                              1) {
                                                            MyAwesomeDialogue(
                                                              title:
                                                                  'Cheating Detected',
                                                              desc:
                                                                  'You Can Not Take This Exam',
                                                              dialogType:
                                                                  DialogType
                                                                      .error,
                                                            ).showDialogue(Get
                                                                .key
                                                                .currentContext!);
                                                          } else if (DateTime.parse(exam
                                                                      .examMission
                                                                      ?.endTime ??
                                                                  DateTime.now()
                                                                      .toString())
                                                              .isBefore(DateTime
                                                                  .now())) {
                                                            MyAwesomeDialogue(
                                                              title:
                                                                  'Exam Ended',
                                                              desc:
                                                                  'You Can Not Take This Exam',
                                                              dialogType:
                                                                  DialogType
                                                                      .error,
                                                            ).showDialogue(Get
                                                                .key
                                                                .currentContext!);
                                                          } else if (DateTime.parse(exam.examMission?.startTime ?? DateTime.now().toString())
                                                                      .difference(
                                                                          DateTime
                                                                              .now()) <=
                                                                  const Duration(
                                                                    minutes: 5,
                                                                  ) ||
                                                              DateTime.parse(
                                                                      exam.examMission?.startTime ?? DateTime.now().toString())
                                                                  .isBefore(DateTime.now())) {
                                                            Get.toNamed(Routes
                                                                .studentExamScreenQRCode);
                                                          } else if (DateTime.parse(exam.examMission?.startTime ?? DateTime.now().toString()).difference(DateTime.now()) <
                                                              const Duration(
                                                                minutes: 15,
                                                              )) {
                                                            Get.toNamed(Routes
                                                                .studentExamScreenWaiting);
                                                          } else {
                                                            MyAwesomeDialogue(
                                                              title:
                                                                  'Exam Did Not Start Yet',
                                                              desc:
                                                                  'You Can Not Take This Exam Before It Starts',
                                                              dialogType:
                                                                  DialogType
                                                                      .error,
                                                            ).showDialogue(Get
                                                                .key
                                                                .currentContext!);
                                                          }
                                                        },
                                                        child: DecoratedBox(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: exam.isCheating ==
                                                                    1
                                                                ? ColorManager
                                                                    .ornage
                                                                : exam.attendanceStatusId ==
                                                                        13
                                                                    ? ColorManager
                                                                        .green
                                                                    : DateTime.parse(exam.examMission?.endTime ?? DateTime.now().toString()).isBefore(DateTime
                                                                            .now())
                                                                        ? ColorManager
                                                                            .red
                                                                        : ColorManager
                                                                            .greyA8,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: windowSizeController
                                                                        .windowWidth *
                                                                    0.015,
                                                                height: windowSizeController
                                                                        .windowWidth *
                                                                    0.06,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  FittedBox(
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    child: Text(
                                                                      '${exam.examMission?.startTime?.dateFormat}',
                                                                      style: nunitoLight
                                                                          .copyWith(
                                                                        color: ColorManager
                                                                            .darkGrey2,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  FittedBox(
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    child: Text(
                                                                      '${exam.examMission?.startTime?.timeFormat}',
                                                                      style: nunitoLight
                                                                          .copyWith(
                                                                        color: ColorManager
                                                                            .darkGrey2,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const Spacer(),
                                                              Column(
                                                                children: [
                                                                  FittedBox(
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    child: Text(
                                                                      '${exam.examMission!.subjects?.name}',
                                                                      style: nunitoSemiBold
                                                                          .copyWith(
                                                                        color: ColorManager
                                                                            .white,
                                                                        fontSize:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  FittedBox(
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    child: Text(
                                                                      '${exam.examMission!.duration}',
                                                                      style: nunitoSemiBold
                                                                          .copyWith(
                                                                        color: ColorManager
                                                                            .white,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const Spacer(),
                                                              Column(
                                                                children: [
                                                                  FittedBox(
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    child: Text(
                                                                      '${exam.examMission?.endTime?.dateFormat}',
                                                                      style: nunitoLight
                                                                          .copyWith(
                                                                        color: ColorManager
                                                                            .darkGrey2,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  FittedBox(
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    child: Text(
                                                                      '${exam.examMission?.endTime?.timeFormat}',
                                                                      style: nunitoLight
                                                                          .copyWith(
                                                                        color: ColorManager
                                                                            .darkGrey2,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const Spacer(),
                                                            ],
                                                          ),
                                                        ),
                                                      ).paddingOnly(
                                                        top: 10,
                                                      ),
                                                    ),
                                                  ],
                                                ).paddingSymmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                              ),
                                            ).paddingSymmetric(
                                                horizontal: 10, vertical: 10);
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  await Get.find<ProfileController>()
                                      .deleteProfileFromHiveBox();
                                  await Get.find<TokenService>()
                                      .deleteTokenModelFromHiveBox();
                                  Get.delete<LoginController>(force: true);
                                  Get.delete<ExamMissionController>(
                                      force: true);
                                  Get.delete<HomeController>(force: true);
                                  Get.offAllNamed(Routes.loginRoute);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.fill,
                                      child: Text(
                                        'Logout',
                                        style: nunitoBold.copyWith(
                                          color: ColorManager.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.logout_outlined,
                                      color: ColorManager.white,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(
                                    'NIS Copyright © 2025 (${Get.find<LoginController>().packageInfo?.version ?? 'getting version...'})',
                                    style: nunitoLight.copyWith(
                                      color: ColorManager.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: double.infinity,
                    width: windowSizeController.windowWidth * 0.74,
                    child: SingleChildScrollView(
                      controller: controller.scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              Assets.assetsLogosNisLogo22,
                              width: 150,
                              filterQuality: FilterQuality.high,
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  FittedBox(
                                    fit: BoxFit.fill,
                                    child: Text(
                                      'Advanced Education \nDr. Nermien Ismail American School',
                                      textAlign: TextAlign.center,
                                      style: nunitoBold.copyWith(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  FittedBox(
                                    fit: BoxFit.fill,
                                    child: Text(
                                      'From the \nOffice of NIS Examination Center',
                                      textAlign: TextAlign.center,
                                      style: nunitoBold.copyWith(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: RichText(
                                text: TextSpan(
                                  text: 'Semi-digitized Exams Instructions ',
                                  style: nunitoBold.copyWith(
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '[',
                                      style: nunitoBold.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.newStatus,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Read carefully',
                                      style: nunitoBold.copyWith(
                                        fontSize: 16,
                                        decoration: TextDecoration.underline,
                                        color: ColorManager.newStatus,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ']',
                                      style: nunitoBold.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.newStatus,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                '1. The side-bar includes each student\'s assigned exams throughout the examination-week.',
                                style: nunitoRegular.copyWith(
                                  fontSize: 16,
                                  color: ColorManager.darkGrey2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                '2. Each exam’s information is provided for your reference. Exam\'s date and duration are always shown and reflected underneath the exam’s label',
                                style: nunitoRegular.copyWith(
                                  fontSize: 16,
                                  color: ColorManager.darkGrey2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                '3. Exams’ Colors Indication : ',
                                style: nunitoSemiBold.copyWith(
                                  fontSize: 16,
                                  color: ColorManager.darkGrey2,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 100,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    FittedBox(
                                      fit: BoxFit.fill,
                                      child: RichText(
                                        text: TextSpan(
                                          text:
                                              'a. The color of any un-attempted exam is initially  ',
                                          style: nunitoRegular.copyWith(
                                            fontSize: 16,
                                            color: ColorManager.darkGrey2,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Grey',
                                              style: nunitoRegular.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.greyA8,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    FittedBox(
                                      fit: BoxFit.fill,
                                      child: RichText(
                                        text: TextSpan(
                                          text:
                                              'b. If you missed an exam, your subject-exam will turn  ',
                                          style: nunitoRegular.copyWith(
                                            fontSize: 16,
                                            color: ColorManager.darkGrey2,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Red',
                                              style: nunitoRegular.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    FittedBox(
                                      fit: BoxFit.fill,
                                      child: RichText(
                                        text: TextSpan(
                                          text:
                                              'c. If you took an exam, your subject-exam will turn  ',
                                          style: nunitoRegular.copyWith(
                                            fontSize: 16,
                                            color: ColorManager.darkGrey2,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Green',
                                              style: nunitoRegular.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: RichText(
                                text: TextSpan(
                                  text: '4. If you ',
                                  style: nunitoRegular.copyWith(
                                    fontSize: 16,
                                    color: ColorManager.darkGrey2,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'ATTEMPTED TO CHEAT',
                                      style: nunitoBold.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.ornage,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' on any exam, your subject-exam will turn ',
                                      style: nunitoRegular.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.darkGrey2,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Orange',
                                      style: nunitoRegular.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.ornage,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' and your digital exam attempt will be cancelled immediately.',
                                      style: nunitoRegular.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.darkGrey2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                '5. Cheating attempts will happen on any of the following cases. ',
                                style: nunitoRegular.copyWith(
                                  fontSize: 16,
                                  color: ColorManager.darkGrey2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 100,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      RichText(
                                        maxLines: 3,
                                        text: TextSpan(
                                          text: 'a. ',
                                          style: nunitoRegular.copyWith(
                                            fontSize: 16,
                                            color: ColorManager.darkGrey2,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'BE WARNED!',
                                              style: nunitoBold.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.yellow,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' The following buttons are active buttons. ',
                                              style: nunitoRegular.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  'If you pressed any of them for any reason, ',
                                              style: nunitoRegular.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  'your attempt will be immediately cancelled, ',
                                              style: nunitoRegular.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  'and you will be locked outside the Examination Platform.',
                                              style: nunitoRegular.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  FittedBox(
                                    fit: BoxFit.fill,
                                    child: Text(
                                      'These buttons are: ',
                                      style: nunitoBold.copyWith(
                                        fontSize: 18,
                                        color: ColorManager.darkGrey2,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fill,
                                    child: Text(
                                      '[Print Screen, Windows, Control, Shift, F4, F5, F9, F10, F11, F12, Tab, Alt, Esc]',
                                      style: nunitoBold.copyWith(
                                        fontSize: 18,
                                        color: ColorManager.darkGrey2,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fill,
                                    child: Text(
                                      'Do Not Lock your laptop during exam.',
                                      style: nunitoBold.copyWith(
                                        fontSize: 18,
                                        color: ColorManager.darkGrey2,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 100,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      RichText(
                                        maxLines: 3,
                                        text: TextSpan(
                                          text: 'b. ',
                                          style: nunitoRegular.copyWith(
                                            fontSize: 16,
                                            color: ColorManager.darkGrey2,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'BE WARNED!',
                                              style: nunitoBold.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.yellow,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' ! Your keyboard is locked. You are only allowed to preview your exam by scrolling up ⬆ and down ⬇ the screen using your keyboard, or mouse scroll, or scroll bar',
                                              style: nunitoRegular.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' If you pressed any of them for any reason, ',
                                              style: nunitoRegular.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  'your attempt will be immediately cancelled, ',
                                              style: nunitoRegular.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  'and you will be locked outside the Examination Platform.',
                                              style: nunitoRegular.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: RichText(
                                text: TextSpan(
                                  text: '6. BE CAREFUL! ',
                                  style: nunitoSemiBold.copyWith(
                                    fontSize: 16,
                                    color: ColorManager.yellow,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          'Once the system cancels your digital attempt automatically, you will be transferred to the Principal\'s Office for an investigation and you will receive a ZERO grade.',
                                      style: nunitoRegular.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.darkGrey2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: RichText(
                                text: TextSpan(
                                  text: '7. Some programs will lead to ',
                                  style: nunitoRegular.copyWith(
                                    fontSize: 16,
                                    color: ColorManager.darkGrey2,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'not previewing ',
                                      style: nunitoSemiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.darkGrey2,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'your subject-exam, if exited; such as, The Internet Download Manager [ ',
                                      style: nunitoRegular.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.darkGrey2,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'IDM',
                                      style: nunitoSemiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.darkGrey2,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ]',
                                      style: nunitoRegular.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.darkGrey2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                '8. Before any exam, check the following: ',
                                style: nunitoRegular.copyWith(
                                  fontSize: 16,
                                  color: ColorManager.darkGrey2,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 100,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    FittedBox(
                                      fit: BoxFit.fill,
                                      child: RichText(
                                        text: TextSpan(
                                          text:
                                              'a. You are actively connected to the internet ',
                                          style: nunitoRegular.copyWith(
                                            fontSize: 16,
                                            color: ColorManager.darkGrey2,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '[WIFI]. ',
                                              style: nunitoSemiBold.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  'Open any website to double-check.',
                                              style: nunitoRegular.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    FittedBox(
                                      fit: BoxFit.fill,
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'b. Deactivate the ',
                                          style: nunitoRegular.copyWith(
                                            fontSize: 16,
                                            color: ColorManager.darkGrey2,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'VPN ',
                                              style: nunitoSemiBold.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'during any exam.',
                                              style: nunitoRegular.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    FittedBox(
                                      fit: BoxFit.fill,
                                      child: RichText(
                                        text: TextSpan(
                                          text:
                                              'c. Adjust the brightness of your screen before your ',
                                          style: nunitoRegular.copyWith(
                                            fontSize: 16,
                                            color: ColorManager.darkGrey2,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'QR code  ',
                                              style: nunitoSemiBold.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'is scanned.',
                                              style: nunitoRegular.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    FittedBox(
                                      fit: BoxFit.fill,
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'd. The ',
                                          style: nunitoRegular.copyWith(
                                            fontSize: 16,
                                            color: ColorManager.darkGrey2,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'battery level ',
                                              style: nunitoSemiBold.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'and the ',
                                              style: nunitoRegular.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'laptop charger.',
                                              style: nunitoSemiBold.copyWith(
                                                fontSize: 16,
                                                color: ColorManager.darkGrey2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      '9. If you completed your exam, and you may wish to exit the screen, click on the ',
                                  style: nunitoRegular.copyWith(
                                    fontSize: 16,
                                    color: ColorManager.darkGrey2,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'back arrow',
                                      style: nunitoSemiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.darkGrey2,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ', which will provide a  ',
                                      style: nunitoRegular.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.darkGrey2,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'pop-up message ',
                                      style: nunitoSemiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.darkGrey2,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'to confirm the action.',
                                      style: nunitoRegular.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.darkGrey2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: RichText(
                                text: TextSpan(
                                  text: '10. ',
                                  style: nunitoRegular.copyWith(
                                    fontSize: 16,
                                    color: ColorManager.darkGrey2,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'BE the CHANGE! ',
                                      style: nunitoSemiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.newStatus,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Seek the Better Version of Yourself, and fulfill the Honor Pledge at your BEST capacity!',
                                      style: nunitoRegular.copyWith(
                                        fontSize: 16,
                                        color: ColorManager.darkGrey2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topCenter,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                  '"Upon my honor, I have neither given nor received aid with this work"',
                                  style: nunitoBold.copyWith(
                                    fontSize: 16,
                                    color: ColorManager.darkGrey2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ).paddingSymmetric(horizontal: 20),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
