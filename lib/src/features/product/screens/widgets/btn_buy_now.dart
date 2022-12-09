import 'package:flutter/material.dart';
import 'package:lady_skin/src/appLocalizations.dart';

Widget btnBuyNow({required onPressed}) {
  return Builder(
      builder: (context) => RaisedButton(
            elevation: 0,
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(standardBorderRadius),
            //     side: BorderSide(
            //         color: Theme.of(context).primaryColor, width: 2)),
            padding: EdgeInsets.symmetric(vertical: 20),
            color: Theme.of(context).primaryColor.withOpacity(0.25),
            // style: ButtonStyle(
            //     shape: MaterialStateProperty.resolveWith((states) =>
            //         RoundedRectangleBorder(
            //             borderRadius:
            //                 BorderRadius.circular(standardBorderRadius),
            //             side: BorderSide(color: Colors.blue, width: 10))),
            //     padding: MaterialStateProperty.resolveWith(
            //         (states) => EdgeInsets.symmetric(vertical: 15)),
            //     backgroundColor: MaterialStateProperty.resolveWith(
            //       (states) => Colors.red,
            //     )),
            onPressed: () {
              onPressed();
            },
            // width: double.infinity,
            // padding: EdgeInsets.symmetric(vertical: 20),
            // backgroundColor: Colors.yellow,
            child: Text(
                AppLocalizations.of(context)!.translate("buyNow").toUpperCase(),
                style: TextStyle(color: (Theme.of(context).primaryColor))),
          ));
}
