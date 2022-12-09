import 'package:lady_skin/src/features/product/models/product.dart';

class Favourite {
  final String id;
  Product product;
  Favourite({required this.product, required this.id});
  factory Favourite.fromJson(Map<String, dynamic> json) {
    Product product = Product.fromJson(json);

    return Favourite(product: product, id: json["favourite_id"].toString());
  }
}
