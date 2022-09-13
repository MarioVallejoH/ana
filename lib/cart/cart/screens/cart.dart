import 'package:customer_app/cart/cart/controllers/cart_controller.dart';
import 'package:customer_app/cart/cart/widgets/cart_items_list.dart';
import 'package:customer_app/cart/cart/screens/order_pay_and_details_selection.dart';
import 'package:customer_app/root/controllers/root_controller.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/widgets/indexed_stacks/fade_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nb_utils/nb_utils.dart';

import '../../../theme/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/formating/data_formating.dart';
import '../../../widgets/dialogs_alerts/cool_snackbar_dialog.dart';

class Cart extends GetView<CartController> {
  Cart({Key? key}) : super(key: key);

  final ValueNotifier<int> _index = ValueNotifier(0);
  // final ValueNotifier<bool> _creatingOrder = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: CustomScrollView(
        slivers: [
          _appBar(context),
          SliverFillRemaining(
              child: ValueListenableBuilder<int>(
            valueListenable: _index,
            builder: (context, value, child) {
              return FadeIndexedStack(
                  index: value,
                  children: const [CartItemsList(), OrderPayAndOther()]);
            },
          )),
        ],
      ),
      bottomNavigationBar: _bottom(context),
    );
  }

  Widget _bottom(BuildContext context) {
    final rootController = Get.find<RootController>();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 80,
      decoration: BoxDecoration(
          color: appBgColor,
          border: Border(
            top: BorderSide(width: 1.0, color: greyDLight),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          controller.obx((state) {
            return AppButton(
              onTap: () async {
                if (_index.value == 1) {
                  if (controller.orderDetailsFormKey.currentState?.validate() ??
                      false) {
                    controller.creatingOrder = true;
                    // await Future.delayed(Duration(seconds: 5));
                    final result = await controller.createOrder();
                    String title = 'Ha ocurrido un error';
                    String subtitle =
                        'No se ha podido crear la orden de pedido.';
                    bool onlyTitle = false;

                    if (result['success'] ?? false) {
                      onlyTitle = true;
                      title = 'Orden de pedido creada exitosamente';
                      showSnackBar(context, title, onlyTitle, okColorWappsi,
                          imageDir: 'assets/images/icons/tick.png');
                      await controller.deleteCurrentCart();
                      await controller.removeSavedCart();

                      rootController.activeTabIndex = 0;
                      // rootController.showBottom();
                      controller.creatingOrder = false;

                      finish(context);
                    } else {
                      controller.creatingOrder = false;
                      showSnackBar(
                        context,
                        result["message"] ?? title,
                        result["only_title"] ?? onlyTitle,
                        errorColor,
                        subtitle: result["subtitle"],
                      );
                    }
                  }
                } else {
                  _index.value += 1;
                  await controller.getNewDeliveryTimes();
                }
              },
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radiusValue)),
              padding: EdgeInsets.zero,
              child: controller.obx(
                (state) => Container(
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusValue),
                      color: primary),
                  width: double.infinity,
                  padding: controller.creatingOrder
                      ? const EdgeInsets.symmetric(horizontal: 20, vertical: 6)
                      : const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 11),
                  child: controller.creatingOrder
                      ? Loader(
                          size: 35,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Realizar pedido por ',
                                style: ThemeConf().normalTextStyle(context,
                                    color: colorOnPColor)),
                            Text(getFormatedCurrency(controller.getCartTotal()),
                                style: ThemeConf()
                                    .numbersTextStyle(color: colorOnPColor))
                          ],
                        ).paddingSymmetric(horizontal: 16),
                ),
              ),
            );
          }),
        ],
      ).paddingSymmetric(horizontal: 16, vertical: 6),
    );
  }

  void showSnackBar(
      BuildContext context, String title, bool onlyTitle, Color color,
      {String? subtitle, String? imageDir}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: CustomSnackBarContent(
        title: title,
        subtitle: subtitle ?? '',
        bgColor: color,
        onlyTitle: onlyTitle,
        assetImageDir: imageDir,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  SliverAppBar _appBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: appBarColor,
      pinned: true,
      leading: ValueListenableBuilder(
        valueListenable: _index,
        builder: (context, value, child) {
          if (value == 0) {
            return Container();
          }
          return IconButton(
            onPressed: () {
              if (value == 0) {
                // UiControllService.goToPage(0);
                // UiControllService.showBottomBar();
                finish(context);
              } else {
                _index.value -= 1;
              }
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: mainColor,
          );
        },
      ),
      title: Text(
        'Carrito de compra',
        style: ThemeConf().normalTextStyle(context),
      ),
      // forceElevated: true,
      elevation: 2,
      // leadingWidth: 0,
      // scrolledUnderElevation: 2,
      primary: true,
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () async {
            await showConfirmDialogCustom(context,
                dialogType: DialogType.DELETE,
                negativeText: 'Cancelar',
                title: 'Desea vaciar el carrito?',
                positiveText: 'Vaciar', onAccept: (BuildContext context) async {
              await controller.deleteCurrentCart();
              await controller.removeSavedCart();

              finish(context);
            });
          },
          icon: const Icon(
            Icons.delete_forever_outlined,
            size: 30,
            color: deleteColor,
          ),
          color: mainColor,
        )
      ],
    );
  }
}
