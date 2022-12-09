import 'package:flutter/material.dart';

Widget quote() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _item("  100% Authentic"),
        _item(" Free Return"),
        _item(" Free Shipping")
      ],
    );
Widget _item(String text) {
  return Row(
    children: [
      SizedBox(
        child: FittedBox(
          child: Icon(
            Icons.circle,
            color: Colors.red,
          ),
          fit: BoxFit.contain,
        ),
        height: 8,
      ),
      Text(
        text,
        style: TextStyle(color: Colors.red),
        textScaleFactor: 0.8,
      ),
    ],
  );
}
