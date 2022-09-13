import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/auth/widgets/login_form.dart';
import 'package:customer_app/auth/widgets/version_no.dart';
import 'package:customer_app/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends GetView<AuthController> {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      // extendBody: true,
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: controller.obx(
          (state) {
            if (state != null) {
              return const Center(
                child: CustomImage(
                  "assets/images/icons/loading.gif",
                  isNetwork: false,
                  width: 200,
                  height: 100,
                ),
              );
            }
            return Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Column(
                    children: [
                      const CustomImage(
                        'assets/images/icons/logo.png',
                        width: 160,
                        height: 160,
                        isNetwork: false,
                        bgColor: Colors.transparent,
                        isShadow: false,
                      ).paddingOnly(bottom: 60, right: 25),
                      // const SizedBox(
                      //   width: 160,
                      //   height: 160,
                      // ).paddingOnly(bottom: 40, right: 25),
                      
                      const LoginFormInputs(),
                    ],
                  ),
                  // const Spacer(),
                  
                  Center(
                    child: const CurrentVersion()
                        .paddingSymmetric(horizontal: 16, vertical: 16),
                  )
                ],
              ).paddingSymmetric(horizontal: 8),
            );
          },
          onLoading: const Center(
            child: CustomImage(
              "assets/images/icons/loading.gif",
              isNetwork: false,
              width: 200,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
