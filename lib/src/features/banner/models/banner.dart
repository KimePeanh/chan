class Banner {
  final int id;
  final String name;

  final String image;
  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(id: json["id"], name: json["name"], image: json["image"]);
  }
  Banner({
    required this.id,
    required this.name,
    required this.image,
  });
}
