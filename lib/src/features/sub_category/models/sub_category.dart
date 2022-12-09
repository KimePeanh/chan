class SubCategory {
  final String id;
  final String name;
  factory SubCategory.fromJson(Map<String, dynamic> json) {
    print(json);
    return SubCategory(id: json["id"].toString(), name: json["name"]);
  }
  SubCategory({required this.id, required this.name});
}
