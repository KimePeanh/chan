import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/buy_now/models/buy_now_item.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';
import 'package:lady_skin/src/utils/services/invalid_token_exception.dart';

class CheckoutRepository {
  ApiProvider apiProvider = ApiProvider();

  Future<void> checkout({
    required String? addressId,
  }) async {
    String url = "${dotenv.env['baseUrl']}/checkout";
    Map body = (addressId == null)
        ? {"address": 0, "payment_type": "cash"}
        : {"address": addressId, "payment_type": "cash"};

    try {
      Response response = (await apiProvider.post(url, body, null))!;

      if (response.statusCode == 200 && response.data["code"] == 0) {
        print(response.data);
        return;
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      } else if (response.data["code"] != 0) {
        throw CustomException(message: response.data["message"]);
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> checkoutWithTransfer(
      {required String? addressId,
      required String paymentMethod,
      required String imageUrl}) async {
    String url = "${dotenv.env['baseUrl']}/checkout";
    Map body = (addressId == null)
        ? {
            "address": 0,
            "payment_type": "transfer",
            "payment_method": paymentMethod,
            "image_url": imageUrl
          }
        : {
            "address": addressId,
            "payment_type": "transfer",
            "payment_method":
                (paymentMethod[0] == "P") ? "Phone" : paymentMethod,
            "image_url": imageUrl
          };

    try {
      Response response = (await apiProvider.post(url, body, null))!;

      if (response.statusCode == 200 && response.data["code"] == 0) {
        return;
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      } else if (response.data["code"] != 0) {
        throw CustomException(message: response.data["message"]);
      }
      throw CustomException.generalException();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> buyNow(
      {required String? addressId, required BuyNowItem buyNowItem}) async {
    String url = "${dotenv.env['baseUrl']}/checkout";
    Map body = (addressId == null)
        ? {
            "address": 0,
            "payment_type": "cash",
            "product_id": buyNowItem.product.id,
            "quantity": buyNowItem.quantity,
            "checkout_type": "buy_now",
          }
        : {
            "address": addressId,
            "payment_type": "cash",
            "product_id": buyNowItem.product.id,
            "quantity": buyNowItem.quantity,
            "checkout_type": "buy_now",
          };

    try {
      Response response = (await apiProvider.post(url, body, null))!;
      log(body.toString());
      log(response.data.toString());
      print(response.data);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        print(response.data);
        return;
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      } else if (response.data["code"] != 0) {
        print(response.data);
        throw CustomException(message: response.data["message"]);
      }
      throw CustomException.generalException();
    } catch (e) {
      log(e.toString());
      throw e;
    }
  }

  Future<void> buyNowWithTransfer(
      {required String? addressId,
      required String paymentMethod,
      required String imageUrl,
      required BuyNowItem buyNowItem}) async {
    String url = "${dotenv.env['baseUrl']}/checkout";
    Map body = (addressId == null)
        ? {
            "address": 0,
            "payment_type": "transfer",
            "payment_method": paymentMethod[0] == "P" ? "Phone" : paymentMethod,
            "image_url": imageUrl,
            "product_id": buyNowItem.product.id,
            "quantity": buyNowItem.quantity,
            "checkout_type": "buy_now",
          }
        : {
            "checkout_type": "buy_now",
            "address": addressId,
            "payment_type": "transfer",
            "payment_method": paymentMethod[0] == "P" ? "Phone" : paymentMethod,
            "image_url": imageUrl,
            "product_id": buyNowItem.product.id,
            "quantity": buyNowItem.quantity
          };

    try {
      Response response = (await apiProvider.post(url, body, null))!;

      if (response.statusCode == 200 && response.data["code"] == 0) {
        return;
      } else if (response.data["code"] != 0) {
        throw CustomException(message: response.data["message"]);
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
