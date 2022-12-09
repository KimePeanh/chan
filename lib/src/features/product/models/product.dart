class Product {
  final String id;
  final String name;
  final String price;
  final String thumbnail;
  final String? code;
  final List? images;
  final String? productDetail;
  final String? promoPrice;
  final String? promoPercent;
  // final int reviewCount;
  // final String star;
  final List<VariantOptionType> variantOptionTypeList;
  factory Product.fromJson(Map<String, dynamic> json) {
    List imagess = [];

    if (json["photos"].length == 0) {
    } else {
      //imagess.add(json["image"]);
      json["photos"].forEach((item) {
        imagess.add(item["photo"]);
      });
    }
    List<VariantOptionType> variantOptionTypeListTemp = [];
    if (json["variant_option_type"] != null ||
        json.containsKey("variant_option_type")) {
      json["variant_option_type"].forEach((data1) {
        List<VariantOptionTypeData> variantOptionTypeDataList = [];
        data1["data"].forEach((data2) {
          variantOptionTypeDataList.add(VariantOptionTypeData(
              id: data2["id"].toString(), name: data2["name"]));
        });
        variantOptionTypeListTemp.add(VariantOptionType(
            id: data1["id"].toString(),
            type: data1["type"],
            variantOptionTypeDataList: variantOptionTypeDataList));
      });
    }
    variantOptionTypeListTemp.forEach((data) {});
    return Product(
        // reviewCount:
        //     json['comment']["total"] == null ? 0 : json['comment']["total"],
        // star: (json["comment"]["stars"] == null)
        //     ? "0"
        //     : json["comment"]["stars"].toString(),
        id: (json["product_id"] == null)
            ? json['id'].toString()
            : json["product_id"].toString(),
        code: json["code"] ?? null,
        name: json["name"],
        thumbnail: json["image"],
        price: json["price"].toString(),
        promoPercent: json["promo_percent"] ?? null,
        promoPrice: json["promo_price"] ?? null,
        images: imagess,
        productDetail: json["product_details"],
        variantOptionTypeList: variantOptionTypeListTemp);
  }
  Product(
      {required this.id,
      // required this.reviewCount,
      // required this.star,
      required this.name,
      required this.price,
      required this.thumbnail,
      required this.images,
      required this.code,
      required this.productDetail,
      required this.promoPercent,
      required this.promoPrice,
      required this.variantOptionTypeList});
}

class VariantOptionType {
  final String id;
  final String type;
  List<VariantOptionTypeData> variantOptionTypeDataList = [];
  VariantOptionType(
      {required this.id,
      required this.type,
      required this.variantOptionTypeDataList});
}

class VariantOptionTypeData {
  final String id;

  final String name;
  VariantOptionTypeData({required this.id, required this.name});
}
