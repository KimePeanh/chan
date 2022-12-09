import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/product/models/product.dart';

class ProductDetailBody extends StatelessWidget {
  final Product product;
  ProductDetailBody({required this.product});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),

                SizedBox(
                  height: 10,
                ),
                (product.promoPercent != null)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ("" + product.promoPrice.toString()),
                            style: TextStyle(
                                color: Colors.red[300],
                                fontWeight: FontWeight.bold),
                            textScaleFactor: 1.6,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                ("" + product.price.toString()),
                                style: TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                                textScaleFactor: 1.2,
                              ),
                              SizedBox(width: 10),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(18)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: Text(
                                  ("-" + product.promoPercent.toString()),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange[800],
                                  ),
                                  textScaleFactor: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Text(
                        ("" + product.price.toString()),
                        style: TextStyle(
                            color: Colors.red[300],
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold),
                        textScaleFactor: 1.6,
                      ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  product.name,
                  style: TextStyle(color: Colors.black, letterSpacing: 0),
                  textScaleFactor: 1.3,
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  thickness: 1,
                ),
                // _itemReview(context),
                SizedBox(height: 5),
              ],
            ),
          ),
          (product.productDetail == null || product.productDetail!.length == 0)
              ? Center()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            thickness: 1,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .translate("description"),
                            textScaleFactor: 1.3,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    product.productDetail == null
                        ? Center()
                        : Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Html(
                              data: product.productDetail!,
                            ),
                          ),
                  ],
                ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  // _itemReview(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.pushNamed(context, review, arguments: product);
  //     },
  //     child: Container(
  //       color: Colors.red.withOpacity(0),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   AppLocalizations.of(context)!.translate("itemReview"),
  //                   textScaleFactor: 1.3,
  //                   style: TextStyle(fontWeight: FontWeight.bold),
  //                 ),
  //                 SizedBox(height: 10),
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     RatingBar.builder(
  //                       itemPadding: EdgeInsets.all(0),
  //                       itemSize: 30,
  //                       unratedColor: Colors.grey[300],
  //                       ignoreGestures: true,
  //                       initialRating: 0,
  //                       minRating: 1,
  //                       direction: Axis.horizontal,
  //                       allowHalfRating: false,
  //                       itemCount: 5,
  //                       itemBuilder: (context, _) => Icon(
  //                         Icons.star,
  //                         color: Colors.amber,
  //                       ),
  //                       onRatingUpdate: (rating) {},
  //                     ),
  //                     SizedBox(width: 10),
  //                     // Expanded(
  //                     //   child: product.reviewCount == 0
  //                     //       ? Text(
  //                     //           "No rating star yet",
  //                     //           style: TextStyle(color: Colors.grey[500]),
  //                     //         )
  //                     //       : Text(
  //                     //           "${double.parse(product.star).toStringAsFixed(1)} of 5.0 Stars",
  //                     //           style: TextStyle(),
  //                     //         ),
  //                     // )
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 8,
  //                 ),
  //                 product.reviewCount == 0
  //                     ? Text(
  //                         AppLocalizations.of(context)!.translate("noReview"),
  //                         style: TextStyle(color: Colors.grey[500]),
  //                       )
  //                     : Text(
  //                         "${product.reviewCount} ${AppLocalizations.of(context)!.translate("review")}",
  //                         style: TextStyle(),
  //                       ),
  //               ],
  //             ),
  //           ),
  //           Icon(Icons.arrow_forward_ios),
  //           SizedBox(width: 15)
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
