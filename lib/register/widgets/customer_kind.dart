import 'package:customer_app/routes/routes.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:customer_app/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../screens/person_regist.dart';

class CustomerKindSelection extends StatelessWidget {
  const CustomerKindSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 332,
      padding: const EdgeInsets.only(top: 8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: colorOnPColor,
          border: Border.all(color: greyDLight),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(radiusValue),
              topRight: Radius.circular(radiusValue))),
      child: Column(
        // crossAxisAlignment: ,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 3,
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
                color: greyColor, borderRadius: BorderRadius.circular(20)),
          ).paddingBottom(4),
          Text(
            "Elige tu tipo de usuario",
            textAlign: TextAlign.justify,
            style: ThemeConf().normalTextStyle(context, color: greyDarkerColor),
          ).paddingSymmetric(horizontal: 20),
          _customerKinds(context),
          _backToLogin(context),
        ],
      ),
    );
  }

  Container _backToLogin(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "¿Ya estas registrado?, ",
            style: ThemeConf().normalTextStyle(context),
          ),
          GestureDetector(
              onTap: () {
                finish(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  "Inicia sesión",
                  style: ThemeConf().normalTextStyle(context, color: primary),
                ),
              ))
        ],
      ),
    );
  }

  Column _customerKinds(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await Get.toNamed(Routes.register);

          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radiusValue)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomImage(
                  "assets/images/supermarket.png",
                  isNetwork: false,
                  height: 80,
                  width: 80,
                  bgColor: primary.withOpacity(0.01),
                ).paddingOnly(right: 10, left: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Text(
                    //   "Compras",
                    //   style: ThemeConf().buttonsTextStyle(context, color: greyDarkerColor),
                    // ),
                    Text(
                      "Persona",
                      style: ThemeConf()
                          .buttonsTextStyle(context, color: greyDarkerColor),
                    ),
                  ],
                ).paddingOnly(right: 16).expand(),
              ],
            ).paddingSymmetric(vertical: 6),
          ),
        ),
        GestureDetector(
          onTap: () async {
          },
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radiusValue)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Empresa",
                      style: ThemeConf()
                          .buttonsTextStyle(context, color: greyDarkerColor),
                    ),
                  ],
                ).paddingOnly(left: 16).expand(),
                CustomImage(
                  "assets/images/kiosk.png",
                  isNetwork: false,
                  height: 80,
                  width: 80,
                  bgColor: primary.withOpacity(0.01),
                ).paddingOnly(left: 10, right: 16),
              ],
            ).paddingSymmetric(vertical: 6),
          ),
        ),
      ],
    );
  }
}
