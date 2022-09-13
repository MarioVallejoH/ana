import 'package:customer_app/routes/controllers/app_settings_controller.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class PayMethodSelected extends StatelessWidget {
  const PayMethodSelected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusValue2)),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.attach_money_rounded,
            size: 30,
          ).paddingLeft(14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forma de pago',
                style: ThemeConf().normalTextStyle(context, fontWeightDelta: 2),
              ).paddingBottom(4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const FaIcon(
                  //   FontAwesomeIcons.moneyBill,
                  //   size: 15,
                  // ).paddingRight(5),
                  Text(
                    Get.find<AppSettingsController>().state?.paymentText ?? '',
                    style:
                        ThemeConf().normalTextStyle(context, color: greyColor),
                  ).expand(),
                ],
              )
            ],
          ).paddingSymmetric(horizontal: 16).expand()
        ],
      ).paddingSymmetric(vertical: 10),
    );
  }
}
