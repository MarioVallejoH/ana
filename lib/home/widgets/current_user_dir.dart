import 'package:customer_app/home/controllers/home_controller.dart';
import 'package:customer_app/routes/routes.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class CurrentUserDir extends GetView<HomeController> {
  const CurrentUserDir({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppButton(
          onTap: () async {

          },
          width: 0,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          color: primary,
          elevation: 0,
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: colorOnPColor,
                size: 20,
              ).paddingOnly(right: 3, bottom: 1),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusValue2)),
                child: Text(
                  controller.selectedAddrss?.toString2() ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: ThemeConf().normalTextStyle(context,
                      color: colorOnPColor, fontWeightDelta: 2),
                ),
              ).expand(),
              Icon(
                Icons.arrow_drop_down_rounded,
                size: 30,
                color: colorOnPColor,
              )
            ],
          ));
    });
  }
}
