import 'package:get/get.dart';

class SurveysController extends GetxController {
  var interactionRating = 1.obs;
  var understandingRating = 1.obs;
  void submitRating() {
    
    Get.snackbar('Success', 'Your rating has been submitted!',
        snackPosition: SnackPosition.BOTTOM);
  }
}
