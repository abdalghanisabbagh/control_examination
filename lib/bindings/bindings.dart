import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../controllers/student_exam/student_waiting_to_start_exam.dart';
import '../controllers/window_size_controller.dart';
import '../services/token_service.dart';

/// HomeBindings is a class that extends Bindings and is used to bind the HomeController to the GetX framework.
///
/// This class overrides the dependencies method of the Bindings class and puts an instance of HomeController into the GetX framework, with the permanent flag set to true.
/// This means that the HomeController will be initialized when the HomeBindings are initialized and will not be disposed of when the binding is removed.
class HomeBindings extends Bindings {
  /// The dependencies method of the Bindings class is overridden to put an instance of HomeController into the GetX framework, with the permanent flag set to true.
  /// The dependencies method of the Bindings class is overridden to put an instance of HomeController into the GetX framework, with the permanent flag set to true.
  /// This means that the HomeController will be initialized when the HomeBindings are initialized and will not be disposed of when the binding is removed.
  @override
  void dependencies() {
    /// Put an instance of HomeController into the GetX framework, with the permanent flag set to true.
    Get.put<HomeController>(
      HomeController(),
      permanent: true,
    );

    /// Call the dependencies method of the LoginBinding class to put all the necessary controllers into the GetX framework.
    LoginBinding().dependencies();
  }
}

/// InitialBindings is a class that extends Bindings and is used to bind the initial controllers to the GetX framework.
///
/// This class overrides the dependencies method of the Bindings class and puts the initial controllers into the GetX framework, with the permanent flag set to true.
/// This means that the initial controllers will be initialized when the InitialBindings are initialized and will not be disposed of when the binding is removed.
class InitialBindings extends Bindings {
  /// The dependencies method of the Bindings class is overridden to put the initial controllers into the GetX framework, with the permanent flag set to true.
  /// This means that the initial controllers will be initialized when the InitialBindings are initialized and will not be disposed of when the binding is removed.
  /// The dependencies method of the Bindings class is overridden to put the initial controllers into the GetX framework, with the permanent flag set to true.
  /// This means that the initial controllers will be initialized when the InitialBindings are initialized and will not be disposed of when the binding is removed.
  @override
  void dependencies() {
    /// Put an instance of TokenService into the GetX framework, with the permanent flag set to true.
    /// This is used to store the access token and refresh token in the app.
    Get.put(
      TokenService(),
      permanent: true,
    );

    /// Put an instance of ExamMissionController into the GetX framework, with the permanent flag set to true.
    /// This is used to store the exam mission data in the app.
    Get.put(
      ExamMissionController(),
      permanent: true,
    );

    /// Put an instance of ProfileController into the GetX framework, with the permanent flag set to true.
    /// This is used to store the user profile data in the app.
    Get.put<ProfileController>(
      ProfileController(),
      permanent: true,
    );

    /// Put an instance of SideMenuController into the GetX framework, with the permanent flag set to true.
    /// This is used to store the side menu data in the app.
    Get.put<SideMenuController>(
      SideMenuController(),
      permanent: true,
    );

    /// Put an instance of WindowSizeController into the GetX framework, with the permanent flag set to true.
    /// This is used to store the window size data in the app.
    Get.put<WindowSizeController>(
      WindowSizeController(),
      permanent: true,
    );
  }
}

/// LoginBinding is a class that extends Bindings and is used to bind the LoginController to the GetX framework.
///
/// This class overrides the dependencies method of the Bindings class and puts an instance of LoginController into the GetX framework, with the permanent flag set to true.
/// This means that the LoginController will be initialized when the LoginBinding are initialized and will not be disposed of when the binding is removed.
class LoginBinding extends Bindings {
  /// The dependencies method of the Bindings class is overridden to put an instance of LoginController into the GetX framework, with the permanent flag set to true.
  /// This means that the LoginController will be initialized when the LoginBinding are initialized and will not be disposed of when the binding is removed.
  @override
  void dependencies() {
    /// Put an instance of LoginController into the GetX framework, with the permanent flag set to true.
    /// This is used to handle the login functionality in the app.
    Get.put<LoginController>(
      LoginController(),
      permanent: true,
    );
  }
}

/// StudentExamBinding is a class that extends Bindings and is used to bind the StudentExamController to the GetX framework.
///
/// This class overrides the dependencies method of the Bindings class and puts an instance of StudentExamController into the GetX framework, with the permanent flag set to true.
/// This means that the StudentExamController will be initialized when the StudentExamBinding are initialized and will not be disposed of when the binding is removed.
class StudentExamBinding extends Bindings {
  /// The dependencies method of the Bindings class is overridden to put an instance of StudentExamController into the GetX framework, with the permanent flag set to true.
  /// This means that the StudentExamController will be initialized when the StudentExamBinding are initialized and will not be disposed of when the binding is removed.
  ///
  /// This class is used to bind the StudentExamController to the GetX framework.
  /// The StudentExamController is used to handle the student exam functionality in the app.
  @override
  void dependencies() {
    /// Put an instance of StudentExamController into the GetX framework, with the permanent flag set to true.
    /// This is used to handle the student exam functionality in the app.
    Get.put<StudentExamController>(
      StudentExamController(),
      permanent: true,
    );
  }
}

/// StudentInExamBinding is a class that extends Bindings and is used to bind the StudentInExamController to the GetX framework.
///
/// This class overrides the dependencies method of the Bindings class and puts an instance of StudentInExamController into the GetX framework, with the permanent flag set to true.
/// This means that the StudentInExamController will be initialized when the StudentInExamBinding are initialized and will not be disposed of when the binding is removed.
///
/// This class is used to bind the StudentInExamController to the GetX framework.
/// The StudentInExamController is used to handle the student exam functionality in the app.
class StudentInExamBinding extends Bindings {
  /// The dependencies method of the Bindings class is overridden to put an instance of StudentInExamController into the GetX framework, with the permanent flag set to true.
  /// This means that the StudentInExamController will be initialized when the StudentInExamBinding are initialized and will not be disposed of when the binding is removed.
  ///
  /// The StudentInExamController is used to handle the student exam functionality in the app.
  /// The StudentInExamController is a GetX controller that is used to handle the student exam functionality in the app.
  /// It is used to handle the student exam questions and answers, and to mark the student's answers as correct or incorrect.
  ///
  /// The StudentInExamController is a GetX lazy controller, which means that it will not be initialized until it is needed.
  /// This is done to reduce the amount of memory used by the app, and to improve the app's performance.
  @override
  void dependencies() {
    /// Put an instance of StudentInExamController into the GetX framework, with the permanent flag set to true.
    /// This means that the StudentInExamController will be initialized when the StudentInExamBinding are initialized and will not be disposed of when the binding is removed.
    ///
    /// The StudentInExamController is a GetX lazy controller, which means that it will not be initialized until it is needed.
    /// This is done to reduce the amount of memory used by the app, and to improve the app's performance.
    Get.lazyPut<StudentInExamController>(
      () => StudentInExamController(),
      fenix: true,
    );
  }
}

/// StudentWaitingToStartExamBinding is a class that extends Bindings and is used to bind the StudentWaitingToStartExamController to the GetX framework.
///
/// This class overrides the dependencies method of the Bindings class and puts an instance of StudentWaitingToStartExamController into the GetX framework, with the permanent flag set to true.
/// This means that the StudentWaitingToStartExamController will be initialized when the StudentWaitingToStartExamBinding are initialized and will not be disposed of when the binding is removed.
///
/// The StudentWaitingToStartExamController is used to handle the student waiting to start the exam functionality in the app.
/// It is used to handle the student waiting to start the exam questions and answers, and to mark the student's answers as correct or incorrect.
///
/// The StudentWaitingToStartExamController is a GetX lazy controller, which means that it will not be initialized until it is needed.
/// This is done to reduce the amount of memory used by the app, and to improve the app's performance.
class StudentWaitingToStartExamBinding extends Bindings {
  /// The dependencies method of the Bindings class is overridden to put an instance of StudentWaitingToStartExamController into the GetX framework, with the permanent flag set to true.
  /// This means that the StudentWaitingToStartExamController will be initialized when the StudentWaitingToStartExamBinding are initialized and will not be disposed of when the binding is removed.
  ///
  /// The StudentWaitingToStartExamController is a GetX lazy controller, which means that it will not be initialized until it is needed.
  /// This is done to reduce the amount of memory used by the app, and to improve the app's performance.
  @override
  void dependencies() {
    /// Put an instance of StudentWaitingToStartExamController into the GetX framework, with the permanent flag set to true.
    /// This means that the StudentWaitingToStartExamController will be initialized when the StudentWaitingToStartExamBinding are initialized and will not be disposed of when the binding is removed.
    ///
    /// The StudentWaitingToStartExamController is a GetX lazy controller, which means that it will not be initialized until it is needed.
    /// This is done to reduce the amount of memory used by the app, and to improve the app's performance.
    Get.put<StudentWaitingToStartExamController>(
      StudentWaitingToStartExamController(),
      permanent: true,
    );
  }
}

/// WebSocketBinding is a class that extends Bindings and is used to bind the WebSocketController to the GetX framework.
///
/// This class overrides the dependencies method of the Bindings class and puts an instance of WebSocketController into the GetX framework, with the fenix flag set to true.
/// This means that the WebSocketController will be initialized when the WebSocketBinding are initialized and will not be disposed of when the binding is removed.
///
/// The WebSocketController is a GetX lazy controller, which means that it will not be initialized until it is needed.
/// This is done to reduce the amount of memory used by the app, and to improve the app's performance.
class WebSocketBinding extends Bindings {
  /// The dependencies method of the Bindings class is overridden to put an instance of WebSocketController into the GetX framework, with the fenix flag set to true.
  /// This means that the WebSocketController will be initialized when the WebSocketBinding are initialized and will not be disposed of when the binding is removed.
  ///
  /// The WebSocketController is a GetX lazy controller, which means that it will not be initialized until it is needed.
  /// This is done to reduce the amount of memory used by the app, and to improve the app's performance.
  @override
  void dependencies() {
    /// Put an instance of WebSocketController into the GetX framework, with the fenix flag set to true.
    /// This means that the WebSocketController will be initialized when the WebSocketBinding are initialized and will not be disposed of when the binding is removed.
    ///
    /// The WebSocketController is a GetX lazy controller, which means that it will not be initialized until it is needed.
    /// This is done to reduce the amount of memory used by the app, and to improve the app's performance.
    Get.lazyPut<WebSocketController>(
      () => WebSocketController(),
      fenix: true,
    );
  }
}
