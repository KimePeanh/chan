import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/account/bloc/account_bloc.dart';
import 'package:lady_skin/src/features/account/bloc/account_event.dart';
import 'package:lady_skin/src/features/cart/bloc/index.dart';
import 'package:lady_skin/src/features/my_order/bloc/index.dart';

import '../../../../appLocalizations.dart';

enum Status { Succes, Failed }

class StatusCard extends StatelessWidget {
  StatusCard({required this.status});
  final Status status;

  @override
  Widget build(BuildContext context) {
    Map data;
    String t(String label) {
      return AppLocalizations.of(context)!.translate(label);
    }

    if (status == Status.Succes) {
      data = {
        "icon": Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 5, color: Colors.green[50]!)),
          child: Icon(Icons.check, color: Colors.white),
        ),
        "bgSvg": "assets/icons/confetti-success.svg",
        "title": t("succeed"),
        "titleColor": Colors.green,
        "text1": t("orderSucceedText"),
        "text2": t("thankyou"),
        "btnNavText": t("continueShopping"),
        "btnNavOnPress": () {
          BlocProvider.of<MyOrderBloc>(context).add(FetchMyOrder());
          BlocProvider.of<CartBloc>(context).add(FetchCart());
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      };
    } else {
      BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
      BlocProvider.of<CartBloc>(context).add(FetchCart());
      data = {
        "icon": Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 5, color: Colors.red[50]!),
          ),
          child: Icon(Icons.clear, color: Colors.white),
        ),
        "bgSvg": "assets/icons/confetti-failed.svg",
        "title": t("failed"),
        "titleColor": Theme.of(context).primaryColor,
        "text1": t("sorry"),
        "text2": t("orderFailedText"),
        "btnNavText": t("tryAgain"),
        "btnNavOnPress": () {
          BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
          Navigator.of(context).pop();
        }
      };
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 65,
              child: Container(
                // color: Colors.red[100],
                // width: MediaQuery.of(context).size.width,
                // height: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: double.infinity,
                      child: Container(),
                      // color: Colors.green[100],
                      // child: SvgPicture.asset(data["bgSvg"]
                      // )
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Center(),
                        ),
                        Expanded(
                            flex: 2,
                            child: AspectRatio(
                              aspectRatio: 4 / 4,
                              child: FittedBox(
                                  fit: BoxFit.fill, child: data["icon"]),
                            )),
                        Expanded(
                          flex: 1,
                          child: Center(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data["title"],
                          textScaleFactor: 2,
                          style: TextStyle(
                              color: data["titleColor"],
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            data["text1"],
                            textScaleFactor: 1.1,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Text(
                          data["text2"],
                          textScaleFactor: 1.1,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    child: AspectRatio(
                      aspectRatio: 10 / 1.3,
                      child: Container(
                          width: double.infinity,
                          height: 45,
                          child: FlatButton(
                            color: Colors.blue,
                            onPressed: () {
                              data["btnNavOnPress"]();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                data["btnNavText"],
                                // AppLocalizations.of(context)!
                                //     .translate('success')
                                //     .toUpperCase(),
                                textScaleFactor: 1.2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, letterSpacing: 1),
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
