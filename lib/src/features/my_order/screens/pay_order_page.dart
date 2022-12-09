import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/checkout/screens/widgets/payment_method_dialog.dart';
import 'package:lady_skin/src/features/my_order/bloc/index.dart';
import 'package:lady_skin/src/features/my_order/models/my_order.dart';
import 'package:lady_skin/src/shared/bloc/file_pickup/file_pickup_bloc.dart';
import 'package:lady_skin/src/shared/bloc/indexing/index.dart';
import 'package:lady_skin/src/shared/widgets/custom_dialog.dart';
import 'package:lady_skin/src/shared/widgets/loading_dialogs.dart';
import 'package:lady_skin/src/shared/widgets/standard_appbar.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';

class PayOrderPage extends StatefulWidget {
  final MyOrder myOrder;
  PayOrderPage({required this.myOrder});
  @override
  _PayOrderPageState createState() => _PayOrderPageState();
}

class _PayOrderPageState extends State<PayOrderPage> {
  IndexingBloc paymentMethodIndexingBloc = IndexingBloc();
  FilePickupBloc _filePickupBloc = FilePickupBloc();
  final MyOrderBloc _myOrderBloc = MyOrderBloc(orderRepository: null);

  @override
  void dispose() {
    _myOrderBloc.close();
    paymentMethodIndexingBloc.close();
    _filePickupBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    paymentMethodIndexingBloc.add(Taped(index: -1));
    return BlocListener(
      bloc: _myOrderBloc,
      listener: (context, state) {
        if (state is PaidOrder) {
          BlocProvider.of<MyOrderBloc>(context).add(FetchMyOrder());
          Navigator.of(context).pop();
          customDialog(context, "",
              Text(AppLocalizations.of(context)!.translate("succeed")), () {
            Navigator.of(context).pop();
          }, dismissible: false);
        } else if (state is ErrorPayingOrder) {
          Helper.handleState(state: state, context: context);
          Navigator.of(context).pop();
          customDialog(
              context,
              AppLocalizations.of(context)!.translate("failed"),
              Text(state.error),
              () {},
              dismissible: true);
        } else
          loadingDialogs(context);
      },
      child: Scaffold(
        appBar: standardAppBar(context,
            "${AppLocalizations.of(context)!.translate("pay")} #${widget.myOrder.id}"),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    BlocProvider(
                        create: (BuildContext context) =>
                            paymentMethodIndexingBloc,
                        child: _paymentMethodWidget(context)),
                    Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            // color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.all(
                                Radius.circular(standardBorderRadius))),
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!
                                .translate("uploadTransImage")),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            GestureDetector(
                              onTap: () {
                                _showPicker(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.width / 3,
                                child: AspectRatio(
                                    aspectRatio: 1,
                                    child: BlocBuilder(
                                      bloc: _filePickupBloc,
                                      builder: (context, dynamic state) {
                                        return FittedBox(
                                            fit: BoxFit.fitHeight,
                                            child: (state == null)
                                                ? Icon(
                                                    Icons.add_a_photo_outlined,
                                                    color: Colors.grey[300],
                                                  )
                                                : Image.file(state));
                                      },
                                    )),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              _detailFrame(),
            ],
          ),
        ),
      ),
    );
  }

  _detailFrame() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      AppLocalizations.of(context)!
                          .translate('total')
                          .toUpperCase(),
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline1!.color,
                          fontWeight: FontWeight.w100)),
                  SizedBox(height: 10),
                  Text("" + widget.myOrder.grandTotal,
                      maxLines: 1,
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 10),
                // color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (paymentMethodIndexingBloc.state == (-1)) {
                    customDialog(
                        context,
                        "",
                        Text(AppLocalizations.of(context)!
                            .translate("pleaseChooseTransfer")),
                        () {});
                  } else if (_filePickupBloc.state == null) {
                    customDialog(
                        context,
                        "",
                        Text(AppLocalizations.of(context)!
                            .translate("pleaseChooseTransImage")),
                        () {});
                  } else {
                    _myOrderBloc.add(PayOrder(
                        paymentMethod:
                            paymentMethodList[paymentMethodIndexingBloc.state]
                                ["name"],
                        orderId: widget.myOrder.id,
                        transactionImage: _filePickupBloc.state));
                  }
                },
                color: (Theme.of(context).primaryColor).withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 2, color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .translate("submit")
                          .toUpperCase(),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.arrow_forward, color: Colors.black)
                  ],
                ),
              ),
            )
          ],
        ));
  }

  _paymentMethodWidget(BuildContext contextt) {
    return Builder(
      builder: (c) {
        return BlocBuilder(
          bloc: BlocProvider.of<IndexingBloc>(c),
          builder: (context, int state) {
            return GestureDetector(
              onTap: () {
                paymentMethodDialog(c);
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // color: Theme.of(context).buttonColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(standardBorderRadius))),
                  margin: EdgeInsets.only(bottom: 15),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!
                          .translate("chooseTransferMethod")),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      (paymentMethodIndexingBloc.state == (-1))
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate("choose here"),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                Icon(Icons.arrow_drop_down)
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  flex: 20,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Image(
                                      // width: 15,
                                      // height: 15,
                                      image: AssetImage(
                                          paymentMethodList[state]["image"]),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    flex: 80,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(paymentMethodList[state]["name"],
                                            textScaleFactor: 1.1),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            paymentMethodList[state]
                                                ["description"],
                                            textScaleFactor: 1.1),
                                      ],
                                    )),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                    ],
                  )),
            );
          },
        );
      },
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        Helper.imgFromGallery((image) {
                          _filePickupBloc.add(image);
                        });
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      Helper.imgFromCamera((image) {
                        _filePickupBloc.add(image);
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
