import 'package:customer_app/cart/cart/controllers/cart_controller.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:customer_app/utils/formating/data_formating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TotalInfo extends GetView<CartController> {
  const TotalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartTotals = controller.getCartTotals();
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusValue2)),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: ThemeConf().normalTextStyle(context),
              ),
              Text(
                getFormatedCurrency(cartTotals['total'] ?? 0, decimals: 1),
                style: ThemeConf().normalTextStyle(context, fontWeightDelta: 2),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'IVA',
                style: ThemeConf().normalTextStyle(context),
              ),
              Text(
                getFormatedCurrency(cartTotals['product_tax'] ?? 0,
                    decimals: 1),
                style: ThemeConf().normalTextStyle(context, fontWeightDelta: 2),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: ThemeConf().normalTextStyle(context),
              ),
              Text(
                getFormatedCurrency(cartTotals['grand_total'] ?? 0,
                    decimals: 1),
                style: ThemeConf().normalTextStyle(context, fontWeightDelta: 2),
              ),
            ],
          ),
        ],
      ).paddingSymmetric(vertical: 10, horizontal: 16),
    );
  }
}
