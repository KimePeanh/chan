import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';
import 'package:lady_skin/src/utils/services/invalid_token_exception.dart';

class ReviewRepository {
  ApiProvider apiProvider = ApiProvider();

  Future<void> addReview(
      {required productId,
      required double star,
      required String comment}) async {
    try {
      final String url = "${dotenv.env['baseUrl']}/comment/add";
      final Map body = {
        "product_id": productId,
        "star": star,
        "comment": comment
      };

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

  Future<void> updateReview(
      {required String reviewId,
      required double star,
      required String comment}) async {
    try {
      final String url = "${dotenv.env['baseUrl']}/comment/edit/$reviewId";
      final Map body = {"star": star, "comment": comment};

      Response response = (await apiProvider.post(url, body, null))!;

      if (response.statusCode == 200) {
        // Future<void> checkOutBuyNow({required String addressId}) async {
        //   String url = "http://ecommerceapi.anakutapp.com/";
        //   Map body = {"addressId": addressId};
        //   try {
        //     Response response = (await apiProvider.post(url, body, null))!;
        //
        //     if (response.statusCode == 201) {
        //       return;
        //     }
        //     throw CustomException.generalException();
        //   } catch (e) {
        //     throw e;
        //   }
        // }
        return;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
