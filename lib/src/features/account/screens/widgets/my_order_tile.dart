import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/features/authentication/bloc/index.dart';
import 'package:lady_skin/src/features/my_order/bloc/index.dart';
import 'package:lady_skin/src/features/my_order/screens/my_order_page.dart';

import '../../../../appLocalizations.dart';

Widget myOrderTile(context) {
  Widget _tile(
      {required String name,
      required Function onPressed,
      required Widget icon}) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Column(
        children: [
          icon,
          SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of(context)!.translate(name),
            textScaleFactor: 0.9,
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }

  // Widget _tilte(
  //         {required String title,
  //         required Widget icon,
  //         required Function onTap}) =>
  //     GestureDetector(
  //       onTap: () {
  //         onTap();
  //       },
  //       child: Container(
  //         // color: Colors.green,
  //         width: double.infinity,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             SizedBox(height: 5),
  //             Row(
  //               children: [
  //                 Expanded(
  //                   flex: 30,
  //                   child: Container(),
  //                 ),
  //                 Expanded(
  //                   flex: 40,
  //                   child: AspectRatio(
  //                       aspectRatio: 1,
  //                       child: FittedBox(fit: BoxFit.contain, child: icon)),
  //                 ),
  //                 Expanded(
  //                   flex: 30,
  //                   child: Container(),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(
  //               height: 5,
  //             ),
  //             Text(
  //               title,
  //               textScaleFactor: 0.9,
  //               style: TextStyle(
  //                 color: Colors.black,
  //               ),
  //             ),
  //             SizedBox(height: 10),
  //           ],
  //         ),
  //       ),
  //     );
  return Stack(
    children: [
      Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(60),
            ),
          ),
          height: (MediaQuery.of(context).size.width / 4) - (60)),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Expanded(
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                if (state is Authenticated) {
                  BlocProvider.of<MyOrderBloc>(context).add(FetchMyOrder());
                }
                return BlocBuilder<MyOrderBloc, MyOrderState>(
                  builder: (context, state) {
                    // Helper.handleState(state: state, context: context);
                    if (BlocProvider.of<MyOrderBloc>(context)
                            .orderList
                            .length ==
                        0)
                      return _tile(
                          name: "toPay",
                          icon: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            child: Container(
                              margin: EdgeInsets.all(15),
                              height: 30,
                              width: 30,
                              child: ImageIcon(
                                AssetImage(
                                  "assets/icons/order_status/to_pay.png",
                                ),
                                color: Colors.yellow[800],
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(myOrder, arguments: 0);
                          });
                    return _tile(
                        name: "toPay",
                        icon: Badge(
                          padding: EdgeInsets.all(4),
                          badgeColor: Colors.yellow,
                          badgeContent: Text(
                              BlocProvider.of<MyOrderBloc>(context)
                                  .orderList
                                  .length
                                  .toString(),
                              textScaleFactor: 0.9,
                              style: TextStyle(color: Colors.black)),
                          position: BadgePosition.topEnd(top: 0, end: 0),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            child: Container(
                              margin: EdgeInsets.all(15),
                              height: 30,
                              width: 30,
                              child: ImageIcon(
                                AssetImage(
                                  "assets/icons/order_status/to_pay.png",
                                ),
                                color: Colors.yellow[800],
                              ),
                            ),
                          ),
                        ),
                        // Icon(
                        //   Icons.attach_money_outlined,
                        //   color: Colors.yellow[800],
                        // ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyOrderPage(
                                        initIndex: 0,
                                      )));
                          // Navigator.of(context)
                          //     .pushNamed(myOrder, arguments: 0);
                        });
                  },
                );
              }),
            ),
            SizedBox(width: 10),
            Expanded(
                flex: 1,
                child: _tile(
                    name: "paid",
                    icon: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Container(
                        margin: EdgeInsets.all(15),
                        height: 30,
                        width: 30,
                        child: ImageIcon(
                          AssetImage(
                            "assets/icons/order_status/paid.png",
                          ),
                          color: Colors.orange[600],
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(myOrder, arguments: 1);
                    })),
            SizedBox(width: 10),
            Expanded(
                flex: 1,
                child: _tile(
                    name: "onDelivery",
                    icon: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Container(
                        margin: EdgeInsets.all(15),
                        height: 30,
                        width: 30,
                        child: ImageIcon(
                          AssetImage(
                            "assets/icons/order_status/on_delivery.png",
                          ),
                          color: Colors.lightGreen[800],
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(myOrder, arguments: 2);
                    })),
            SizedBox(width: 10),
            Expanded(
                flex: 1,
                child: _tile(
                    name: "completed",
                    icon: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Container(
                        margin: EdgeInsets.all(15),
                        height: 30,
                        width: 30,
                        child: ImageIcon(
                          AssetImage(
                            "assets/icons/order_status/completed.png",
                          ),
                          color: Colors.green[800],
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(myOrder, arguments: 3);
                    })),
          ],
        ),
      )
    ],
  );
  // return Container(
  //   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
  //   child: RaisedButton(
  //     onPressed: () {
  //       Helper.requiredLoginFuntion(
  //           context: context,
  //           callBack: () {
  //             Navigator.pushNamed(context, myOrder, arguments: 0);
  //           });
  //     },
  //     // color: Colors.grey[100],
  //     elevation: 0,

  //     padding: EdgeInsets.all(15),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(18.0),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           AppLocalizations.of(context)!.translate("myOrders"),
  //           textScaleFactor: 1.1,
  //           style: TextStyle(
  //             // letterSpacing: 0.5,
  //             color: Colors.black,
  //           ),
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         Divider(
  //           thickness: 2,
  //         ),
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             Expanded(
  //               flex: 1,
  //               child: _tile(
  //                   title: AppLocalizations.of(context)!.translate("toPay"),
  //                   icon:
  //BlocBuilder<AuthenticationBloc, AuthenticationState>(
  //                       builder: (context, state) {
  //                     if (state is Authenticated) {
  //                       BlocProvider.of<MyOrderBloc>(context)
  //                           .add(FetchMyOrder());
  //                     }
  //                     return BlocBuilder<MyOrderBloc, MyOrderState>(
  //                       builder: (context, state) {
  //                         if (BlocProvider.of<MyOrderBloc>(context)
  //                                 .orderList
  //                                 .length ==
  //                             0)
  //                           return Icon(
  //                             Icons.attach_money_outlined,
  //                             color: Colors.yellow[800],
  //                           );
  //                         return Badge(
  //                           padding: EdgeInsets.all(4),
  //                           badgeColor: Colors.red,
  //                           badgeContent: Text(
  //                               BlocProvider.of<MyOrderBloc>(context)
  //                                   .orderList
  //                                   .length
  //                                   .toString(),
  //                               textScaleFactor: 0.7,
  //                               style: TextStyle(color: Colors.white)),
  //                           position: BadgePosition.topEnd(top: -8, end: -5),
  //                           child: Icon(
  //                             Icons.attach_money_outlined,
  //                             color: Colors.yellow[800],
  //                           ),
  //                         );
  //                       },
  //                     );
  //                   }),
  //                   onTap: () {
  //                     Navigator.of(context).pushNamed(myOrder, arguments: 0);
  //                   }),
  //             ),
  //             Expanded(
  //               flex: 1,
  //               child: _tile(
  //                   title: AppLocalizations.of(context)!.translate("paid"),
  //                   icon: Icon(
  //                     Icons.money_outlined,
  //                     color: Colors.green,
  //                   ),
  //                   onTap: () {
  //                     Navigator.of(context).pushNamed(myOrder, arguments: 1);
  //                   }),
  //             ),
  //             Expanded(
  //               flex: 1,
  //               child: _tile(
  //                   title: AppLocalizations.of(context)!.translate("onDelivery"),
  //                   icon: Icon(
  //                     Icons.drive_eta_outlined,
  //                     color: Colors.yellow[800],
  //                   ),
  //                   onTap: () {
  //                     Navigator.of(context).pushNamed(myOrder, arguments: 2);
  //                   }),
  //             ),
  //             Expanded(
  //               flex: 1,
  //               child: _tile(
  //                   title: AppLocalizations.of(context)!.translate("completed"),
  //                   icon: Icon(
  //                     Icons.check_circle_outline,
  //                     color: Colors.green,
  //                   ),
  //                   onTap: () {
  //                     Navigator.of(context).pushNamed(myOrder, arguments: 3);
  //                   }),
  //             )
  //           ],
  //         )
  //       ],
  //     ),
  //   ),
  // );
}
