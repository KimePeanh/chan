import 'package:flutter/material.dart';
import 'package:lady_skin/src/features/search/screens/search_page.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';

import '../../../../appLocalizations.dart';

Widget appBar({required BuildContext context, required String auth}) {
  double statusBarHeight = MediaQuery.of(context).padding.top;
  // final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  return Container(
    color: Theme.of(context).primaryColor,
    margin: EdgeInsets.all(0),
    width: MediaQuery.of(context).size.width - 30,
    height: double.infinity,
    // color: Theme.of(context).primaryColor,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              showSearch(context: context, delegate: SearchPage(auth: auth));
            },
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius:
                      BorderRadius.all(Radius.circular(searchBarBorderRadius))),
              margin: EdgeInsets.only(
                  left: 15, top: statusBarHeight + 10, right: 15, bottom: 10),
              child: Card(
                margin: EdgeInsets.only(left: 0),
                color: Colors.grey[100],
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(searchBarBorderRadius),
                ),
                //margin: EdgeInsets.all(0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.translate("search"),
                      style: TextStyle(color: Colors.grey[500]),
                      textScaleFactor: 1,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        // Container(
        //     margin: EdgeInsets.only(top: statusBarHeight, right: 0),
        //     child: AspectRatio(
        //       aspectRatio: 1,
        //       child: FittedBox(
        //         fit: BoxFit.fitHeight,
        //         child: IconButton(
        //             padding: EdgeInsets.all(0),
        //             icon: Icon(Icons.notifications, color: Colors.white),
        //             onPressed: null),
        //       ),
        //     ))
      ],
    ),
  );
}
