import 'package:flutter/material.dart';

AppBar standardAppBar(BuildContext context, String text) {
  return AppBar(
    brightness: Brightness.light,
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_outlined,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    centerTitle: true,
    title: Text(
      text,
      style: Theme.of(context).primaryTextTheme.headline6,
    ),
  );
}
