import 'package:customer_app/home/services/home_data_service.dart';
import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/products/outstanding/controller/outstandings_controller.dart';
import 'package:customer_app/products/products.dart';
import 'package:get/get.dart';

import '../../models/address_model.dart';

class HomeController extends GetxController with StateMixin<int?> {
  HomeController({required this.service}) {
    change(null, status: RxStatus.loading());
  }
  @override
  void onInit() async {
    final authC = Get.find<AuthController>();
    _selectedAddress(
        await service.loadUserSelAddress(compId: authC.state?.companyId));
    super.onInit();
  }

  final HomeDataService service;

  final RxList<ProductModel> _bestSellers =
      List<ProductModel>.empty(growable: true).obs;

  final RxList<ProductModel> _outstandings =
      List<ProductModel>.empty(growable: true).obs;

  RxList<ProductCategoryModel> selectedCategories =
      List<ProductCategoryModel>.empty(growable: true).obs;
  List<ProductModel> get bestSellers => _bestSellers;

  List<ProductModel> get outstandings => _outstandings;

  set bestSellers(List<ProductModel> value) {
    _bestSellers.value = value;
  }

  set outstandings(List<ProductModel> value) {
    _outstandings.value = value;
  }

  void addOutstanding(List<ProductModel> products) {
    outstandings.addAll(products);
  }

  final Rx<AddressModel?> _selectedAddress =
      AddressModel(sucursal: '', direccion: '', vatNo: '').obs;

  AddressModel? get selectedAddrss => _selectedAddress.value;
  setSelectedAddrss(AddressModel? address) async {
    _selectedAddress.value = address;
    await service.saveUserSelectedAddress((address?.id ?? '').toString());
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

  Future<void> reloadOutstandings() async {
    await Get.find<OutstandingsController>().reloadOutstandings(
      fromVWidget: false,
    );
  }



}
