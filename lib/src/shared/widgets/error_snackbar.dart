import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void errorSnackBar({required String text, required BuildContext context}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black87,
      content: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
    ));
