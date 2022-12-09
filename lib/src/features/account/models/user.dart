import 'dart:developer';

import 'package:lady_skin/src/features/shipping_address/models/address.dart';

class User {
  final String id;

  String name;
  final String phone;
  String email;
  String profileImage;
  Address? address;
  String verifyStatus;
  factory User.fromJson(Map<String, dynamic> json) {
    Address? _address;
    if (json["address"] == null) {
      log("null");
    } else if (json["address"].length == 0) {
      log("legnth");
    } else {
      Map<String, dynamic> data = {};
      if (json["address"].runtimeType == (data.runtimeType)) {
        _address = Address.fromJson(json["address"]);
      }
    }
    print(json);
    return User(
        id: json["id"].toString(),
        name: json["name"],
        phone: json["phone"].toString(),
        verifyStatus: json["verify_status"],
        address: _address,
        // address: json["address"] == null || json["address"].length == 0
        //     ? null
        //     : Address.fromJson(json["address"]),
        email: json["email"] ?? "",
        profileImage: json["image_url"] ?? "");
  }
  User(
      {required this.id,
      required this.name,
      required this.address,
      required this.verifyStatus,
      required this.phone,
      required this.email,
      required this.profileImage});
}
