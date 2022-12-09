import 'package:flutter/material.dart';
import 'package:lady_skin/src/appLocalizations.dart';

Widget settingAppBar(context) => AppBar(
      brightness: Theme.of(context).brightness,
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).textTheme.headline1!.color,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      centerTitle: true,
      title: Text(
        AppLocalizations.of(context)!.translate("setting"),
        style: TextStyle(
            color: Theme.of(context).appBarTheme.textTheme!.headline6!.color,
            fontWeight: FontWeight.bold),
        textScaleFactor: 1.5,
      ),
    );
