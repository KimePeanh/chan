import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/cart/bloc/index.dart';

class CartDetailFrame extends StatefulWidget {
  CartDetailFrame(
      {required this.btnText, required this.onBtnPressed, required this.total});
  final String btnText;
  final Function onBtnPressed;
  final String total;
  @override
  _CartDetailFrameState createState() => _CartDetailFrameState();
}

class _CartDetailFrameState extends State<CartDetailFrame> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        builder: (BuildContext context, state) {
      // Helper.handleState(state: state, context: context);
      if (state is FetchingCart) {
        return Container();
      } else
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
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                              fontWeight: FontWeight.w100)),
                      SizedBox(height: 10),
                      Text("" + widget.total,
                          maxLines: 1,
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    // color: Theme.of(context).primaryColor,
                    onPressed: () {
                      widget.onBtnPressed();
                    },
                    color: (Theme.of(context).primaryColor),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 2, color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.btnText.toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.arrow_forward, color: Colors.white)
                      ],
                    ),
                  ),
                )
              ],
            ));
    });
  }
}

// Widget _btnCheckout() {
//   return Builder(
//       builder: (context) => Container(
//             margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//             child: RaisedButton(
//               elevation: 0,
//               color: Theme.of(context).primaryColor,
//               onPressed: () {
//                 if (selectShippingAddressBloc.address == null) {
//                 } else {
//                   Navigator.pushNamed(context, checkout,
//                       arguments: selectShippingAddressBloc.address.id);
//                   // Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //         builder: (context) => CheckoutStatusPage(
//                   //               accessToken: user.accessToken,
//                   //               addressId: selectShippingAddressBloc.address.id,
//                   //             )));
//                 }
//               },
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     AppLocalizations.of(context)!
//                         .translate('submitOrder')
//                         .toUpperCase(),
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Icon(Icons.arrow_forward, color: Colors.white)
//                 ],
//               ),
//             ),
//           ));
// }
