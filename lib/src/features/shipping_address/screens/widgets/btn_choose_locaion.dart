import 'package:flutter/material.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/appLocalizations.dart';

Widget btnChooseLocation() => Builder(
      builder: (context) => FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.grey[100],
        padding: EdgeInsets.all(0),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 4 / 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(flex: 2, child: Center()),
                    Expanded(
                        flex: 3,
                        child: AspectRatio(
                            aspectRatio: 4 / 4,
                            child: FittedBox(
                                fit: BoxFit.fill,
                                child: Icon(Icons.location_pin,
                                    color: Colors.green)))),
                    Expanded(flex: 2, child: Center()),
                  ],
                ),
              ),
              Text(
                AppLocalizations.of(context)!.translate('chooseLocation'),
                textAlign: TextAlign.left,
                textScaleFactor: 1.1,
                style: TextStyle(letterSpacing: 0.3),
              )
            ],
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, locationPickup);
        },
      ),
    );
