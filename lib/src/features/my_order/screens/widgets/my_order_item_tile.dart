import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/features/my_order/models/my_order.dart';

class MyOrderItemTile extends StatelessWidget {
  MyOrderItemTile({required this.myOrder});
  final MyOrder myOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.grey[100],
        padding: EdgeInsets.all(15),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                      "${AppLocalizations.of(context)!.translate("orderId")}: "),
                  Text(myOrder.id,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text("${AppLocalizations.of(context)!.translate("total")}: "),
                  Text("${myOrder.grandTotal}",
                      style: TextStyle(color: Colors.red[300])),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                  "${AppLocalizations.of(context)!.translate("date")}: ${myOrder.date}"),
              SizedBox(
                height: 5,
              ),
              Text(
                  "${AppLocalizations.of(context)!.translate("address")}: ${myOrder.address}"),
              SizedBox(
                height: 5,
              ),
              Text(
                  "${AppLocalizations.of(context)!.translate("status")}: ${myOrder.status}"),
            ],
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, orderDetail, arguments: myOrder.id);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => OrderDetailPage(
          //             accessToken: accessToken,
          //             orderId: myOrder.id,
          //           )),
          // );
        },
      ),
    );
  }
}
