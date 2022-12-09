import 'package:flutter/material.dart';
import 'package:lady_skin/src/appLocalizations.dart';

Future<void> addToCartStatusDialog(BuildContext context,
    {required bool isSuccceed}) async {
  return showDialog(
      barrierColor: Color(0x01000000),
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        Future.delayed(Duration(milliseconds: 1200), () {
          Navigator.of(context).pop(true);
        });
        return WillPopScope(
            onWillPop: () async => true,
            child: SimpleDialog(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                // key: key,
                backgroundColor: Colors.black.withOpacity(0.7),
                children: <Widget>[
                  Center(
                    child: Column(children: [
                      Icon(
                        isSuccceed ? Icons.shopping_cart_outlined : Icons.clear,
                        size: 50,
                        color: Colors.grey[50],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppLocalizations.of(context)!.translate(
                            isSuccceed ? "addCartSucceed" : "addCartFailed"),
                        textScaleFactor: 1.2,
                        style: TextStyle(color: Colors.grey[50]),
                      )
                    ]),
                  )
                ]));
      });
}
