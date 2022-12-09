import 'package:flutter/material.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';

Widget myAddressTile(BuildContext context) => RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
      onPressed: () {
        Helper.requiredLoginFuntion(
            context: context,
            callBack: () {
              Navigator.pushNamed(context, shippingAddress, arguments: true);
            });
      },
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.translate("shippingAddresses"),
              textScaleFactor: 1,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).textTheme.headline1!.color,
                letterSpacing: 0.5,
              ),
            ),
            Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );
