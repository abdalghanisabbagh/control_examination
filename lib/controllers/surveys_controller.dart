import 'package:get/get.dart';

class SurveysController extends GetxController {
  // استخدام خريطة لتخزين التقييمات لكل سؤال باستخدام المفتاح (السؤال نفسه)
  var ratings = <String, int>{}.obs;

  // دالة لتحديث التقييم لسؤال معين
  void updateRating(String question, int rating) {
    ratings[question] = rating;
    update(); // تحديث الواجهة عندما يتغير التصنيف
  }

  // دالة لإرسال التقييمات
  void submitRating() {
    // يمكنك الآن الوصول إلى التصنيفات لجميع الأسئلة
    print(ratings); // هنا يمكنك إرسال البيانات إلى الخادم أو حفظها حسب الحاجة

    // عرض رسالة نجاح بعد إرسال التقييمات
    Get.snackbar('Success', 'Your rating has been submitted!',
        snackPosition: SnackPosition.BOTTOM);
  }
}
