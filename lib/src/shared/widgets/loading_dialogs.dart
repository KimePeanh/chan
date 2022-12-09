import 'package:flutter/material.dart';

Future<void> loadingDialogs(BuildContext context) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                backgroundColor: Colors.white,
                children: <Widget>[
                  Center(
                    child: Column(children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Please Wait....",
                        style: TextStyle(color: Colors.black),
                      )
                    ]),
                  )
                ]));
      });
}
