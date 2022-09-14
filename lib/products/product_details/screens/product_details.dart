// import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';

import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/cart/cart/controllers/cart_controller.dart';
import 'package:customer_app/favorites/controllers/favorites_controller.dart';
import 'package:customer_app/products/product_details/services/products_data_service.dart';
import 'package:customer_app/products/products.dart';
import 'package:customer_app/products/products_related/controller/products_related_controller.dart';
import 'package:customer_app/products/products_related/utils/favorites_utils.dart';
import 'package:customer_app/root/controllers/root_controller.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/widgets/favorite_box.dart';
import 'package:flutter/material.dart';

import 'package:customer_app/theme/color.dart';
import 'package:customer_app/utils/formating/data_formating.dart';
import 'package:customer_app/widgets/qtty_controll_widget.dart';
import 'package:customer_app/widgets/unit_card.dart';
import 'package:customer_app/widgets/prod_det_sel_sekeleton.dart';
import 'package:get/get.dart';

import 'package:nb_utils/nb_utils.dart';

import '../../../cart/models/cart_item_model.dart';
import '../../../services/url_resources_service.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/image_preview.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel product;
  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  UnitsModel? selectedUnit;

  double? selectedPrice;
  double qtty = 1;
  final _prodUnitsController = StreamController<List<UnitPrice>?>();

  final _productsDataService = ProductsDataService();
  TaxRateModel? taxRateMethod;

  bool initPrefsMap = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      List responses = await Future.wait([
        _productsDataService.findProductUnitPrices(widget.product.id,
            Get.find<AuthController>().state?.companyData?.customerGroupId,
            unitId: 0),
      ]);
      _prodUnitsController.sink.add(responses[0]);
      taxRateMethod = Get.find<ProductsRelatedController>()
          .getProductTaxRateMethod(widget.product.taxRate ?? 0);
    });
    super.initState();
  }

  @override
  void dispose() {
    _prodUnitsController.close();
    super.dispose();
  }

  Future<void> _addOrRemoveFav({bool add = true}) async {
    if (add) {
      final result = await addProductToFav(widget.product.id);
      if (result) {
        Get.find<FavoritesController>().addFavorites(widget.product);
      }
    } else {
      final result = await removeProductToFav(widget.product.id);
      if (result) {
        Get.find<FavoritesController>().removeFavorite(widget.product);
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<PreferencesCategories, List<ProductPreference>> _selectedPrefs = {};

  final ValueNotifier<int> productDescMaxLines = ValueNotifier(3);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _showBottomNavBar();

        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(slivers: [
            _appBar(),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Text(
                    widget.product.name.capitalizeFirstLetter(),
                    style: ThemeConf().titleTextStile(context,
                        color: greyDarkerColor, fontWeightDelta: 2),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ).expand(),
                  Get.find<FavoritesController>().obx((state) {
                    final isFav = state
                            ?.where(
                                (element) => element.id == widget.product.id)
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
              child: (widget.product.details != null &&
                      (widget.product.details?.isNotEmpty ?? false))
                  ? _productDetails()
                  : Container(),
            ),
            SliverToBoxAdapter(
              child: _selectionTitle(context,
                  title: 'Elige la unidad de producto'),
            ),
            SliverToBoxAdapter(
              child: _buildProductUnits(),
            ),
            
          ]),
        ),
        bottomNavigationBar: _bottomBar(context),
      ),
    );
  }

  void _showBottomNavBar() {
    Get.find<RootController>().showBottom();
  }

  Widget _productDetails() {
    return ValueListenableBuilder(
      valueListenable: productDescMaxLines,
      builder: (_, int value, child) {
        return LayoutBuilder(
          builder: (context, size) {
            // Build the textSpan
            final myText = capitalizeText(widget.product.productDetails ?? '');
            var span = TextSpan(
              text: myText,
              style: ThemeConf().normalTextStyle(context, color: greyColor),
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
                    : Container().paddingOnly(bottom: 16)
              ],
            );
          },
        );
      },
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

  SliverLayoutBuilder _appBar() {
    final imgUrl = UrlResourcesService.getProductImgUrl(widget.product.image);

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
                    capitalizeText(widget.product.name),
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
                  _showBottomNavBar();

                  finish(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.black,
                )),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: CustomImage(
              imgUrl,
              tabAble: true,
              onTap: () async {
                final pCat = Get.find<ProductsRelatedController>()
                    .getProductCategory(widget.product.categoryId);
                await ImagePreview(
                  imagePath: imgUrl,
                  isNetworkImage: true,
                  withBottom: true,
                  bottomTitle: widget.product.name,
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
    return StreamBuilder(
      stream: _prodUnitsController.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return pUnits(snapshot.data);
        } else {
          return const ProdDetSelectionSkeleton();
        }
      },
    );
  }

  Widget pUnits(List<UnitPrice>? prodUnits) {
    List<Widget> children = [];
    final unitP =
        Get.find<ProductsRelatedController>().getUnit(widget.product.unit ?? 0);
    children.add(_unitCard(unitP, widget.product.price));
    children.add(const Divider(
      height: 2,
      thickness: 1,
    ));
    if ((prodUnits ?? []).length == 1) {
      // setState(() {
      selectedUnit = unitP;
      selectedPrice = prodUnits?.first.valorUnitario;
      // });
    } else if ((prodUnits ?? []).isEmpty) {
      // setState(() {
      selectedUnit = unitP;
      selectedPrice = widget.product.price;
      // });
    }
    children.addAll(prodUnits!.map((uP) {
      final unit = Get.find<ProductsRelatedController>().getUnit(uP.unitId);

      return Column(
        children: [
          _unitCard(unit, uP.valorUnitario),
          const Divider(
            height: 2,
            thickness: 1,
          )
        ],
      );
    }).toList());
    Future.delayed(Duration.zero, () {
      setState(() {});
    });
    return Column(
      children: children,
    );
  }

  Widget _unitCard(dynamic unit, double value) {
    double priceWIva = value;
    if (widget.product.taxMethod == 1) {
      priceWIva = value + value * (taxRateMethod?.taxPercentVal ?? 0);
    }
    return UnitCard(
        onTap: () {
          setState(() {
            selectedUnit = unit;
            selectedPrice = priceWIva;
          });
        },
        value: priceWIva,
        unit: unit,
        isSelected: selectedUnit == unit);
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
              children: [_qttyControl(context), _addToCart()],
            ).paddingSymmetric(vertical: 10),
          ],
        ));
  }

  Widget _addToCart() {
    return AppButton(
      onTap: _validateSelection()
          ? () async {
              final item = CartItem(
                  price: selectedPrice!,
                  qtty: qtty,
                  unitsModel: selectedUnit,
                  product: widget.product);
              Get.find<CartController>().addProductToCart(item);
              finish(context);
            }
          : null,
      enabled: _validateSelection(),
      width: 0,
      height: 0,
      elevation: _validateSelection() ? 5 : 0,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      shapeBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
        decoration: BoxDecoration(
            color: _validateSelection() ? primary : greyDLight,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Text(
              'Agregar',
              style: ThemeConf()
                  .buttonsSmallTextStyle(context, color: colorOnPColor),
            ).paddingRight(20),
            Container(
              alignment: Alignment.centerRight,
              width: 110,
              child: Text(
                selectedUnit != null
                    ? getFormatedCurrency(selectedPrice! * qtty)
                    : getFormatedCurrency(0),
                style: ThemeConf().buttonsSmallTextStyle(context,
                    color: colorOnPColor, fontWeightDelta: 0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateSelection() {
    return selectedUnit != null;
  }

  Widget _qttyControl(BuildContext context) {
    final sum = selectedUnit?.interval ?? selectedUnit?.operationValue ?? 1;
    return QttyControl(
        add: () {
          setState(() {
            qtty += sum;
          });
        },
        remove: () {
          if (qtty - sum > 0) {
            setState(() {
              qtty -= sum;
            });
          }
        },
        enabled: _validateSelection(),
        qtty: qtty);
  }
}
