import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/constants/app_constatnts.dart';
import '../../../resource_manager/validations.dart';
import '../../controllers/login_controller.dart';
import '../../routes_manger.dart';

void _login(
    Future<bool> Function(String email, String password) login,
    String username,
    String password,
    GlobalKey<FormState> formKey,
    BuildContext context) async {
  if (formKey.currentState!.validate()) {
    login(
      username,
      password,
    ).then(
      (value) {
        value
            ? {
                MyFlashBar.showSuccess(
                        'You have been logged in successfully', 'Success')
                    .show(context.mounted ? context : Get.key.currentContext!),
                Get.offAllNamed(Routes.homeScreen),
              }
            : null;
      },
    );
  }
}

class LoginForm extends GetView<LoginController> {
  final emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      onKeyEvent: (value) {
        if (value.logicalKey == LogicalKeyboardKey.enter) {
          _login(
            controller.login,
            emailController.text,
            passwordController.text,
            formKey,
            context,
          );
        }
      },
      focusNode: FocusNode()..requestFocus(),
      child: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            width: 500,
            child: IntrinsicHeight(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: GetBuilder<LoginController>(
                      init: LoginController(),
                      builder: (controller) {
                        return Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Welcome To NIS Examination Center",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Image.asset(
                                AssetsManager.assetsLogosNisLogo,
                                fit: BoxFit.fill,
                                height: 130,
                                width: 130,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "LOG IN",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const SizedBox(
                                width: 30,
                                child: Divider(
                                  color: ColorManager.bgSideMenu,
                                  thickness: 2,
                                ),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              MytextFormFiled(
                                autofillHints: const [AutofillHints.username],
                                controller: emailController,
                                myValidation: Validations.requiredValidator,
                                title: "Student Username",
                              ),
                              GetBuilder<LoginController>(
                                id: 'pass_icon',
                                builder: (_) {
                                  return MytextFormFiled(
                                    autofillHints: const [
                                      AutofillHints.password
                                    ],
                                    obscureText: controller.showPass,
                                    controller: passwordController,
                                    myValidation: Validations.requiredValidator,
                                    enableBorderColor: ColorManager.grey,
                                    title: "Password",
                                    suffixIcon: GetBuilder<LoginController>(
                                      id: 'pass_icon',
                                      builder: (_) {
                                        return IntrinsicHeight(
                                          child: IntrinsicWidth(
                                            child: IconButton(
                                              icon: AnimatedSwitcher(
                                                duration:
                                                    AppConstants.mediumDuration,
                                                transitionBuilder:
                                                    (child, animation) {
                                                  final rotateAnimation =
                                                      Tween<double>(
                                                              begin: 0.0,
                                                              end: 1.0)
                                                          .animate(animation);
                                                  final reverseAnimation =
                                                      Tween<double>(
                                                              begin: 1.0,
                                                              end: 0.0)
                                                          .animate(animation);
                                                  return RotationTransition(
                                                    turns: controller.showPass
                                                        ? rotateAnimation
                                                        : reverseAnimation,
                                                    child: FadeTransition(
                                                      opacity: animation,
                                                      child: child,
                                                    ),
                                                  );
                                                },
                                                layoutBuilder: (currentChild,
                                                    previousChildren) {
                                                  return Stack(
                                                    fit: StackFit.loose,
                                                    children: [
                                                      // Show the current child.
                                                      if (currentChild != null)
                                                        Positioned.fill(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: currentChild,
                                                          ),
                                                        ),
                                                      // Show the previous children in a stack.
                                                      ...previousChildren.map(
                                                        (child) {
                                                          return Positioned
                                                              .fill(
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child:
                                                                  IgnorePointer(
                                                                      child:
                                                                          child),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                                switchInCurve:
                                                    Curves.easeOutExpo,
                                                switchOutCurve:
                                                    Curves.easeInExpo,
                                                child: controller.showPass
                                                    ? const Icon(
                                                        key: ValueKey(1),
                                                        Icons.visibility,
                                                        color: ColorManager
                                                            .glodenColor,
                                                      )
                                                    : const Icon(
                                                        key: ValueKey(2),
                                                        Icons.visibility_off,
                                                        color: ColorManager
                                                            .glodenColor,
                                                      ),
                                              ),
                                              onPressed: () {
                                                controller.setShowPass();
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              GetBuilder<LoginController>(
                                id: 'login_button',
                                builder: (_) {
                                  return controller.isLoading
                                      ? FittedBox(
                                          child: LoadingIndicators
                                              .getLoadingIndicator(),
                                        )
                                      : SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              _login(
                                                controller.login,
                                                emailController.text,
                                                passwordController.text,
                                                formKey,
                                                context,
                                              );
                                            },
                                            child: const Text("Login"),
                                          ),
                                        );
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GetBuilder<LoginController>(
                                builder: (_) {
                                  return Text(
                                    controller.packageInfo?.version ??
                                        'getting version...',
                                    style: nunitoBlack.copyWith(
                                      fontSize: 16,
                                      color: ColorManager.grey,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
