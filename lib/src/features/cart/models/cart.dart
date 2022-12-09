import 'package:lady_skin/src/features/cart/models/cart_item.dart';

class Cart {
  List<CartItem> data;
  String total;
  String grandTotal;
  String deliveryFee;

  Cart(
      {required this.data,
      required this.total,
      required this.deliveryFee,
      required this.grandTotal});
  factory Cart.fromJson(Map<String, dynamic> json) {
    List<CartItem> tempCartData = [];
    (json["data"] is List)
        ? json["data"].forEach((tempData) {
            tempCartData.add(CartItem.fromJson(tempData));
          })
        : tempCartData.add(CartItem.fromJson(json["data"]));

    return Cart(
        grandTotal: json["grand_total"].toString(),
        deliveryFee: json["delivery_fee"].toString(),
        total: json["total"].toString(),
        data: tempCartData);
  }
}
