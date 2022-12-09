import 'package:flutter/material.dart';

Widget accountAppBar(context) => AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      brightness: Theme.of(context).brightness,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Account",
        style: TextStyle(
            color: Theme.of(context).appBarTheme.textTheme!.headline6!.color,
            fontWeight: FontWeight.bold),
        textScaleFactor: 1.5,
      ),
    );
