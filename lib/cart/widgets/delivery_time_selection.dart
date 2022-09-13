import 'package:customer_app/cart/cart/controllers/cart_controller.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/constant.dart';
// import 'package:customer_app/utils/formating/data_formating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class DeliveryTimeSelection extends GetView<CartController> {
  const DeliveryTimeSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Widget> widgets = [];
      for (var delivTime in controller.deliveryTimes) {
        final bool isSelected = controller.deliveryTime?.id == delivTime.id;
        final choiceCard = AppButton(
          onTap: () async {
            controller.setDeliveryTime(delivTime);
          },
          width: 0,
          height: 0,
          shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusValue2)),
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusValue2),
                border: isSelected ? Border.all(color: primary) : null
                // color: isSelected ? primary : Colors.white
                ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            width: 90,
            height: 80,
            child: Text(
              (delivTime.toString()),
              style: ThemeConf().normalTextStyle(context,
                  // color: !isSelected ? null : Colors.white,
                  fontWeightDelta: !isSelected ? 1 : 2),
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
