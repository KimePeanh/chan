import 'package:lady_skin/src/features/product/models/product.dart';

class BuyNowItem {
  final Product product;
  final int quantity;
  final String? variantId;
  BuyNowItem(
      {required this.product, required this.quantity, required this.variantId});
}
