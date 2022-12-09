import 'package:flutter/material.dart';

import 'widgets/quality_selector_tile.dart';

class ImageQualityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).textTheme.headline1!.color,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
              "Image Quality",
              //AppLocalizations.of(context)!.translate('myOrders'),
              //AppLocalizations.of(context)!.translate("language"),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline1!.color,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
              textScaleFactor: 1.8,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          QualitySelectorTile()
        ],
      ),
    );
  }
}
