import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/buy_now/models/buy_now_item.dart';
import 'package:lady_skin/src/features/cart/models/cart.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';
import 'package:lady_skin/src/utils/services/invalid_token_exception.dart';

class BuyNowRepository {
  ApiProvider apiProvider = ApiProvider();
  Future<Cart> getBuyNowCart(
      {required String? addressId, required BuyNowItem buyNowItem}) async {
    String url = "${dotenv.env['baseUrl']}/cart/check";
    Map body = {
      "quantity": buyNowItem.quantity,
      "product_id": buyNowItem.product.id,
      "address_id": addressId == null ? 0 : addressId,
      "variant_option_id":
          // ignore: unnecessary_null_comparison
          (buyNowItem.variantId == null) ? 0 : buyNowItem.variantId
    };
    try {
      Response response = (await apiProvider.post(url, body, null))!;

      if (response.statusCode == 200 && response.data['code'] == 0) {
        return Cart.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
