import 'package:flutter/material.dart';
import 'package:lady_skin/src/appLocalizations.dart';

import 'widgets/feedback_field.dart';

class FeedbackPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check_outlined,
                color: Theme.of(context).primaryColor),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));
              }
              //Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 0),
            alignment: Alignment.topLeft,
            child: Text(
              AppLocalizations.of(context)!.translate("feedback"),
              //AppLocalizations.of(context)!.translate('myOrders'),
              //AppLocalizations.of(context)!.translate("language"),
              style: TextStyle(
                color:
                    Theme.of(context).appBarTheme.textTheme?.headline6?.color,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
              textScaleFactor: 1.8,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: AspectRatio(aspectRatio: 7 / 3, child: FeedbackField())),
        ],
      ),
    );
  }
}
