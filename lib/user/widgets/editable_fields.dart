import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/user/controllers/user_controller.dart';
import 'package:customer_app/widgets/editable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditableUserFields extends GetView<UserController> {
  const EditableUserFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Datos personales',
          style: ThemeConf().titleMediumTextStile(context),
        ).paddingOnly(left: 14, right: 14, bottom: 16, top: 8),
        Obx(() {
          return EditableTextFieldWButton(
            controller: controller.firstNameController,
            labelText: 'Primer nombre',
            editable: controller.editUserData,
            password: false,
          );
        }),
        const SizedBox(
          height: 10,
        ),
        Obx(() {
          return EditableTextFieldWButton(
            controller: controller.secondNameController,
            labelText: 'Segundo nombre',
            editable: controller.editUserData,
            password: false,
          );
        }),
        const SizedBox(
          height: 10,
        ),
        Obx(() {
          return EditableTextFieldWButton(
            controller: controller.firstLastnameController,
            labelText: 'Primer apellido',
            editable: controller.editUserData,
            password: false,
          );
        }),
        const SizedBox(
          height: 10,
        ),
        Obx(() {
          return EditableTextFieldWButton(
            controller: controller.secondLastnameController,
            labelText: 'Segundo apellido',
            editable: controller.editUserData,
            password: false,
          );
        }),
        // const SizedBox(
        //   height: 10,
        // ),
        // Obx(() {
        //   return EditableTextFieldWButton(
        //     controller: controller.passswordController,
        //     labelText: 'Contraseña',
        //     editable: controller.editPassword,
        //     password: false,

        //   );
        // }),
      ],
    );
  }
}
