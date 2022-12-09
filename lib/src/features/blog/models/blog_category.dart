class BlogCategory {
  final String id;
  final String name;
  final String image;

  factory BlogCategory.fromJson(Map<String, dynamic> json) {
    return BlogCategory(
      id: json["id"].toString(),
      name: json["name"],
      image: json["image_url"],
    );
  }
  BlogCategory({
    required this.id,
    required this.name,
    required this.image,
  });
}
