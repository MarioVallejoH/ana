import 'package:customer_app/cart/cart/controllers/cart_controller.dart';
import 'package:customer_app/cart/widgets/card_item_card.dart';
import 'package:customer_app/root/controllers/root_controller.dart';
import 'package:customer_app/services/url_resources_service.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class CartItemsList extends GetView<CartController> {
  const CartItemsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => (state?.isEmpty ?? true)
        ? _empty(context)
        : Scrollbar(
            interactive: true,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                  color: greyMediumLight,
                  thickness: 0.5,
                ).paddingSymmetric(horizontal: 16);
              },
              itemCount: state!.length,
              itemBuilder: (context, index) {
                final cartItem = state[index];
                return CartItemCard(
                    cartItem: cartItem,
                    imgUrl: UrlResourcesService.getProductImgUrl(
                        state[index].product.image));
              },
            ),
          ));
  }

  Widget _empty(BuildContext context) {
    return Center(
        child: AppButton(
      // width: double.infinity,
      elevation: 0.5,
      margin: const EdgeInsets.only(left: 14, right: 14),
      width: 0,
      height: 50,
      child: SizedBox(
        width: 190,
        child: Row(
          children: [
            Text(
              "Añadir productos",
              style: ThemeConf().titleMediumTextStile(context),
            ).paddingRight(8),
            Icon(
              Icons.add_circle_outlined,
              color: primary,
              // size: 25,
            )
          ],
        ),
      ),
      onTap: () async {
        finish(context);
        final rootController = Get.find<RootController>();
        rootController.activeTabIndex = 1;
        rootController.showBottom();
        await Future.delayed(const Duration(milliseconds: 100));
      },
    ));
  }
}
