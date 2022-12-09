import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/favourite/models/favourite.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';
import 'package:lady_skin/src/utils/services/invalid_token_exception.dart';

class FavouriteRepository {
  ApiProvider apiProvider = ApiProvider();
  Future<void> addToFavourite({
    required String productId,
  }) async {
    String url = "${dotenv.env['baseUrl']}/favourite/add";
    dynamic body = {"product_id": productId};
    try {
      Response response = (await apiProvider.post(url, body, null))!;

      if (response.statusCode == 200 && response.data["code"] == 0 ||
          response.data["code"] == (-1)) {
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

  Future<void> removeFromFavourite({
    required String favouriteId,
  }) async {
    String url = "${dotenv.env['baseUrl']}/favourite/remove/$favouriteId";
    Map body = {"favourite_id": favouriteId};
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

  Future<List<Favourite>> getUserFavourite() async {
    String url = "${dotenv.env['baseUrl']}/favourite";

    try {
      Response response = (await apiProvider.get(url, null, null))!;

      if (response.statusCode == 200 && (response.data["code"] == 0)) {
        List<Favourite> favouriteList = [];

        response.data["data"].forEach((favourite) {
          // List imagess = [];
          // if (product["photos"].length == 0) {
          //   imagess = [];
          // } else {
          //   imagess.add(product["image"]);
          //   product["photos"].forEach((item) {
          //     imagess.add(item["photo"]);
          //   });
          // }
          favouriteList.add(Favourite.fromJson(favourite));
        });
        return favouriteList;
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
}
