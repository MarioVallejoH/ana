import 'package:customer_app/home/controllers/home_controller.dart';
import 'package:customer_app/products/outstanding/service/outstandings_service.dart';
import 'package:customer_app/products/products.dart';
import 'package:customer_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutstandingsController extends GetxController
    with StateMixin<List<ProductModel>?> {
  OutstandingsController({required this.service}) {
    change(null, status: RxStatus.loading());
  }
  @override
  void onInit() async {
    super.onInit();
    await reloadOutstandings(animateToTop: false);
    scrollController.addListener(infinityScrollListener);
    scrollControllerHWidget.addListener(infinityHScrollListener);
  }

  RxBool loading = false.obs;

  RxBool allLoaded = false.obs;

  final OutstandingsService service;
  final ScrollController scrollController = ScrollController();
  final ScrollController scrollControllerHWidget = ScrollController();
  int _page = 0;

  void addOutstandings(List<ProductModel> products) {
    state?.addAll(products);
    if (products.isEmpty) {
      allLoaded.value = true;
      // Get.showSnackbar(const GetSnackBar(
      //   backgroundColor: errorColor2,
      //   duration: Duration(seconds: 1),
      //   message: 'No se encontraron más productos',
      // ));
    }
    change(state, status: RxStatus.success());
  }

  Future<void> reloadOutstandings(
      {bool animateToTop = true, bool fromVWidget = true}) async {
    change([], status: RxStatus.loading());
    _page = 0;
    allLoaded.value = false;
    final products = await service.getOutstanding(
      page: _page,
      categoriesFilter:
          Get.find<HomeController>().selectedCategoriesIds() ?? [],
    );

    if (animateToTop) {
      if (fromVWidget) {
        scrollController.animateTo(0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.bounceInOut);
      } else {
        scrollControllerHWidget.animateTo(0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.bounceInOut);
      }
    }

    change(products, status: RxStatus.success());
  }

  Future<void> addOutstandingsPage() async {
    final products = await service.getOutstanding(
      page: _page,
      categoriesFilter:
          Get.find<HomeController>().selectedCategoriesIds() ?? [],
    );

    addOutstandings(products);
  }

  void infinityScrollListener() async {
    // printConsole(scrollController.position.extentAfter);
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !loading.value &&
        !allLoaded.value &&
        (state?.isNotEmpty ?? false)) {
      _page += 1;
      loading.value = true;

      loading.value = true;
      await addOutstandingsPage();

      // widget.products.clear();

      loading.value = false;
    }
  }

  void infinityHScrollListener() async {
    // printConsole(scrollController.position.extentAfter);
    if (scrollControllerHWidget.position.pixels >=
            scrollControllerHWidget.position.maxScrollExtent &&
        !loading.value &&
        !allLoaded.value &&
        (state?.isNotEmpty ?? false)) {
      _page += 1;
      loading.value = true;

      loading.value = true;
      await addOutstandingsPage();

      // widget.products.clear();

      loading.value = false;
    }
  }
}
