// import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/cart/cart/controllers/cart_controller.dart';
import 'package:customer_app/cart/edit_cart_item/controller/edit_cart_item_controller.dart';
import 'package:customer_app/favorites/controllers/favorites_controller.dart';
import 'package:customer_app/products/products.dart';
import 'package:customer_app/products/products_related/controller/products_related_controller.dart';
import 'package:customer_app/products/products_related/utils/favorites_utils.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:customer_app/widgets/favorite_box.dart';
import 'package:customer_app/widgets/qtty_controll_widget.dart';
import 'package:flutter/material.dart';

import 'package:customer_app/theme/color.dart';
import 'package:customer_app/utils/formating/data_formating.dart';
import 'package:customer_app/widgets/preference_card.dart';
import 'package:customer_app/widgets/unit_card.dart';
import 'package:customer_app/widgets/prod_det_sel_sekeleton.dart';
import 'package:get/get.dart';

import 'package:nb_utils/nb_utils.dart';
import '../../../services/url_resources_service.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/image_preview.dart';

// ignore: must_be_immutable
class EditCartItemScreen extends GetView<EditCartItemController> {
  EditCartItemScreen({Key? key}) : super(key: key);
  TaxRateModel? taxRateMethod;

  final productsRelatedController = Get.find<ProductsRelatedController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ValueNotifier<int> productDescMaxLines = ValueNotifier(3);

  Future<void> _addOrRemoveFav({bool add = true}) async {
    if (add) {
      final result = await addProductToFav(controller.cartItem.product.id);
      if (result) {
        Get.find<FavoritesController>()
            .addFavorites(controller.cartItem.product);
      }
    } else {
      final result = await removeProductToFav(controller.cartItem.product.id);
      if (result) {
        Get.find<FavoritesController>()
            .removeFavorite(controller.cartItem.product);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(slivers: [
          _appBar(),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Text(
                  controller.cartItem.product.name.capitalizeFirstLetter(),
                  style: ThemeConf().titleTextStile(context,
                      color: greyDarkerColor, fontWeightDelta: 2),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ).expand(),
                Get.find<FavoritesController>().obx((state) {
                  final isFav = state
                          ?.where((element) =>
                              element.id == controller.cartItem.product.id)
                          .isNotEmpty ??
                      false;
                  return FavoriteBox(
                    isFavorite: isFav,
                    size: 30,
                    // padding: 10,
                    onTap: () async {
                      await _addOrRemoveFav(add: !isFav);
                    },
                  ).paddingOnly(right: 5, top: 5);
                },
                    onEmpty: FavoriteBox(
                        isFavorite: false,
                        size: 30,
                        // padding: 8,
                        onTap: () async {
                          await _addOrRemoveFav(add: true);
                        }).paddingOnly(right: 5, top: 5))
              ],
            ).paddingSymmetric(horizontal: 16, vertical: 16),
          ),
          SliverToBoxAdapter(
            child: (controller.cartItem.product.details != null &&
                    (controller.cartItem.product.details?.isNotEmpty ?? false))
                ? _productDetails()
                : Container(),
          ),
          SliverToBoxAdapter(
            child:
                _selectionTitle(context, title: 'Elige la unidad de producto'),
          ),
          SliverToBoxAdapter(
            child: _buildProductUnits(),
          ),
          SliverToBoxAdapter(
            child: _buildProductPrefs(context),
          ),
        ]),
      ),
      bottomNavigationBar: _bottomBar(context),
    );
  }

  Container _selectionTitle(BuildContext context,
      {String? title, List<String?>? subtitle, EdgeInsets? padding}) {
    return Container(
      decoration: BoxDecoration(color: greyLight),
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            capitalizeText(title ?? ''),
            style: ThemeConf().normalTextStyle(context, color: greyDarkerColor),
            // textAlign: TextAlign.start,
          ).paddingBottom(4),
          subtitle != null && subtitle.isNotEmpty
              ? RichText(
                  text: TextSpan(children: [
                  TextSpan(
                      text: subtitle[0] ?? '',
                      style: ThemeConf().normalTextStyle(context,
                          fontWeightDelta: 2, fontSizeFactor: 0.9)),
                  TextSpan(
                      text: subtitle[1] ?? '',
                      style: ThemeConf()
                          .normalTextStyle(context, fontSizeFactor: 0.9)),
                  TextSpan(
                      text: subtitle[2] ?? '',
                      style: ThemeConf().normalTextStyle(context,
                          fontWeightDelta: 2, fontSizeFactor: 0.9)),
                ]))
              : Container()
          // ? Text(
          //     capitalizeText(subtitle),
          //     style: ThemeConf().normalTextStyle(context, color: greyDarkerColor),
          //   )
          //
        ],
      ).paddingSymmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _productDetails() {
    return ValueListenableBuilder(
      valueListenable: productDescMaxLines,
      builder: (_, int value, child) {
        return LayoutBuilder(
          builder: (context, size) {
            // Build the textSpan
            final myText =
                capitalizeText(controller.cartItem.product.productDetails ?? '')
                    .capitalizeFirst;
            var span = TextSpan(
              text: myText,
              style: ThemeConf().normalTextStyle(context),
            );

            // Use a textPainter to determine if it will exceed max lines
            var tp = TextPainter(
              maxLines: value,
              textAlign: TextAlign.justify,
              textDirection: TextDirection.ltr,
              text: span,
            );

            // trigger it to layout
            tp.layout(maxWidth: size.maxWidth);

            // whether the text overflowed or not
            var exceeded = tp.didExceedMaxLines;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(
                  span,
                  maxLines: value,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                ).paddingOnly(left: 16, right: 16),
                exceeded
                    ? TextButton(
                        onPressed: () {
                          productDescMaxLines.value = value + 5;
                        },
                        child: Text(
                          'Ver más',
                          style: ThemeConf()
                              .normalTextStyle(context, color: primary),
                        )).paddingOnly(bottom: 4)
                    : Container(
                        padding: const EdgeInsets.only(bottom: 16),
                      )
              ],
            );
          },
        );
      },
    );
  }

  SliverLayoutBuilder _appBar() {
    final imgUrl =
        UrlResourcesService.getProductImgUrl(controller.cartItem.product.image);

    return SliverLayoutBuilder(builder: (BuildContext context, constraints) {
      return SliverAppBar(
          expandedHeight: 250,
          forceElevated: true,
          floating: true,
          pinned: true,
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.5,
          title: !(constraints.scrollOffset > 150)
              ? null
              : Container(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Text(
                    capitalizeText(controller.cartItem.product.name),
                    style: ThemeConf()
                        .appBarTextStyle(context, fontSizeFactor: 0.75),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
          // collapsedHeight: 100,
          leading: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
                color: !(constraints.scrollOffset > 150) ? Colors.white : null,
                borderRadius: BorderRadius.circular(30)),
            child: IconButton(
                onPressed: () {
                  // CartService.updateCartStream();

                  // UiControllService.showBottomBar();
                  finish(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.black,
                )),
          ),
          actions: [
            Get.find<FavoritesController>().obx((state) {
              final isFav = state
                      ?.where((element) =>
                          element.id == controller.cartItem.product.id)
                      .isNotEmpty ??
                  false;
              return IconButton(
                  onPressed: () async {
                    final value = await showMenu<bool>(
                        context: context,
                        position: const RelativeRect.fromLTRB(1, 0, 0, 1),
                        items: [
                          PopupMenuItem<bool>(
                            value: true,
                            child: Text(isFav
                                ? 'Eliminar favorito'
                                : 'Añadir a favoritos'),
                          ),
                          const PopupMenuItem<bool>(
                            value: false,
                            child: Text('Salir'),
                          ),
                        ]);
                    if (value == true) {
                      await _addOrRemoveFav(add: !isFav);
                    } else if (value == false) {
                      finish(context);
                    }
                  },
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    size: 18,
                    color: labelColor,
                  ));
            },
                onEmpty: FavoriteBox(
                    isFavorite: false,
                    size: 30,
                    // padding: 8,
                    onTap: () async {
                      await _addOrRemoveFav(add: true);
                    })).paddingOnly(right: 5, top: 5, bottom: 5, left: 10)
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: CustomImage(
              imgUrl,
              tabAble: true,
              onTap: () async {
                final pCat = productsRelatedController
                    .getProductCategory(controller.cartItem.product.categoryId);
                await ImagePreview(
                  imagePath: imgUrl,
                  isNetworkImage: true,
                  withBottom: true,
                  bottomTitle: controller.cartItem.product.name,
                  bottomSubtitle: pCat?.name,
                ).launch(_scaffoldKey.currentContext ?? context,
                    duration: const Duration(milliseconds: 350),
                    pageRouteAnimation: PageRouteAnimation.Fade);
              },
              radius: 0,
              isNetwork: true,
            ),
          ));
    });
  }

  Widget _buildProductUnits() {
    return controller.obx(
        (state) => Obx(() {
              return pUnits(controller.unitPrices);
            }),
        onLoading: const ProdDetSelectionSkeleton());
  }

  Widget pUnits(List<UnitPrice>? prodUnits) {
    List<Widget> children = [];
    final unitP = productsRelatedController
        .getUnit(controller.cartItem.product.unit ?? 0);
    children.add(_unitCard(unitP!, controller.cartItem.product.price));
    children.add(const Divider(
      height: 2,
      thickness: 1,
    ));
    children.addAll(prodUnits!.map((uP) {
      final unit = productsRelatedController.getUnit(uP.unitId);

      return Column(
        children: [
          _unitCard(unit!, uP.valorUnitario),
          const Divider(
            height: 2,
            thickness: 1,
          )
        ],
      );
    }).toList());

    return Column(
      children: children,
    );
  }

  Widget _buildProductPrefs(BuildContext context) {
    return controller.obx(
        (state) => controller.productPreferences.isEmpty
            ? Container()
            : Obx(() {
                return pPrefs(context, controller.productPreferences);
              }),
        onLoading: const ProdDetSelectionSkeleton());
  }

  Widget pPrefs(
      BuildContext context, Map<int, List<ProductPreference>>? pPreferences) {
    List<Widget> children = [];

    pPreferences!.forEach((key, pP) {
      final prefCat = productsRelatedController.getPrefCategory(key);
      if (prefCat != null) {
        if (controller.preferences[prefCat]?.isEmpty ?? true) {
          controller.preferences[prefCat] =
              List<ProductPreference>.empty(growable: true);
        }
      }
      List<String?> subtitlePrefCat = ['', '', ''];
      if ((prefCat?.required == 1)) {
        subtitlePrefCat[0] = ('Requerido, ');
      } else {
        subtitlePrefCat[1] = ('Opcional, ');
      }
      if (prefCat?.selectionLimit != null) {
        subtitlePrefCat[1] = ('(Máximo ${prefCat?.selectionLimit})');
      } else {
        subtitlePrefCat[1] = (null);
      }

      children.add(_selectionTitle(context,
          title: prefCat?.name,
          subtitle: subtitlePrefCat,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10)));
      for (ProductPreference pPref in pP) {
        bool isSelected = controller.preferences[prefCat]
                ?.where((element) => (element.id == pPref.id))
                .isNotEmpty ??
            false;

        children.add(Column(
          children: [
            PreferenceCard(
                onTap: () {
                  if (controller.preferences[prefCat] == null) {
                    if (prefCat != null) {
                      controller.preferences[prefCat] = [];
                    }
                  }
                  if (controller.preferences[prefCat]!
                      .where((element) => element.id == pPref.id)
                      .isEmpty) {
                    // print('here');
                    if ((prefCat?.selectionLimit ?? 99) >
                        controller.preferences[prefCat]!.length) {
                      controller.addPreference(prefCat!, pPref);
                    } else {
                      controller.removePreferenceByIndex(prefCat!, 0);
                      controller.addPreference(prefCat, pPref);
                    }
                  } else {
                    controller.removePreference(prefCat!, pPref);
                  }
                },
                prodPref: pPref,
                isSelected: isSelected),
            const Divider(
              height: 2,
              thickness: 1,
            )
          ],
        ));
      }
    });

    return Column(
      children: children,
    );
  }

  Widget _unitCard(UnitsModel unit, double value) {
    double priceWIva = value;
    if (controller.cartItem.product.taxMethod == 1) {
      priceWIva = value + value * (taxRateMethod?.taxPercentVal ?? 0);
    }
    return UnitCard(
        onTap: () {
          controller.selectedUnit = unit;
          controller.price = priceWIva;
        },
        value: priceWIva,
        unit: unit,
        isSelected: controller.selectedUnit == unit);
  }

  Widget _bottomBar(BuildContext context) {
    return SizedBox(
        height: 70,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(thickness: 0.4, color: greyDarkerColor, height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [_qttyControl(context), total(context)],
            ).paddingSymmetric(vertical: 10),
          ],
        ));
  }

  Widget total(BuildContext context) {
    return AppButton(
      onTap: () {
        finish(context);
      },
      color: primary,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
      shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusValue2)),
      elevation: 1,
      child: Row(
        children: [
          Text(
            'Aceptar',
            style: ThemeConf().titleMediumTextStile(context,
                fontWeightDelta: 2, color: colorOnPColor),
          ).paddingRight(16),
          Obx(() {
            return Container(
              alignment: Alignment.centerRight,
              width: 110,
              child: Text(
                controller.cartItem.unitsModel != null
                    ? getFormatedCurrency(
                        controller.price * controller.quantity)
                    : getFormatedCurrency(0),
                style: ThemeConf().buttonsSmallTextStyle(
                  context,
                  color: colorOnPColor,
                  fontWeightDelta: 2,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  bool _validateSelection() {
    return controller.cartItem.unitsModel != null;
  }

  Widget _qttyControl(BuildContext context) {
    final sum = controller.selectedUnit?.interval ??
        controller.selectedUnit?.operationValue ??
        1;
    return Obx(() {
      return QttyControl(
          add: () {
            controller.quantity += sum;
          },
          remove: () {
            if (controller.quantity - sum <= 0) {
              showConfirmDialogCustom(context,
                  dialogType: DialogType.DELETE,
                  negativeText: 'Cancelar',
                  title: 'Desea eliminar este producto del pedido?',
                  positiveText: 'Eliminar', onAccept: (BuildContext context) {
                Get.find<CartController>().removeProduct(
                  controller.cartItem.id(),
                );
                finish(context);
              });
            } else {
              controller.quantity -= sum;
            }
          },
          enabled: _validateSelection(),
          qtty: controller.quantity);
    });
  }
}
