import 'package:customer_app/cart/cart/controllers/cart_controller.dart';
import 'package:customer_app/favorites/controllers/favorites_controller.dart';
import 'package:customer_app/products/products.dart';
import 'package:customer_app/products/products_related/controller/products_related_controller.dart';
import 'package:customer_app/root/controllers/root_controller.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:customer_app/utils/formating/data_formating.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../services/url_resources_service.dart';
import '../theme/color.dart';
import 'custom_image.dart';

class ProductCardSearch extends StatelessWidget {
  const ProductCardSearch(
      {Key? key,
      required this.product,
      this.width = 300,
      this.onTap,
      this.dismissible = false,
      this.onFavoriteTap})
      : super(key: key);
  final ProductModel product;
  final double width;
  final bool dismissible;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    final pCategory = Get.find<ProductsRelatedController>()
        .getProductCategory(product.categoryId);
    final imgUrl = UrlResourcesService.getProductImgUrl(pCategory?.image ?? '');
    final pimgUrl = UrlResourcesService.getProductImgUrl(product.image);
    bool isInCart = false;
    return GestureDetector(
      onTap: onTap,
      child: Get.find<CartController>().obx(
        (state) {
          isInCart = state
                  ?.where((element) => element.product.id == product.id)
                  .isNotEmpty ??
              false;
          return dismissible
              ? Dismissible(
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Quitar producto',
                          style: ThemeConf().buttonsSmallTextStyle(context,
                              color: Colors.white),
                        ),
                        const Icon(
                          Icons.delete_outline_rounded,
                          size: 25,
                          color: Colors.white,
                        ).paddingOnly(left: 10, right: 20),
                      ],
                    ),
                  ),

                  onDismissed: (direction) async {
                    final favController = Get.find<FavoritesController>();
                    await favController.removeProductToFav(product);
                    Get.find<RootController>().showBottom();
                    // if (controller.controller.isCompleted) {
                    //   controller.controller.reset();
                    // }
                    Get.showSnackbar(GetSnackBar(
                      duration: const Duration(seconds: 2),
                      backgroundColor: errorColor2,
                      message:
                          'Se ha eliminado ${product.name.capitalizeFirstLetter()}',
                      padding: ThemeConf().snackBarPadding,
                      isDismissible: true,
                      mainButton: IconButton(
                        onPressed: () async {
                          await Get.find<FavoritesController>()
                              .addProductToFav(product);
                        },
                        icon: Icon(
                          Icons.undo_rounded,
                          size: 25,
                          color: colorOnPColor,
                        ),
                      ),
                    ));
                  },
                  child: _pCard(isInCart, imgUrl, pimgUrl, context, pCategory),
                )
              : _pCard(isInCart, imgUrl, pimgUrl, context, pCategory);
        },
        onLoading: _pCard(isInCart, imgUrl, pimgUrl, context, pCategory),
      ),
    );
  }

  Container _pCard(bool isInCart, String imgUrl, String pImage,
      BuildContext context, ProductCategoryModel? pCategory) {


    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      padding: const EdgeInsets.only(left: 6, right: 8),
      decoration: BoxDecoration(
          border: Border.all(color: isInCart ? primary : greyLight),
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusValue3)),
      child: Row(
        children: [
          CustomImage(
            pImage,
            bgColor: Colors.white,
            radius: 15,
            borderRadius: BorderRadius.circular(radiusValue3),
            borderColor: Colors.transparent,
            height: 100,
          ).paddingSymmetric(vertical: 6),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        capitalizeText(product.name),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: ThemeConf().normalTextStyle(context),
                      ),
                    ),
                    
                  ],
                ),
                Text(
                  capitalizeText(product.type),
                  style: ThemeConf().smallTextStyle(context,
                      fontSizeFactor: 1.1, color: greyColor),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    CustomImage(
                      imgUrl,
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            capitalizeText(pCategory?.name ?? ''),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: textColor,
                              fontSize: 14,
                            ),
                          ),
                          // Text(
                          //   capitalizeText(pCategory?.code ?? ''),
                          //   maxLines: 1,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: const TextStyle(
                          //     color: labelColor,
                          //     fontSize: 12,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8),
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(radiusValue),
                      ),
                      child: Row(
                        children: [
                          Text(
                            getFormatedCurrency(product.price),
                            style: ThemeConf()
                                .normalTextStyle(context, color: colorOnPColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
