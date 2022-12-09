import 'package:flutter/material.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';

Widget favouriteTile(context, key) => RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
      // width: double.infinity,
      // padding: EdgeInsets.all(15),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(5),
      //   color: Colors.red[100],
      // ),elevation: 0,
      onPressed: () {
        Helper.requiredLoginFuntion(
            context: context,
            callBack: () {
              Navigator.pushNamed(context, favourite);
            });
      },

      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      color: Colors.white,

      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.translate("favourite"),
              textScaleFactor: 1,
              textAlign: TextAlign.start,
              style: TextStyle(
                  // letterSpacing: 0.5,
                  color: Theme.of(context).textTheme.headline1!.color),
            ),
            Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );
