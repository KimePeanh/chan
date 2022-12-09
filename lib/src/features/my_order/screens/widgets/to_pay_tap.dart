import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/features/my_order/bloc/index.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';

import '../../../../appLocalizations.dart';
import 'my_order_item_tile.dart';

class ToPayTab extends StatefulWidget {
  @override
  _ToPayTabState createState() => _ToPayTabState();
}

class _ToPayTabState extends State<ToPayTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyOrderBloc, MyOrderState>(
      builder: (context, state) {
        // Helper.handleState(state: state, context: context);
        if (state is FetchingOrder) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorFetchingOrder) {
          Helper.handleState(state: state, context: context);
          return Text(state.error);
        } else {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: BlocProvider.of<MyOrderBloc>(context).orderList.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyOrderItemTile(
                      myOrder: BlocProvider.of<MyOrderBloc>(context)
                          .orderList[index],
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 0, bottom: 20),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: Colors.green[100],
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50),
                          child: Text(
                            AppLocalizations.of(context)!.translate("pay"),
                            style: TextStyle(color: Colors.green[900]),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, payOrder,
                                arguments: BlocProvider.of<MyOrderBloc>(context)
                                    .orderList[index]);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => PayOrderPage(
                            //               orderId:
                            //                   BlocProvider.of<MyOrderBloc>(context).orderList[index].id,
                            //               total:
                            //                   BlocProvider.of<MyOrderBloc>(context).orderList[index].total,
                            //             )));
                          },
                        ))
                  ],
                );
              });
        }
      },
    );
  }
}
