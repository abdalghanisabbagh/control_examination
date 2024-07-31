import 'package:control_examination/configurations/constants/assets.dart';
import 'package:control_examination/controllers/controllers.dart';
import 'package:control_examination/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class StudentExamWaitingScreen extends StatelessWidget {
  const StudentExamWaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Exam Waiting',
          style: nunitoSemiBold.copyWith(
            fontSize: 16,
            color: ColorManager.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorManager.primary,
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: PrettyQrView.data(
            data:
                '${Get.find<ProfileController>().cachedUserProfile?.firstName} ${Get.find<ProfileController>().cachedUserProfile?.secondName} ${Get.find<ProfileController>().cachedUserProfile?.thirdName}\n ${Get.find<ProfileController>().cachedUserProfile?.barcodesResModel?.barcodes?.first.barcode}',
            decoration: const PrettyQrDecoration(
              image: PrettyQrDecorationImage(
                image: AssetImage(
                  Assets.assetsLogosNisLogo,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
