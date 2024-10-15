import 'package:get/get.dart';

/// SideMenuController is a GetxController that handles the state of the side menu
/// it has a variable currentPage that is an observable string
/// it has a method updatePage that updates the currentPage variable
class SideMenuController extends GetxController {
  /// the current page that is being displayed in the side menu
  /// it is an observable string
  var currentPage = ''.obs;

  /// updates the currentPage variable with the new page name
  ///
  /// this method is called when the user navigates to a new page
  void updatePage(String pageName) {
    currentPage.value = pageName;
  }
}
