import 'package:lady_skin/src/features/sub_category/models/sub_category.dart';

class CategoryFeature {
  final String name;
  final List<SubCategory> subCategories;
  factory CategoryFeature.fromJson(Map<String, dynamic> json) {
    List<SubCategory> tempSubCategories = [];
    json["subcategories"].forEach((sub) {
      tempSubCategories.add(SubCategory.fromJson(sub));
    });
    return CategoryFeature(
        name: json["name"], subCategories: tempSubCategories);
  }
  CategoryFeature({required this.name, required this.subCategories});
}
