import 'package:customer_app/cart/cart/controllers/cart_controller.dart';
import 'package:customer_app/cart/cart/screens/cart.dart';
import 'package:customer_app/root/controllers/root_controller.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/widgets/icon_w_badge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class CartStatusIcon extends GetView<CartController> {
  const CartStatusIcon({
    Key? key,
    required this.icon,
    required this.context,
  }) : super(key: key);

  final String icon;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => CartIconWBadge(
              icon,
              badgeValue: state?.length,
              withBadge: true,
              color: colorOnPColor,
              bgColor: Colors.transparent,
              onTap: () async {
                Get.find<RootController>().activeTabIndex = 3;
              },
            ),
        onError: (e) => Text(e.toString()),
        onLoading: Loader());
  }
}
