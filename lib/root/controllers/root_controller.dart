import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/root/services/rooot_page_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controlador para la creación de fuel
class RootController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RootController({required this.service});

  final Duration duration = const Duration(milliseconds: 300);

  late AnimationController animationController;
  @override
  void onInit() async {
    super.onInit();
    animationController = AnimationController(vsync: this, duration: duration);
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.stop();
    animationController.dispose();
    super.onClose();
  }

  /// Constructor
  final RootPageService service;

  /// To double pop exit
  DateTime currentBackPressTime = DateTime.now();

  static const snackBarDuration = Duration(seconds: 3);

  final Rx<bool> _isBottomShown = true.obs;

  final RxInt _activeTabIndex = 0.obs;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode _searchFocus = FocusNode();

  FocusNode get searchFocusNode => _searchFocus;

  Rx<int> currentSearchPage = 0.obs;

  Rx<int> currentSellersPage = 0.obs;

  bool get isBottomVisible => _isBottomShown.value;
  set isBottomVisible(bool value) {
    _isBottomShown.value = value;
  }

  int get activeTabIndex => _activeTabIndex.value;
  set activeTabIndex(int value) {
    _activeTabIndex.value = value;
  }

  void hideBottom() {
    isBottomVisible = false;
  }

  void showBottom() {
    isBottomVisible = true;
  }

  final Rx<TextEditingController> _currentQuery = TextEditingController().obs;

  String get currentQuery => _currentQuery.value.text;

  set currentPage(int query) {
    currentSearchPage.value = query;
  }

  int get currentPage => currentSearchPage.value;

  Future<int> ordersCount() async {
    return await service.customerOrdersCount(
        Get.find<AuthController>().state?.companyData?.id ?? 0);
  }

}
