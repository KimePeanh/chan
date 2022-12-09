class MyOrder {
  final String id;
  final String total;
  final String date;
  final String status;
  final String address;
  final String deliveryFee;
  final String grandTotal;

  MyOrder(
      {required this.id,
      required this.deliveryFee,
      required this.total,
      required this.date,
      required this.status,
      required this.address,
      required this.grandTotal});
  factory MyOrder.fromJson(Map<String, dynamic> json) {
    return MyOrder(
        deliveryFee: json["delivery_fee"].toString(),
        id: json["id"].toString(),
        total: json["total"].toString(),
        date: json["date"],
        address: json["address_description"],
        status: (json["status"] == null) ? "null" : json["status"],
        grandTotal: json["grand_total"].toString());
  }
}

class MyOrderDetail {
  final String? transactionImage;
  final MyOrder summary;
  final List<OrderItem> orderItems;
  MyOrderDetail(
      {required this.summary,
      required this.orderItems,
      required this.transactionImage});
  factory MyOrderDetail.fromJson(Map<String, dynamic> json) {
    List<OrderItem> tempOrderItems = [];
    if (json["data"] == null) {
    } else {
      json["data"].forEach((item) {
        tempOrderItems.add(OrderItem.fromJson(item));
      });
    }
    return MyOrderDetail(
        transactionImage: json["image_url"] == null ? null : json["image_url"],
        summary: MyOrder.fromJson(json),
        orderItems: tempOrderItems);
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final String image;
  final String productPrice;
  final int quantity;
  OrderItem(
      {required this.productId,
      required this.productName,
      required this.image,
      required this.productPrice,
      required this.quantity});
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        productId: json["product_id"].toString(),
        productPrice: json["product_price"].toString(),
        image: json["image"],
        productName: json["product_name"],
        quantity: int.parse(json["quantity"].toStringAsFixed(0)));
  }
}
