import 'package:customer_app/cart/cart/controllers/cart_controller.dart';
import 'package:customer_app/cart/models/cart_item_model.dart';
import 'package:customer_app/routes/routes.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:customer_app/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/widgets/qtty_controll_widget.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class CartItemCard extends GetView<CartController> {
  const CartItemCard({
    Key? key,
    required this.cartItem,
    required this.imgUrl,
  }) : super(key: key);

  final CartItem cartItem;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      // onUpdate: (details) {
      //   if(details.progress>0.3){

      //   }
      // },
      background: Container(
        decoration: BoxDecoration(
          color: errorColor2,
          borderRadius: BorderRadius.circular(radiusValue3),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Quitar producto',
              style: ThemeConf()
                  .buttonsSmallTextStyle(context, color: Colors.white),
            ),
            const Icon(
              Icons.delete_outline_rounded,
              size: 25,
              color: Colors.white,
            ).paddingOnly(left: 10, right: 20),
          ],
        ),
      ),
      // confirmDismiss: (direction) async {
      //   await showConfirmDialogCustom(context,
      //       dialogType: DialogType.DELETE,
      //       negativeText: 'Cancelar',
      //       title: 'Desea eliminar este producto del pedido?',
      //       positiveText: 'Eliminar',
      //       onAccept: (BuildContext context) {
      //     controller.removeProduct(cartItem.id());
      //     return true;
      //     // finish(context);
      //   }, onCancel: (BuildContext context) {
      //     return false;
      //   });
      // },
      onDismissed: (direction) {
        controller.removeProduct(cartItem.id());
        // if (controller.controller.isCompleted) {
        //   controller.controller.reset();
        // }
        Get.showSnackbar(GetSnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: errorColor2,
          // showProgressIndicator: true,
          // progressIndicatorBackgroundColor: colorOnPColor,
          // progressIndicatorValueColor:
          //     const AlwaysStoppedAnimation<Color>(errorColor2),
          // progressIndicatorController: controller.controller,
          message:
              'Se ha eliminado ${cartItem.product.name.capitalizeFirstLetter()}',
          padding: ThemeConf().snackBarPadding,
          isDismissible: true,
          mainButton: IconButton(
            onPressed: () {
              controller.addProductToCart(cartItem);
            },
            icon: Icon(
              Icons.undo_rounded,
              size: 25,
              color: colorOnPColor,
            ),
          ),
        ));
      },
      child: GestureDetector(
        onTap: () async {
          controller.selectedCartItem = cartItem;
          await Get.toNamed(Routes.editCartItem);
          controller.updateCart();
        },
        child: Container(
          decoration: BoxDecoration(
            color: backgroundPageColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(radiusValue3),
            // border: Border.all(
            //   color: greyDLight,
            // ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    cartItem.product.name,
                    style: ThemeConf()
                        .buttonsSmallTextStyle(context, fontWeightDelta: 2),
                    maxLines: 2,
                  ).expand(),
                  Icon(
                    Icons.edit,
                    color: primary,
                    size: 20,
                  )
                ],
              ).paddingOnly(bottom: 4, left: 12, right: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _productImage().paddingOnly(left: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _unitDetails(context),
                      _qttyControll(context)
                    ],
                  ).paddingLeft(10).expand(),
                ],
              )
            ],
          ).paddingSymmetric(vertical: 6),
        ),
      ),
    );
  }

  CustomImage _productImage() {
    return CustomImage(
      imgUrl,
      height: 85,
      width: 85,
      radius: radiusValue,
    );
  }

  Widget _qttyControll(BuildContext context) {
    final sum = cartItem.unitsModel?.interval ??
        cartItem.unitsModel?.operationValue ??
        1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        QttyControl(
          add: () {
            controller.addQtty(cartItem.id(), cartItem.qtty + sum);
          },
          remove: () async {
            if (cartItem.qtty - sum > 0) {
              controller.rmQtty(cartItem.id(), cartItem.qtty - sum);
            } else {
              final result = await showConfirmDialogCustom(
                context,
                dialogType: DialogType.DELETE,
                negativeText: 'Cancelar',
                title: 'Desea eliminar este producto del pedido?',
                positiveText: 'Eliminar',
                onAccept: (BuildContext context) {
                  controller.removeProduct(cartItem.id());
                  // return true;
                },
              );
              
            }
          },
          qtty: cartItem.qtty,
          buttonsSize: 33,
          elevation: 1,
        ).expand(),
        Text(
          cartItem.formatedPrice(),
          style: ThemeConf()
              .numbersTextStyle(color: primary, fontSizeFactor: 0.85),
          maxLines: 2,
        ),
      ],
    ).paddingOnly(right: 16);
  }

  

  Widget _unitDetails(BuildContext context) {
    return cartItem.unitsModel != null
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                cartItem.unitsModel!.name,
                style: ThemeConf().normalTextStyle(context),
                maxLines: 2,
              ),
            ],
          )
        : const SizedBox();
  }
}
