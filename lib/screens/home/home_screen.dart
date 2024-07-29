import 'package:control_examination/configurations/constants/assets.dart';
import 'package:control_examination/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              ),
              const Spacer(
                flex: 2,
              ),
              FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  "Student Name",
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
                  'Grade',
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
                  'School',
                  style: nunitoBold.copyWith(
                    color: ColorManager.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
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
              width: Get.width * 0.26,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Welcome To NIS Examination Center',
                    style: nunitoBold.copyWith(
                      color: ColorManager.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: Get.height * 0.65,
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          10,
                          (index) => DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: index == 2
                                  ? ColorManager.greyA8
                                  : ColorManager.red,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Get.width * 0.015,
                                  height: Get.width * 0.06,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '2024/06/24',
                                      style: nunitoLight.copyWith(
                                        color: ColorManager.darkGrey2,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '11:30',
                                      style: nunitoLight.copyWith(
                                        color: ColorManager.darkGrey2,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      'Engilsh',
                                      style: nunitoSemiBold.copyWith(
                                        color: ColorManager.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '70 Minutes',
                                      style: nunitoSemiBold.copyWith(
                                        color: ColorManager.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      '2024/06/24',
                                      style: nunitoLight.copyWith(
                                        color: ColorManager.darkGrey2,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '11:30',
                                      style: nunitoLight.copyWith(
                                        color: ColorManager.darkGrey2,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ).paddingSymmetric(horizontal: 10, vertical: 10),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Logout',
                        style: nunitoBold.copyWith(
                          color: ColorManager.white,
                          fontSize: 16,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.logout_outlined,
                          color: ColorManager.white,
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
            width: Get.width * 0.74,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    Assets.assetsLogosNIS5,
                    width: 100,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Text(
                          'Advanced Education \nDr. Nermien Ismail American School',
                          textAlign: TextAlign.center,
                          style: nunitoBold.copyWith(
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'From the \nOffice of NIS Examination Center',
                          textAlign: TextAlign.center,
                          style: nunitoBold.copyWith(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
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
                  const SizedBox(height: 20),
                  Text(
                    '1. The side-bar includes each student\'s assigned exams throughout the examination-week.',
                    style: nunitoRegular.copyWith(
                      fontSize: 16,
                      color: ColorManager.darkGrey2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '2. Each exam’s information is provided for your reference. Exam\'s date and duration are always shown and reflected underneath the exam’s label',
                    style: nunitoRegular.copyWith(
                      fontSize: 16,
                      color: ColorManager.darkGrey2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '3. Exams’ Colors Indication : ',
                    style: nunitoSemiBold.copyWith(
                      fontSize: 16,
                      color: ColorManager.darkGrey2,
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
                          RichText(
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
                          const SizedBox(height: 5),
                          RichText(
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
                          const SizedBox(height: 5),
                          RichText(
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
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  RichText(
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
                          text: ' on any exam, your subject-exam will turn ',
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
                  const SizedBox(height: 10),
                  Text(
                    '5. Cheating attempts will happen on any of the following cases. ',
                    style: nunitoRegular.copyWith(
                      fontSize: 16,
                      color: ColorManager.darkGrey2,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                        Text(
                          'These buttons are: ',
                          style: nunitoBold.copyWith(
                            fontSize: 18,
                            color: ColorManager.darkGrey2,
                          ),
                        ),
                        Text(
                          '[Print Screen, Windows, Control, Shift, F4, F5, F9, F10, F11, F12, Tab, Alt, Esc]',
                          style: nunitoBold.copyWith(
                            fontSize: 18,
                            color: ColorManager.darkGrey2,
                          ),
                        ),
                        Text(
                          'Do Not Lock your laptop during exam.',
                          style: nunitoBold.copyWith(
                            fontSize: 18,
                            color: ColorManager.darkGrey2,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ).paddingSymmetric(horizontal: 20),
          ),
        ],
      ),
    );
  }
}
