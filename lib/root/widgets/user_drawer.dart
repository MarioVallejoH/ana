import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/auth/widgets/version_no.dart';
import 'package:customer_app/root/widgets/orders_count.dart';
import 'package:customer_app/routes/routes.dart';
import 'package:customer_app/services/url_resources_service.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../theme/color.dart';
import '../../utils/formating/data_formating.dart';
import '../../widgets/custom_image.dart';

class UserDrawer extends GetView<AuthController> {
  const UserDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height - 60,
              child: Column(
                children: [
                  Container(
                      height: 132,
                      // padding: EdgeInsets.only(top: 26),
                      decoration: BoxDecoration(color: primary),
                      child: _photoNameOrders(context)),
  
                  SettingSection(
                    
                    headerPadding: EdgeInsets.zero,

                    // Optional
                    items: [
                      SettingItemWidget(
                          title: 'Mi cuenta',
                          titleTextStyle: ThemeConf()
                              .normalTextStyle(context, fontSizeFactor: 0.9),
                          decoration: BoxDecoration(borderRadius: radius()),
                          trailing: Icon(Icons.keyboard_arrow_right_rounded,
                              color: context.dividerColor),
                          leading: Icon(
                            Icons.account_circle_outlined,
                            color: primary,
                          ),
                          padding: const EdgeInsets.all(15),
                          onTap: () async {
                            final result = await Get.toNamed(Routes.user);
                            if (result ?? false) {
                              Get.showSnackbar(const GetSnackBar(
                                title: 'Éxito!',
                                duration: Duration(seconds: 2),
                                // borderColor: okColorWappsi,
                                snackStyle: SnackStyle.FLOATING,
                                backgroundColor: okColorWappsi,
                                message: 'Datos de cuenta actualizados',
                              ));
                            }
                          }),
                      const Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      SettingItemWidget(
                          title: 'Tus pedidos',
                          titleTextStyle: ThemeConf()
                              .normalTextStyle(context, fontSizeFactor: 0.9),
                          decoration: BoxDecoration(borderRadius: radius()),
                          trailing: Icon(Icons.keyboard_arrow_right_rounded,
                              color: context.dividerColor),
                          leading: Icon(
                            Icons.shopping_bag_outlined,
                            color: primary,
                          ),
                          padding: const EdgeInsets.all(15),
                          onTap: () async {
                            Get.toNamed(Routes.ordersList);
                          }),
                      const Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      SettingItemWidget(
                          title: 'Cerrar sesión',
                          titleTextStyle: ThemeConf()
                              .normalTextStyle(context, fontSizeFactor: 0.9),
                          decoration: BoxDecoration(borderRadius: radius()),
                          leading: Icon(
                            Icons.logout,
                            color: primary,
                          ),
                          padding: const EdgeInsets.all(15),
                          onTap: () async {
                            final result = await showConfirmDialogCustom(
                                context,
                                title: "¿Desea cerrar sesión?",
                                dialogType: DialogType.ACCEPT,
                                negativeText: 'Cancelar',
                                positiveText: 'Aceptar',
                                onAccept: (context) async {
                              final result =
                                  await Get.find<AuthController>().logout();

                              return result;
                              // return true;
                            });
                            if (result ?? true) {
                             
                              await Get.offAllNamed(Routes.login);
                          
                            }
                            //
                          }),
                    ],
                  ),
                ],
              ),
            ),
            const CurrentVersion()
          ],
        ),
      ),
    );
  }

  Widget _photoNameOrders(BuildContext context) {
    return controller.obx((state) => Container(
          child: Stack(
            children: [
              CustomImage(
                UrlResourcesService.getImgUrl(
                    state?.companyData?.customerProfilePhoto ?? ''),
                // 'assets/images/backgrounds/person.jpeg',
                // isNetwork: false,
                radius: 0,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.close_rounded,
                          color: colorOnPColor,
                        ).paddingRight(16).onTap(() {
                          finish(context);
                        }),
                      ],
                    ),
                    Blur(
                      width: double.infinity,
                      color: primary.withOpacity(0.5),
                      borderRadius:const BorderRadius.only(
                        topLeft: Radius.circular(radiusValue3),
                        topRight: Radius.circular(radiusValue3),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (state?.companyData?.firstName ?? '')
                                    .toCapitalize() +
                                ' ' +
                                (state?.companyData?.firstLastname ?? '')
                                    .toCapitalize(),
                            style: ThemeConf().buttonsSmallTextStyle(
                              context,
                              color: colorOnPColor,
                              fontWeightDelta: 4
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ).paddingBottom(4),
                          const OrdersCount(),
                        ],
                      ).paddingSymmetric(horizontal: 16, vertical: 8),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
