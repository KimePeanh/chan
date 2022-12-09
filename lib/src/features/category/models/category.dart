import 'dart:developer';

class Category {
  final String id;
  final String name;
  final String image;
  factory Category.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return Category(
        id: json["id"].toString(),
        name: json["name"],
        image: json["image"] == null ? "" : json["image"]);
  }
  Category({required this.id, required this.name, required this.image});
}
