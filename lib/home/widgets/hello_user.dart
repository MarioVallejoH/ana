import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelloUser extends GetView<AuthController> {
  const HelloUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Hola! ',
                  style: ThemeConf().titleTextStile(context, color: greyColor),
                ),
                TextSpan(
                  text:
                      '${controller.state?.companyData?.firstName} ${controller.state?.companyData?.firstLastname},',
                  style:
                      ThemeConf().titleTextStile(context, fontWeightDelta: 2),
                ),
              ]),
            ).paddingOnly(bottom: 8),
            // SizedBox(
            //   height: 10,
            // ),
            Text(
              '¿Que quieres comprar hoy?',
              style: ThemeConf().titleMediumTextStile(context,
                  fontSizeFactor: 1.2, color: greyColor),
            )
          ],
        ));
  }
}
