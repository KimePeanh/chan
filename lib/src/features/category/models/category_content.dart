import 'package:lady_skin/src/features/banner/models/banner.dart' as b;

import 'category_feature.dart';

class CategoryContent {
  final List<b.Banner> banners;
  final List<CategoryFeature> data;
  factory CategoryContent.fromJson(Map<String, dynamic> json) {
    List<b.Banner> tempBanners = [];
    List<CategoryFeature> tempData = [];
    json["banner"].forEach((banner) {
      tempBanners.add(b.Banner.fromJson(banner));
    });
    json["data"].forEach((categoryFeature) {
      tempData.add(CategoryFeature.fromJson(categoryFeature));
    });
    return CategoryContent(banners: tempBanners, data: tempData);
  }
  CategoryContent({
    required this.banners,
    required this.data,
  });
}
