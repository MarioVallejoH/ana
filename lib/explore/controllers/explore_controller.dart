import 'package:customer_app/explore/services/explore_service.dart';
import 'package:customer_app/products/products.dart';
// import 'package:customer_app/root/controllers/root_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

/// Controlador para la creación de fuel
class ExploreController extends GetxController
    with StateMixin<List<ProductModel>?> {
  /// Constructor
  ExploreController({required this.service}) {
    change(null, status: RxStatus.loading());
  }

  @override
  void onInit() async {
    _scrollController.addListener(() async {
      _scrollListener();
    });

    await search();
    super.onInit();
  }

  RxList<ProductCategoryModel> selectedCategories =
      List<ProductCategoryModel>.empty(growable: true).obs;

  /// Variable para acceder al servicio
  final ExploreService service;

  final RxBool _loading = false.obs;

  final RxBool _allLoaded = false.obs;

  final RxBool _showFilters = false.obs;
  final RxBool _isAtTop = true.obs;

  final Rx<int> _currentSearchPage = 0.obs;

  final Rx<TextEditingController> _currentQuery = TextEditingController().obs;

  final _scrollController = ScrollController();

  final focusNode = FocusNode();

  final RxList<ProductModel> _products =
      (List<ProductModel>.empty(growable: true)).obs;

  Stream<List<ProductModel>?> get exploreSearchStream => _products.stream;

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

  void setExplorePage({int page = 0, bool add = false}) {
    if (add) {
      currentPage += 1;
    } else {
      currentPage = page;
    }
  }

  void addProductSearch(List<ProductModel> products) {
    _products.addAll(products);
  }

  bool isCategorySelected(ProductCategoryModel category) {
    final result = selectedCategories
        .where((element) => element.code == category.code)
        .isNotEmpty;
    return result;
  }

  List<int>? selectedCategoriesIds() {
    List<int> categoriesId = [];
    // ignore: invalid_use_of_protected_member
    for (ProductCategoryModel pCat in selectedCategories.value) {
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

  void selectExploreCategory(ProductCategoryModel category) {
    selectedCategories.add(category);
  }

  void removeExploreCategory(ProductCategoryModel category) {
    selectedCategories.removeWhere((element) => element.code == category.code);
  }

  Future<void> reloadExploreSearch() async {
    final products = await service.getAll(
        page: 0,
        query: currentQuery,
        categoriesFilter: selectedExploreCategoriesIds());

    _products.clear();
    _products.addAll(products);
    _allLoaded.value = false;
    await scrollUp();
  }

  Future<void> exploreSearchAddPage() async {
    final products = await service.getAll(
        page: currentPage,
        query: currentQuery,
        categoriesFilter: selectedCategoriesIds());
    if (products.isNotEmpty) {
      addProductSearch(products);
    } else {
      _allLoaded.value = true;
    }
  }

  Future<void> search(
      {bool refresh = false, bool fromOnRefresh = false, int? page}) async {
    if (!fromOnRefresh) {
      _loading.value = true;
    }
    if (refresh) {
      // if (!fromOnRefresh) {
      //   change([], status: RxStatus.loading());
      // }
      await reloadExploreSearch();
      await scrollUp();

      // }
    } else {
      await exploreSearchAddPage();
    }
    //search end
    if (!fromOnRefresh) {
      _loading.value = (false);
    }
  }

  Future scrollUp() async {
    scrollController.animateTo(0,
        curve: Curves.bounceOut, duration: const Duration(milliseconds: 400));
    await Future.delayed(const Duration(seconds: 1, milliseconds: 300));

    showFilters = true;
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
        setExplorePage(add: true);
        _loading.value = true;
        await search();

        // _allLoaded = true;
        _loading.value = false;
      }
    }
  }
}
