import 'package:lady_skin/src/features/product/models/product.dart';

class CartItem {
  String id;
  int quantity;
  String grandTotal;
  Product product;
  String? variantId;
  String? variantName;
  String variantPrice;
  factory CartItem.fromJson(Map<String, dynamic> json) {
    // double a = double.parse(json["grand_total"].toString());

    return CartItem(
        id: json["cart_id"].toString(),
        quantity: (double.parse(json["quantity"].toString())).toInt(),
        grandTotal: json["grand_total"].toString(),
        variantId: (json["variant_id"] == null ||
                json["variant_id"].toString().length == 0)
            ? null
            : json["variant_id"].toString(),
        variantName:
            json["variant_name"] == null || json["variant_name"].length == 0
                ? null
                : json["variant_name"].toString(),
        variantPrice: "0",
        // json["variant_price"] == null || json["variant_price"].length == 0
        //     ? null
        //     : double.parse(json["variant_price"].toString()),
        product: Product.fromJson(json));
  }
  CartItem(
      {required this.id,
      required this.quantity,
      required this.grandTotal,
      required this.variantId,
      required this.variantName,
      required this.variantPrice,
      required this.product});
}
