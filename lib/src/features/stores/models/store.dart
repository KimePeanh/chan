class Store {
  final String id;
  final String name;
  final String image;
  final String phone;
  final String email;
  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
        id: json["id"].toString(),
        name: json["name"],
        image: json["image"],
        phone: json["phone"],
        email: json["email"]);
  }
  Store(
      {required this.id,
      required this.name,
      required this.image,
      required this.phone,
      required this.email});
}
// {
//   "address": "",
//   "code": "Sport",
//   "email": "sport​kamboul@gmail.com",
//   "firstname": null,
//   "id": 93,
//   "image": "https://fardin.opentech-computer.com/assets/uploads/none.jpg",
//   "lastname": null,
//   "name": "Sport",
//   "owner": null,
//   "phone": "028477323"
// },
