import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/shared/bloc/indexing/index.dart';

List<Map> paymentMethodList = [
  {
    "name": "ABA",
    "image": "assets/icons/payment_method/aba.png",
    "description": "000 507 362 | PEN SITHAT"
  },
  {
    "name": "Aceleda",
    "image": "assets/icons/payment_method/aceleda.png",
    "description": "017 385 445 | EANG SINA"
  },
  {
    "name": "Wing",
    "image": "assets/icons/payment_method/wing.png",
    "description": "017 385 445  | 03473718"
  },
  {
    "name": "TrueMoney",
    "image": "assets/icons/payment_method/true-money.png",
    "description": "017 385 445"
  },
  {
    "name": "emoney",
    "image": "assets/icons/payment_method/emoney.png",
    "description": "017 385 445"
  }
];
Future<void> paymentMethodDialog(BuildContext c) async {
  return showDialog(
      context: c,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.white,
            content: Container(
              padding: EdgeInsets.all(15),
              //height: 500,
              width: MediaQuery.of(context).size.width - 30,
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: 5),
                  Text(
                    AppLocalizations.of(context)!
                        .translate("chooseTransferMethod"),
                    textScaleFactor: 1,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Divider(
                      // height: 8,
                      ),
                  ...paymentMethodList
                      .map(
                        (data) => Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<IndexingBloc>(c).add(Taped(
                                    index: paymentMethodList.indexOf(data)));
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                color: Colors.green.withOpacity(0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                //color: Colors.red,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      height: 50,
                                      // width: 15,
                                      // height: 15,
                                      image: AssetImage(data["image"]),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data["name"],
                                            textScaleFactor: 0.9,
                                            maxLines: 2,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            data["description"],
                                            textScaleFactor: 0.85,
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 8,
                            )
                          ],
                        ),
                      )
                      .toList()
                ]),
              ),
            ));
      });
}
