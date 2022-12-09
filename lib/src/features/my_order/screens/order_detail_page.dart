import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/my_order/bloc/index.dart';
import 'package:lady_skin/src/shared/widgets/error_snackbar.dart';
import 'package:lady_skin/src/shared/widgets/standard_appbar.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';
import 'widgets/order_detail_item_tile.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderId;
  OrderDetailPage({required this.orderId});
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetailPage> {
  late MyOrderBloc _myOrderBloc;
  @override
  void initState() {
    _myOrderBloc = MyOrderBloc(orderRepository: null);
    _myOrderBloc.add(FetchMyOrderDetail(orderId: widget.orderId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: standardAppBar(context, ""),
      body: BlocListener(
        bloc: _myOrderBloc,
        listener: (context, state) {
          if (state is ErrorFetchingOrder) {
            Helper.handleState(state: state, context: context);
            errorSnackBar(text: state.error, context: context);
          }
        },
        child: BlocBuilder(
            bloc: _myOrderBloc,
            builder: (context, state) {
              if (state is FetchingOrder) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ErrorFetchingOrder) {
                Helper.handleState(state: state, context: context);
                return TextButton(onPressed: () {}, child: Text("Retry"));
              } else {
                return ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!.translate("orderDetail"),
                        //AppLocalizations.of(context)!.translate("language"),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                        textScaleFactor: 1.8,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ..._myOrderBloc.orderHistoryDetail.orderItems
                        .map((order) => orderDetailItemTile(orderItem: order)),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        color: Colors.white,
                        padding: EdgeInsets.all(15),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .translate("orderSummary"),
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.1,
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                color: Colors.grey[100],
                                thickness: 2,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${AppLocalizations.of(context)!.translate("orderId")}: ${_myOrderBloc.orderHistoryDetail.summary.id}",
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                      "${AppLocalizations.of(context)!.translate("total")}: "),
                                  Text(
                                      "${_myOrderBloc.orderHistoryDetail.summary.grandTotal}",
                                      style: TextStyle(color: Colors.red[300])),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),

                              Row(
                                children: [
                                  Text(
                                      "${AppLocalizations.of(context)!.translate("subtotal")}: "),
                                  Text(
                                      "${_myOrderBloc.orderHistoryDetail.summary.total}",
                                      style: TextStyle(color: Colors.red[300])),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                      "${AppLocalizations.of(context)!.translate("deliveryFee")}: "),
                                  Text(
                                      "${_myOrderBloc.orderHistoryDetail.summary.deliveryFee}",
                                      style: TextStyle(color: Colors.red[300])),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  "${AppLocalizations.of(context)!.translate("date")}: ${_myOrderBloc.orderHistoryDetail.summary.date}"),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              // Text("Address: ${orderHistoryBloc.orderList[index].address}"),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  "${AppLocalizations.of(context)!.translate("address")}: ${_myOrderBloc.orderHistoryDetail.summary.address}"),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  "${AppLocalizations.of(context)!.translate("status")}: ${_myOrderBloc.orderHistoryDetail.summary.status}"),
                            ],
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    // Image(
                    //   // errorBuilder: (context, error, stackTrace) =>
                    //   //     Container(),
                    //   image: NetworkImage(
                    //       _myOrderBloc.orderHistoryDetail.transactionImage),
                    // ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child:
                          (_myOrderBloc.orderHistoryDetail.transactionImage ==
                                  null)
                              ? Container()
                              : Image(
                                  // errorBuilder: (context, error, stackTrace) =>
                                  //     Container(),
                                  image: NetworkImage(_myOrderBloc
                                      .orderHistoryDetail.transactionImage!),
                                ),
                    )
                  ],
                );
              }
            }),
      ),
    );
  }

  @override
  void dispose() {
    _myOrderBloc.close();
    super.dispose();
  }
}
