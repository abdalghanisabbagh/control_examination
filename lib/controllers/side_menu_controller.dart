import 'package:get/get.dart';

/// SideMenuController is a GetX controller that is used to control the
/// side menu.
///
/// The controller has the following properties:
/// - [currentPage] is a string that contains the name of the current
///   page.
///
/// The controller has the following methods:
/// - [updatePage] is a method that is used to update the current page.
class SideMenuController extends GetxController {
  /// currentPage is a string that contains the name of the current
  /// page.
  final _currentPage = ''.obs;

  /// currentPage is a getter that returns the value of [_currentPage].
  String get currentPage => _currentPage.value;

  /// updatePage is a method that is used to update the current page.
  ///
  /// It takes a string [pageName] as an argument and sets the value of
  /// [currentPage] to it.
  void updatePage(String pageName) {
    _currentPage.value = pageName;
  }
}
