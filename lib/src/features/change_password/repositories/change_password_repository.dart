import 'package:dio/dio.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';
import 'package:lady_skin/src/utils/services/invalid_token_exception.dart';

class ChangeChangePasswordRepository {
  ApiProvider apiProvider = ApiProvider();
  static const String baseUrl =
      "http://feelez.anakutjobs.com/anakut/public/api/auth/change";
  Future<String> changeChangePassword(
      {required String currentChangePassword,
      required String newChangePassword}) async {
    String url = "http://v-arch.anakutjobs.com/anakut/public/api/auth/change";
    Map body = {
      "current_password": currentChangePassword,
      "new_password": newChangePassword
    };
    try {
      Response response = (await apiProvider.put(url, body))!;
      if (response.statusCode == 200) {
        return response.data["token"];
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      }

      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}
