import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/account/models/user.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';
import 'package:lady_skin/src/utils/services/invalid_token_exception.dart';

enum ProductsOption { ByDefault, ByCategory, BySubCategory, BySearch }

class AccountRepository {
  ApiProvider apiProvider = ApiProvider();
  int rowPerPage = 10;
  Future<User> getAccount() async {
    try {
      String url = "${dotenv.env['baseUrl']}/profile";
      Response response = (await apiProvider.get(url, null, null))!;

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      } else if (response.data["code"] != 0) {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateAccount(User user) async {
    try {
      String url = "${dotenv.env['baseUrl']}/profile/update";
      final Map body = {
        "name": user.name,
        "email": user.email,
        "image_url": user.profileImage
      };
      Response response = (await apiProvider.put(url, body))!;

      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      } else if (response.data["code"] != 0) {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
