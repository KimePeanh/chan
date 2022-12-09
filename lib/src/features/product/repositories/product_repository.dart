import 'package:dio/dio.dart';

import 'package:lady_skin/src/features/product/models/product.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';

class ProductRepository {
  ApiProvider apiProvider = ApiProvider();
  static const String baseUrl = "https://ecommerceapi.anakutapp.com/products";
  final int rowPerPage = 10;
  late String url;
  Future<List<Product>> getProductsByDefault({required int page}) async {
    url = baseUrl + "/page=$page&row_per_page=10";
    return getProducts();
  }

  Future<List<Product>> getProductByCategory(
      {required int page, required categoryId}) async {
    url = baseUrl +
        "/?row_per_page=$rowPerPage&page=$page&category_id=$categoryId";
    return getProducts();
  }

  Future<List<Product>> getProductByStoreCategory(
      {required int page, required String storeId, required categoryId}) async {
    url = "http://ecommerceapi.anakutapp.com/stores/products" +
        "/page=$page&row_per_page=$rowPerPage&category_id=$categoryId&store_id=$storeId";
    return getProducts();
  }

  Future<List<Product>> getProductBySubCategory(
      {required int page, required String subCategoryId}) async {
    url =
        baseUrl + "/?row_per_page=$rowPerPage&page=$page&subid=$subCategoryId";
    return getProducts();
  }

  Future<List<Product>> getProducts() async {
    try {
      Response response = (await apiProvider.get(url, null, null))!;

      if (response.statusCode == 200) {
        List<Product> products = [];
        response.data["data"].forEach((val) {
          products.add(Product.fromJson(val));
        });
        return products;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
