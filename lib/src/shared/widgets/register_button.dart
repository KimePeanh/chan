import 'package:flutter/material.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';

Widget registerButton({required BuildContext context}) => Container(
      width: double.infinity,
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, loginRegister, arguments: false);
        },

        // color: Theme.of(context).primaryColor,

        padding: EdgeInsets.symmetric(vertical: 14),

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(standardBorderRadius),
            side: BorderSide(color: Theme.of(context).primaryColor)),

        child: Text(
          AppLocalizations.of(context)!.translate("register"),
          style: TextStyle(color: Colors.black),
          textScaleFactor: 1.1,
        ),
      ),
    );
