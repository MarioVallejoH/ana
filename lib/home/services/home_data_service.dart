import 'package:customer_app/endpoints_dir.dart';
import 'package:customer_app/models/address_model.dart';
import 'package:customer_app/providers/data_provider.dart';
import 'package:customer_app/products/products.dart';
import 'package:customer_app/services/user_prefs_service.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeDataService {
  static Future<void> loadUserSelectedAddress() async {
    // UserService.setUserAddress(address);
  }

  Future<AddressModel?> loadUserSelAddress({int? compId}) async {
    final address = userSelectedAddress.isEmpty
        ? await getCompanyDefAddress(compId ?? 0)
        : await getAddressData(UserPrefsService.userSelectedAddress);
    return address;
  }

  static Future<List<AddressModel>> getCompanyAddresses(int companyId,
      {bool selectedFirst = true, AddressModel? selectedAdd}) async {
    final res = await DataProvider.postPetition(
        companyAddressesEndP, {"company_id": companyId});

    List<AddressModel> addrss = [];
    if (res['success'] ?? false) {
      if (res['data'] is List) {
        try {
          addrss = AddressModel.fromJsonList(res['data']);
        } catch (e) {
          log(e);
        }
      }
    }
    if (selectedFirst && selectedAdd != null) {
      List<AddressModel> addrssSort = [selectedAdd];
      addrss.removeWhere((element) => element.id == selectedAdd.id);
      addrssSort.addAll(addrss);
      return addrssSort;
    }
    return addrss;
  }

  static Future<AddressModel?> getCompanyDefAddress(int companyId) async {
    final res = await DataProvider.postPetition(
        defaultCompanyAddressEndP, {"company_id": companyId});

    AddressModel? addrss;
    if (res['success'] ?? false) {
      try {
        addrss = AddressModel.fromJson(res['data']);
      } catch (e) {
        log(e);
      }
    }
    return addrss;
  }

  static Future<AddressModel?> getAddressData(dynamic addressId) async {
    final res = await DataProvider.postPetition(
        getAddressDataEndP, {"address_id": addressId});

    AddressModel? addrss;
    if (res['success'] ?? false) {
      try {
        addrss = AddressModel.fromJson(res['data']);
      } catch (e) {
        log(e);
      }
    }
    return addrss;
  }

  Future<void> saveUserPrefs(Map<String, dynamic> prefs) async {
    await setValue("user_prefs", prefs);
  }

  Future<void> saveUserSelectedAddress(String addressId) async {
    await setValue("user_sel_address", addressId);
    log('Saved selected address');
  }

  String get userPrefs => getStringAsync("user_prefs");

  String get userSelectedAddress => getStringAsync("user_sel_address");

  Future<List<ProductModel>> getBestSeller(
      {int page = 0, List<int>? categoriesFilter}) async {
    final body = {
      "page": page,
      "limit": 15,
      "best_sellers": true,
      "categories": categoriesFilter
    };

    final apiData = await DataProvider.postPetition(productSearchEndP, body);

    if (apiData['success'] ?? false) {
      final productList = ProductModel.fromJsonList(apiData['data']);

      return productList;
    } else {
      return [];
    }
  }

  Future<List<ProductModel>> getOutstanding(
      {int page = 0, List<int>? categoriesFilter}) async {
    final body = {
      "page": page,
      "limit": 10,
      "outstanding": true,
      "categories": categoriesFilter
    };

    final apiData = await DataProvider.postPetition(productSearchEndP, body);

    if (apiData['success'] ?? false) {
      final productList = ProductModel.fromJsonList(apiData['data']);

      return productList;
    } else {
      return [];
    }
  }
}
