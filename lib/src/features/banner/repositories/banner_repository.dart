import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lady_skin/src/features/banner/models/banner.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';

class BannerRepository {
  ApiProvider apiProvider = ApiProvider();
  String baseUrl = "${dotenv.env['baseUrl']}/banners";
  int rowPerPage = 10;
  Future<List<Banner>> getBannerImages() async {
    String url = baseUrl;
    try {
      Response response = (await apiProvider.get(url, null, null))!;

      if (response.statusCode == 200) {
        var data = response.data;
        List<Banner> banners = [];
        data["data"].forEach((banner) {
          banners.add(Banner.fromJson(banner));
        });
        return banners;
      }
      throw CustomException.generalException();
    } catch (error) {
      throw error;
    }
  }
}
