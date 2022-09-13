import 'package:customer_app/register/widgets/customer_kind.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:customer_app/widgets/custom_round_text_form.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: implementation_imports

import '../controller/auth_controller.dart';
import '../../theme/color.dart';
import '../../widgets/dialogs_alerts/cool_snackbar_dialog.dart';
// import 'package:flutter/services.dart';

class LoginFormInputs extends GetView<AuthController> {
  const LoginFormInputs({
    Key? key,
  }) : super(key: key);

  Widget password(BuildContext context) {
    return CustomRoundTextForm(
      // controller: TextEditingController(), // Optional
      // textFieldType: TextFieldType.PASSWORD,
      // isPassword: true,
      // focus: passwordFocusNode,
      maxLines: 1,
      focus: controller.passwordFocusNode,
      obscureText: true,
      controller: controller.passwordController,
      // initialValue: controller.password,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),

      validator: MultiValidator([
        RequiredValidator(errorText: "* Campo requerido"),
        MinLengthValidator(6,
            errorText: "La contraseña debe tener al menos 6 caracteres"),
        MaxLengthValidator(15,
            errorText: "La contraseña debe tener máximo 15 caracteres")
      ]),
      keyboardType: TextInputType.visiblePassword,
      // onChanged: (value) {
      //   controller.password = value;
      // },
      onFieldSubmitted: (_) {
        controller.loading
            // ignore: unnecessary_statements
            ? null
            : _login(context);
        controller.passwordFocusNode.unfocus();
      },
      hint: 'Contraseña',
      suffix: const Icon(Icons.key),
    );
  }

  Widget userName() {
    return CustomRoundTextForm(
      // textFieldType: TextFieldType.USERNAME,
      // focus: userFocusNode,
      controller: controller.unameController,
      focus: controller.userFocusNode,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      // controller: TextEditingController(),
      keyboardType: TextInputType.emailAddress,
      // initialValue: controller.uname,
      // style: Theme.of(context).textTheme.subtitle1,
      // nextFocus: passwordFocusNode,

      validator: MultiValidator([
        RequiredValidator(errorText: "* Campo requerido"),
        // emailValidator(errorText: "Ingresa un correo electrónico valido"),
      ]),
      // onChanged: (value) {
      //   controller.uname = value;
      // },
      onFieldSubmitted: (_) {
        controller.passwordFocusNode.requestFocus();
      },
      hint: "Nombre de usuario",
      suffix: const Icon(Icons.person),
    );
  }

  Widget loginButton(BuildContext context) {
    return Obx(() {
      return AppButton(
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: controller.loading ? 2 : 11),
          // shapeBorder: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(radiusValue)),
          width: double.infinity,
          color: primary,
          enabled: !controller.loading,
          child: controller.loading
              ? Loader()
              : Text(
                  'Iniciar sesión',
                  style: ThemeConf().normalTextStyle(context,
                      color: colorOnPColor, fontWeightDelta: 2),
                ),
          onTap: controller.loading ? null : () => _login(context));
    });
  }

  Widget registerButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
          color: colorOnPColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(radiusValue2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "¿No tienes una cuenta?, ",
            style: ThemeConf().normalTextStyle(context),
          ),
          GestureDetector(
              onTap: () async {
                final authController = Get.find<AuthController>()
                  ..passwordFocusNode.unfocus()
                  ..userFocusNode.unfocus();
                showBottomSheet<Map<String, dynamic>?>(
                    // backgroundColor: Colors.grey.withOpacity(0.),
                    // to make selection of product unit required
                    // useRootNavigator: false,
                    context: context,
                    builder: (context) {
                      return const CustomerKindSelection();
                    });
                // await const CustomerKindSelection().launch(context,
                //     duration: const Duration(milliseconds: 300),
                //     pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  "Regístrate",
                  style: ThemeConf().normalTextStyle(context, color: primary),
                ),
              ))
        ],
      ),
    );
  }

  _login(
    BuildContext context,
  ) async {
    controller.userFocusNode.unfocus();
    controller.passwordFocusNode.unfocus();
    if (controller.isValidForm()) {
      // hide keyboard

      // disable login button
      // setState(() {
      controller.isLoading = true;
      // });
      final res = await controller.login(context);
      if (res) {
        await Future.delayed(const Duration(milliseconds: 200));
        // setState(() {
        controller.isLoading = false;
        // });
      } else {
        // setState(() {
        controller.isLoading = false;
        // });
        String title = 'Ha ocurrido un error.';
        String subtitle = 'Nombre de usuario o contraseña incorrectos.';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 3),
          content: CustomSnackBarContent(
            title: title,
            subtitle: subtitle,
            bgColor: errorColor2,
            // onlyTitle: true,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
      }

      // hide loading snackbar

    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        userName().paddingBottom(14),
        password(context).paddingBottom(20),
        loginButton(context).paddingBottom(8),
        registerButton(context)
      ],
    );
  }
}
