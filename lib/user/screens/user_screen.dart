// import 'package:customer_app/services/url_resources_service.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/user/controllers/user_controller.dart';
import 'package:customer_app/user/widgets/editable_fields.dart';
import 'package:customer_app/utils/constant.dart';
// import 'package:customer_app/widgets/dialogs_alerts/cool_snackbar_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: primary,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Mi cuenta',
          style: ThemeConf().normalTextStyle(context),
        ),
        backgroundColor: appBarColor,
        leading: IconButton(
          onPressed: () {
            finish(context);
            // UiControllService.showBottomBar();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: mainColor,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                final value = await showMenu<bool>(
                    context: context,
                    position: const RelativeRect.fromLTRB(1, 0, 0, 1),
                    items: [
                      PopupMenuItem<bool>(
                        value: true,
                        child: Text(controller.editUserData
                            ? 'Cancelar editar'
                            : 'Editar'),
                      ),
                      const PopupMenuItem<bool>(
                        value: false,
                        child: Text('Salir'),
                      ),
                    ]);
                if (value == true) {
                  
                } else if (value == false) {
                  finish(context);
                }
              },
              icon: const Icon(
                Icons.more_vert_rounded,
                size: 18,
                color: labelColor,
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
                color: greyDarkerLight,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(radiusValue),
                    topRight: Radius.circular(radiusValue))),
            child: const SingleChildScrollView(
              child: EditableUserFields(),
            ),
          ).expand()
        ],
      ),
      bottomNavigationBar: Obx(() {
        return AppButton(
          color: primary,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: controller.loading ? 0 : 11),
          // shapeBorder: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(radiusValue)),
          enabled: !controller.loading,
          margin:
              const EdgeInsets.only(left: 20, right: 20, bottom: 16, top: 8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: !controller.loading
                ? Text(
                    "Guardar",
                    style: ThemeConf()
                        .normalTextStyle(context, color: colorOnPColor),
                  )
                : SizedBox(height: 38, child: Loader()),
          ),
          onTap: () async {
            controller.loading = true;
            // await Future.delayed(const Duration(seconds: 2));
            final result = await controller.saveUserChanges(context);
            controller.loading = false;

            finish(context, result);
          },
        );
      }),
    );
  }
}
