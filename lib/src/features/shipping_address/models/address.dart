class Address {
  final String id;
  final String name;
  final String lat;
  final String long;
  final String? description;
  final String? isDefault;
  Address(
      {required this.id,
      required this.name,
      required this.lat,
      required this.long,
      required this.description,
      required this.isDefault});

  factory Address.fromJson(Map<String, dynamic> json) {
    print(json.toString());
    return Address(
        name: json["name"],
        id: json["id"].toString(),
        lat: json["lat"],
        long: json["long"],
        description: (json["description"] != null) ? json["description"] : "",
        isDefault: json["default"]);
  }
}
