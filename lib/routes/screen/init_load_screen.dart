import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:customer_app/widgets/custom_image.dart';
import 'package:page_transition/page_transition.dart';
import 'package:customer_app/routes/controllers/app_settings_controller.dart';
import 'package:customer_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitLoading extends GetView<AppSettingsController> {
  const InitLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      return AnimatedSplashScreen.withScreenFunction(
          duration: 3000,
          splash: const CustomImage(
            'assets/images/icons/logo.png',
            isNetwork: false,
            height: 100,
            width: 100,
          ),
          splashIconSize: 100,
          screenFunction: () async {
            // await Future.delayed(const Duration(seconds: 20));
            return await _goToLogin();
          },
          splashTransition: SplashTransition.fadeTransition,
          animationDuration: const Duration(seconds: 1),
          pageTransitionType: PageTransitionType.bottomToTop,
          backgroundColor: Colors.black);
    },
        onLoading: AnimatedSplashScreen.withScreenFunction(
            duration: 3000,
            splash: const CustomImage(
              'assets/images/icons/logo.png',
              isNetwork: false,
              height: 100,
              width: 100,
            ),
            splashIconSize: 100,
            screenFunction: () async {
              return await _goToLogin(awaitOnLoading: true);
            },
            splashTransition: SplashTransition.fadeTransition,
            animationDuration: const Duration(seconds: 1),
            pageTransitionType: PageTransitionType.bottomToTop,
            backgroundColor: Colors.black));
  }

  Future<dynamic> _goToLogin({awaitOnLoading = false}) async {
    if (awaitOnLoading) {
      await Future.delayed(const Duration(seconds: 20));
      return await _goToLogin(awaitOnLoading: awaitOnLoading);
    } else {
      return await Get.toNamed(Routes.login);
    }
  }
}
