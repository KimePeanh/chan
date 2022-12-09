import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/product/models/product.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';

class ProductDetailRepository {
  ApiProvider apiProvider = ApiProvider();
  Future<Product> getProduct({required String productId}) async {
    String url = "${dotenv.env['baseUrl']}/product/$productId";
    try {
      Response response = (await apiProvider.get(url, null, null))!;
      return Product.fromJson(response.data["data"]);
    } catch (error) {
      throw error;
    }
  }
}
