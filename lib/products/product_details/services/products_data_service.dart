
import 'package:customer_app/endpoints_dir.dart';
import 'package:customer_app/providers/data_provider.dart';
import 'package:customer_app/products/products.dart';

class ProductsDataService {
  factory ProductsDataService() {
    return _singleton;
  }

  bool reloadedBestSellers = false;
  bool reloadedOutstandings = false;

  ProductsDataService._internal();
  static final ProductsDataService _singleton = ProductsDataService._internal();






 
  

  Future<List<ProductCategoryModel>> loadProductCategories() async {
    final apiData = await DataProvider.getPetition(categoriesEndP);

    if (apiData['success'] ?? false) {
      final categories = ProductCategoryModel.fromJsonList(apiData['data']);

      return categories;
    } else {
      return [];
    }
  }

  Future<List<UnitPrice>> findProductUnitPrices(
      int productId, int? customer_group,
      {int? unitId}) async {
    final body = {
      "product_id": productId,
      "customer_group": customer_group,
      "unit": unitId
    };

    final apiData = await DataProvider.postPetition(unitsPricesEndP, body);

    if (apiData['success'] ?? false) {
      final unitPrice = UnitPrice.fromJsonList(apiData['data']);

      return unitPrice;
    } else {
      return [];
    }
  }

  Future<Map<int, List<ProductPreference>>> findProductPreferences(
      int productId) async {
    //check if units info are alaready loaded in dataBloc, if not get units and load
    // into databloc
    // if (DataBloc().prefCats == null) {
    //   final prefCats = await getPrefCats();
    //   DataBloc().setPrefCats(prefCats);
    // }

    final body = {"product_id": productId};

    final apiData = await DataProvider.postPetition(prodPrefEndP, body);

    if (apiData['success'] ?? false) {
      final prodPrefs = ProductPreference.fromJsonList(apiData['data']);
      Map<int, List<ProductPreference>> prefs = {};
      for (ProductPreference pP in prodPrefs) {
        if (prefs.containsKey(pP.preferenceCategoryId)) {
          prefs[pP.preferenceCategoryId]?.add(pP);
        } else {
          prefs[pP.preferenceCategoryId!] = [pP];
        }
      }
      return prefs;
    } else {
      return {};
    }
  }
  static Future<List<ProductModel>> getAll(
      {int page = 0, String? query, List<int>? categoriesFilter}) async {
    final body = {
      "page": page,
      "text": query,
      "limit": 15,
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
  static Future<List<ProductModel>> getOutstanding(
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

  Future<List<ProductModel>> get loadOutstandings =>
      getOutstanding();



  
  // Future<void> reloadOutstandings() async {
  //   final productsOuts = await ProductProvider.getOutstanding(
  //       page: 0, categoriesFilter: homeCategoriesId);

  //   setOutstanding(productsOuts);
  //   reloadedOutstandings = true;
  // }

  // Future<void> reloadBestSellers() async {
  //   final products = await ProductProvider.getBestSeller(
  //       page: 0, categoriesFilter: homeCategoriesId);

  //   setBestSellers(products);
  //   reloadedBestSellers = true;
  // }

  // Future<void> addOutstandingsPage(int page) async {
  //   final products = await ProductProvider.getOutstanding(
  //       page: page, categoriesFilter: homeCategoriesId);

  //   addOutstanding(products);
  // }

  // Future<void> addBestSellersPage(int page) async {
  //   final products = await ProductProvider.getBestSeller(
  //       page: page, categoriesFilter: homeCategoriesId);

  //   addBestSellers(products);
  // }

  
}
