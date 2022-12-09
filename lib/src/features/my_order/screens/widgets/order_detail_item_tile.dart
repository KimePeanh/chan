import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lady_skin/src/features/my_order/models/my_order.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';

Widget orderDetailItemTile({required OrderItem orderItem}) {
  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(standardBorderRadius)),
    margin: EdgeInsets.only(left: 20, top: 10, right: 20),
    child: AspectRatio(
      aspectRatio: 3 / 1,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(standardBorderRadius),
                      bottomLeft: Radius.circular(standardBorderRadius)),
                  child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: orderItem.image,
                      placeholder: (context, url) => Image.asset(
                          "assets/images/product_placeholder.jpg",
                          fit: BoxFit.fill),
                      errorWidget: (context, url, error) => Opacity(
                            opacity: 0.2,
                            child: Image.asset(
                                "assets/images/product_placeholder.jpg"),
                          )))),
          SizedBox(width: 10),
          Expanded(
              flex: 2,
              child: Container(
                padding:
                    EdgeInsets.only(left: 0, top: 10, right: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                      orderItem.productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: Text(
                      "Quantity: ${orderItem.quantity}",
                      textScaleFactor: 1,
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      style: TextStyle(color: Colors.black),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: Row(
                      children: [
                        Text(
                          "price: ",
                          textScaleFactor: 1,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "" + orderItem.productPrice,
                          textScaleFactor: 1,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          style: TextStyle(color: Colors.blue[300]),
                        ),
                      ],
                    ))
                  ],
                ),
              ))
        ],
      ),
    ),
  );
}
