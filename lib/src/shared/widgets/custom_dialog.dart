import 'package:flutter/material.dart';

customDialog(BuildContext context, String title, Widget content, Function onOk,
    {bool dismissible = true}) {
  showDialog(
      barrierDismissible: dismissible,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                onOk();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
