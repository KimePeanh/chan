class Contact {
  final String? phone1;
  final String? phone2;
  final String? phone3;
  final String? website;
  final String? facebook;
  final String? email;
  final String? address;
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        phone1: json["default_phone1"].toString(),
        phone2: json["default_phone2"].toString(),
        phone3: json["default_phone3"].toString(),
        website: json["default_website_url"],
        email: json["default_email"],
        facebook: json["default_facebook"],
        address: json["store_address"]);
  }
  Contact(
      {required this.phone1,
      required this.phone2,
      required this.phone3,
      required this.website,
      required this.email,
      required this.facebook,
      required this.address});
}
