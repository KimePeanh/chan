import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/cart/models/cart.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';
import 'package:lady_skin/src/utils/services/invalid_token_exception.dart';

class CartRepository {
  ApiProvider apiProvider = ApiProvider();
  Future<Cart> getUserCart({required String? addressId}) async {
    String url = (addressId == null)
        ? "${dotenv.env['baseUrl']}/cart"
        : "${dotenv.env['baseUrl']}/cart?address=$addressId";

    try {
      Response response = (await apiProvider.get(url, "", null))!;

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      }
      throw CustomException.generalException();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> addToCart({
    required String productId,
    required String? variantIdOptionId,
    required int quantity,
  }) async {
    String url = "${dotenv.env['baseUrl']}/cart/add";

    dynamic body;
    if ((variantIdOptionId == null || variantIdOptionId.length == 0)) {
      body = {
        "product_id": productId,
        "variant_option_id": 0,
        "quantity": quantity
      };
    } else {
      body = {
        "product_id": productId,
        "variant_option_id": variantIdOptionId,
        "quantity": quantity
      };
    }
    try {
      Response response = (await apiProvider.post(url, body, null))!;

      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> setQuantity({
    required String cartId,
    required int quantity,
  }) async {
    String url = "${dotenv.env['baseUrl']}/cart/edit/$cartId";

    dynamic body = {"quantity": quantity};

    try {
      Response response = (await apiProvider.put(url, body))!;

      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      }

      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> removeFromCart({
    required String cartId,
  }) async {
    String url = "${dotenv.env['baseUrl']}/cart/remove/$cartId";

    dynamic body;
    try {
      Response response = (await apiProvider.delete(url, body))!;

      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> checkOut({required String addressId}) async {
    String url = "http://feelez.anakutjobs.com/anakut/public/api/checkout";
    Map body = {"addressId": addressId};
    try {
      Response response = (await apiProvider.post(url, body, null))!;

      if (response.statusCode == 201) {
        return;
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
