import 'package:dio/dio.dart';
import 'package:lady_skin/src/features/review/models/review.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'package:lady_skin/src/utils/services/custom_exception.dart';
import 'package:lady_skin/src/utils/services/invalid_token_exception.dart';

abstract class ReviewListRepository {
  final ApiProvider apiProvider = ApiProvider();
  final String baseUrl = "https://system.anakutapp.com/ecommerce/public";
  Future<Map> getReviewList(
      {required int page, required int rowPerPage, required additionalArg});
  Future<Map> operate(
      {required String urlSuffix,
      required int page,
      required int rowPerPage}) async {
    try {
      String url = baseUrl + urlSuffix;
      Response response = (await apiProvider.get(url, null, null))!;

      if (response.statusCode == 200) {
        List<Review> reviews = [];
        response.data["data"].forEach((val) {
          reviews.add(Review.fromJson(val));
        });

        return {
          "can_add": response.data["can_add"],
          "my_review": (response.data["my_comment"] == null ||
                  response.data["my_comment"] is String)
              ? null
              : Review.fromJson(response.data["my_comment"]),
          "review_list": reviews
        };
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}

class ReviewListWithAuthRepo extends ReviewListRepository {
  @override
  Future<Map> getReviewList(
          {required int page,
          required int rowPerPage,
          required additionalArg}) async =>
      await super.operate(
          urlSuffix:
              "/api/auth/comment/$additionalArg?row_per_page=$rowPerPage&page=$page",
          page: page,
          rowPerPage: rowPerPage);
}

class ReviewListWithoutAuthRepo extends ReviewListRepository {
  @override
  Future<Map> getReviewList(
          {required int page,
          required int rowPerPage,
          required additionalArg}) async =>
      await super.operate(
          urlSuffix:
              "/api/comment/$additionalArg?row_per_page=$rowPerPage&page=$page",
          page: page,
          rowPerPage: rowPerPage);
}
