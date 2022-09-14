import 'package:customer_app/cart/cart/controllers/cart_controller.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:customer_app/utils/formating/date_to_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class DatesSelection extends GetView<CartController> {
  const DatesSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Widget> widgets = [];
      DateTime selectedDate = DateTime.now();
      for (int i = 0; i < 10; i++) {
        final buttonDate = selectedDate.add(Duration(days: i));
        final bool isSelected = parseDateStrES(buttonDate.toIso8601String()) !=
            parseDateStrES(controller.deliveryDate?.toIso8601String() ?? '');
        final choiceCard = AppButton(
          onTap: () async {
            if (isSelected) {
            }
          },
          width: 0,
          height: 0,
          shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusValue2)),
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusValue2),
                border: !isSelected ? Border.all(color: primary) : null),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            width: 100,
            height: 90,
            child: Text(
              parseDateStrESWoutYear(buttonDate.toIso8601String()),
              style: ThemeConf().normalTextStyle(context,
                  fontWeightDelta: isSelected ? 1 : 2),
              textAlign: TextAlign.center,
            ),
          ),
        );

        widgets.add(choiceCard);
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widgets,
        ),
      );
    });
  }
}
