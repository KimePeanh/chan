import 'package:flutter/material.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/language/screens/widgets/language_modal.dart';

Widget languageTile(context) => RaisedButton(
      onPressed: () {
        languageModal(context);
      },
      elevation: 0,
      //color: Colors.grey[100],
      padding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 40,
              child: AspectRatio(
                aspectRatio: 1,
                child: FittedBox(
                    fit: BoxFit.fill, child: Icon(Icons.language_outlined)),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              flex: 60,
              child: Text(
                AppLocalizations.of(context)!.translate("language"),
                textScaleFactor: 1.1,
                style: TextStyle(
                  // letterSpacing: 0.5,
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
