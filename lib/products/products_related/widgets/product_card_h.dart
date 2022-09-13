import 'package:customer_app/cart/cart/controllers/cart_controller.dart';
import 'package:customer_app/favorites/controllers/favorites_controller.dart';
import 'package:customer_app/products/products.dart';
import 'package:customer_app/products/products_related/controller/products_related_controller.dart';
import 'package:customer_app/products/products_related/utils/favorites_utils.dart';
import 'package:customer_app/services/url_resources_service.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:customer_app/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/utils/formating/data_formating.dart';
import 'package:customer_app/widgets/favorite_box.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductCardH extends StatelessWidget {
  const ProductCardH(
      {Key? key, required this.product, this.width = 300, this.onTap})
      : super(key: key);
  final ProductModel product;
  final double width;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final pCategory = Get.find<ProductsRelatedController>()
        .getProductCategory(product.categoryId);
    bool loadingFav = false;
    bool isInCart = false;

    return GestureDetector(
      onTap: onTap,
      child: Get.find<CartController>().obx((state) {
        isInCart = state
                ?.where((element) => element.product.id == product.id)
                .isNotEmpty ??
            false;

        return _pCard(isInCart, context, pCategory, loadingFav);
      }, onLoading: _pCard(isInCart, context, pCategory, loadingFav)),
    );
  }

  Widget _pCard(bool isInCart, BuildContext context,
      ProductCategoryModel? pCategory, bool loadingFav) {
    return Container(
      width: width,
      height: 128,
      // padding: EdgeInsets.symmetric(v),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusValue3),
          color: Colors.white,
          border: Border.all(
              color: (isInCart ? primary : shadowColor.withOpacity(0.1)))

          // boxShadow: [
          //   BoxShadow(
          //       color: (isInCart ? primary : shadowColor.withOpacity(0.1)),
          //       spreadRadius: 1,
          //       blurRadius: 1,
          //       blurStyle: BlurStyle.inner
          //       // changes position of shadow
          //       ),
          // ],
          ),
      child: Row(
        children: [
          CustomImage(
            UrlResourcesService.getProductImgUrl(product.image),
            radius: 0,
            height: 128,
            width: 110,
            bgColor: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(radiusValue3),
              topLeft: Radius.circular(radiusValue3),
            ),
          ),
          // const SizedBox(
          //   width: 8,
          // ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: ThemeConf().normalTextStyle(
                    context,
                    color: fontTextColor,
                    fontSizeFactor: 1.1,
                    fontWeightDelta: 2,
                  ),
                ).paddingOnly(top: 4, bottom: 4),
                Text(
                  getFormatedCurrency(product.price),
                  style: ThemeConf().numbersTextStyle(fontSizeFactor: 0.7),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: greyLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          CustomImage(
                            (pCategory?.image != null ||
                                    (pCategory?.image?.isEmpty ?? false))
                                ? UrlResourcesService.getImgUrl(
                                    pCategory?.image ?? "")
                                : "assets/images/category/salad.png",
                            isNetwork: (pCategory?.image != null ||
                                    (pCategory?.image?.isEmpty ?? false))
                                ? true
                                : false,
                            width: radiusValue3,
                            height: radiusValue3,
                          ).paddingRight(4),
                          Text(
                            pCategory?.name ?? '',
                            style: ThemeConf()
                                .smallTextStyle(context, color: greyColor),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    
                  ],
                ),
              ],
            ).paddingAll(10),
          )
        ],
      ),
    );
  }
}
