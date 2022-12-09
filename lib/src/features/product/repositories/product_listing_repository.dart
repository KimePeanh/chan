import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/product/models/product.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';

List<Product> parseProducts(responseBody) {
  print(responseBody);
  // final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return responseBody.map<Product>((json) => Product.fromJson(json)).toList();
}

abstract class ProductListingRepository {
  final ApiProvider apiProvider = ApiProvider();
  late String url;
  final bool isAuthenticated;
  ProductListingRepository({required this.isAuthenticated});
  Future<List<Product>> getProductList(
      {required int page, required int rowPerPage, required additionalArg});
  Future<List<Product>> operate(
      {required String urlSuffix,
      required int page,
      required int rowPerPage}) async {
    try {
      url =
          dotenv.env['baseUrl']! + (isAuthenticated ? "/auth" : "") + urlSuffix;
      Response response = (await apiProvider.get(url, null, null))!;

      if (response.statusCode == 200) {
        // return compute(parseProducts, response.data["data"]);
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

class ProductListRepo extends ProductListingRepository {
  ProductListRepo({required bool isAuthenticated})
      : super(isAuthenticated: isAuthenticated);
  @override
  Future<List<Product>> getProductList(
          {required int page,
          required int rowPerPage,
          required additionalArg}) async =>
      await super.operate(
          urlSuffix: "/products?row_per_page=$rowPerPage&page=$page",
          page: page,
          rowPerPage: rowPerPage);
}

class ProductListByCategoryRepo extends ProductListingRepository {
  ProductListByCategoryRepo({required bool isAuthenticated})
      : super(isAuthenticated: isAuthenticated);
  @override
  Future<List<Product>> getProductList(
      {required int page,
      required int rowPerPage,
      required additionalArg}) async {
    if (additionalArg is String)
      return await super.operate(
          urlSuffix:
              "/products?row_per_page=$rowPerPage&page=$page&category_id=$additionalArg",
          page: page,
          rowPerPage: rowPerPage);
    else
      throw CustomException(message: "Invalid argument.");
  }
}

class ProductListBySubCategoryRepo extends ProductListingRepository {
  ProductListBySubCategoryRepo({required bool isAuthenticated})
      : super(isAuthenticated: isAuthenticated);
  @override
  Future<List<Product>> getProductList(
      {required int page,
      required int rowPerPage,
      required additionalArg}) async {
    if (additionalArg is String)
      return await super.operate(
          urlSuffix:
              "/products?row_per_page=$rowPerPage&page=$page&subid=$additionalArg",
          page: page,
          rowPerPage: rowPerPage);
    else
      throw CustomException(message: "Invalid argument.");
  }
}

class ProductListByPromotionRepo extends ProductListingRepository {
  ProductListByPromotionRepo({required bool isAuthenticated})
      : super(isAuthenticated: isAuthenticated);
  @override
  Future<List<Product>> getProductList(
      {required int page,
      required int rowPerPage,
      required additionalArg}) async {
    return await super.operate(
        urlSuffix:
            "/products?page=$page&row_per_page=$rowPerPage&type=promotion",
        page: page,
        rowPerPage: rowPerPage);
  }
}
