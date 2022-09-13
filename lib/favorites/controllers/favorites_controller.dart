import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/favorites/services/favorites_service.dart';
import 'package:customer_app/products/products.dart';
// import 'package:customer_app/root/controllers/root_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

/// Controlador para la creación de fuel
class FavoritesController extends GetxController
    with StateMixin<List<ProductModel>?> {
  /// Constructor
  FavoritesController({required this.service}) {
    change(null, status: RxStatus.loading());
  }

  @override
  void onInit() async {
    _scrollController.addListener(() async {
      _scrollListener();
    });
    super.onInit();
  }

  RxList<ProductCategoryModel> selectedCategories =
      List<ProductCategoryModel>.empty(growable: true).obs;

  /// Variable para acceder al servicio
  final FavoritesService service;

  final RxBool _loading = false.obs;

  final RxBool _allLoaded = false.obs;

  final RxBool _showFilters = false.obs;

  final RxBool _isAtTop = true.obs;

  final Rx<int> _currentSearchPage = 0.obs;

  final Rx<TextEditingController> _currentQuery = TextEditingController().obs;

  final _scrollController = ScrollController();

  final focusNode = FocusNode();

  ScrollController get scrollController => _scrollController;

  get queryController => _currentQuery.value;

  bool get loading => _loading.value;
  bool get showFilters => _showFilters.value;
  bool get isAtTop => _isAtTop.value;

  set showFilters(bool value) {
    _showFilters.value = value;
  }

  set loading(bool value) {
    _loading.value = value;
  }

  set isAtTop(bool value) {
    _isAtTop.value = value;
  }

  String get currentQuery => _currentQuery.value.text;

  set currentQuery(String value) {
    _currentQuery.value.text = value;
  }

  set currentPage(int query) {
    _currentSearchPage.value = query;
  }

  int get currentPage => _currentSearchPage.value;

  void setPage({int page = 0, bool add = false}) {
    if (add) {
      currentPage += 1;
    } else {
      currentPage = page;
    }
  }

  void addProductSearch(List<ProductModel> products) {
    List<ProductModel> _products = state ?? [];
    _products.addAll(products);
    change(_products, status: RxStatus.success());
  }

  bool isCategorySelected(ProductCategoryModel category) {
    final result = selectedCategories
        .where((element) => element.code == category.code)
        .isNotEmpty;
    return result;
  }

  List<int>? selectedCategoriesIds() {
    List<int> categoriesId = [];
    for (ProductCategoryModel pCat in selectedCategories) {
      categoriesId.add(pCat.id);
    }
    return categoriesId.isEmpty ? null : categoriesId;
  }

  List<int>? selectedExploreCategoriesIds() {
    List<int> categoriesId = [];
    for (ProductCategoryModel pCat in selectedCategories) {
      categoriesId.add(pCat.id);
    }
    return categoriesId.isEmpty ? null : categoriesId;
  }

  void selectCategory(ProductCategoryModel category) {
    selectedCategories.add(category);
  }

  void removeCategory(ProductCategoryModel category) {
    selectedCategories.removeWhere((element) => element.code == category.code);
  }

  Future<void> reloadFavorites() async {
    final products = await service.getFavorites(
        page: 0,
        query: currentQuery,
        categoriesFilter: selectedExploreCategoriesIds(),
        userId: Get.find<AuthController>().state?.id);

    // List<ProductModel> _products = [];
    // _products.addAll(products);
    _allLoaded.value = false;
    change(products,
        status: products.isEmpty ? RxStatus.empty() : RxStatus.success());
    await scrollUp();
  }

  Future<void> favoritesAddPage() async {
    final products = await service.getFavorites(
        page: currentPage,
        query: currentQuery,
        categoriesFilter: selectedCategoriesIds(),
        userId: Get.find<AuthController>().state?.id);
    if (products.isNotEmpty) {
      addProductSearch(products);
    } else {
      _allLoaded.value = true;
    }
  }

  void addFavorites(ProductModel product) {
    addProductSearch([product]);
  }

  void removeFavorite(ProductModel product) {
    List<ProductModel> _products = state ?? [];
    _products.removeWhere(
      (element) => element.id == product.id,
    );
    if (_products.isNotEmpty) {
      change(_products, status: RxStatus.success());
    } else {
      change([], status: RxStatus.empty());
    }
  }

  Future<void> addProductToFav(ProductModel product) async {
    int? userId = Get.find<AuthController>().state?.id;
    final res = await service.addFavorite(product.id, userId);
    if (res) {
      addFavorites(product);
    }
  }

  Future<void> removeProductToFav(ProductModel product) async {
    int? userId = Get.find<AuthController>().state?.id;
    // return await FavoritesService().removeFavorite(productId, userId);
    final res = await service.removeFavorite(product.id, userId);
    if (res) {
      removeFavorite(product);
    }
  }

  Future<void> search(
      {bool refresh = false, bool fromOnRefresh = false}) async {
    if (!fromOnRefresh) {
      _loading.value = true;
    }
    if (refresh) {
      if (!fromOnRefresh) {
        change([], status: RxStatus.loading());
      }
      await reloadFavorites();
      await scrollUp();

      // }
    } else {
      await favoritesAddPage();
    }
    //search end
    if (!fromOnRefresh) {
      _loading.value = (false);
    }
  }

  Future<void> loadData(int? userId) async {
    change([], status: RxStatus.loading());
    final products = await service.getFavorites(userId: userId);

    change(products,
        status: products.isEmpty ? RxStatus.empty() : RxStatus.success());
  }

  Future scrollUp() async {
    if (state?.isNotEmpty ?? false) {
      scrollController.animateTo(0,
          curve: Curves.bounceOut, duration: const Duration(milliseconds: 400));
      await Future.delayed(const Duration(seconds: 1, milliseconds: 300));
    }
    isAtTop = true;
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      // UiControllService.showBottomBar();
      // Get.find<RootController>().showBottom();
    } else if (_scrollController.position.userScrollDirection !=
        ScrollDirection.idle) {
      // UiControllService.hideBottomBar();
      // Get.find<RootController>().hideBottom();

      if (focusNode.hasFocus) {
        focusNode.unfocus();
      }
    }

    if (_scrollController.position.pixels ==
        _scrollController.position.minScrollExtent) {
      if (!isAtTop) {
        isAtTop = true;
      }
    } else {
      if (isAtTop != false) {
        isAtTop = false;
      }
    }

    _infinityScrollListener();
  }

  void _infinityScrollListener() async {
    // printConsole(_scrollController.position.extentAfter);
    if (!_allLoaded.value) {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_loading.value) {
        setPage(add: true);
        _loading.value = true;
        await search();

        _loading.value = false;
      }
    }
  }
}
