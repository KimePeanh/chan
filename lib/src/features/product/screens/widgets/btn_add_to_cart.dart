import 'package:flutter/material.dart';

import '../../../../appLocalizations.dart';

Widget btnAddToCart({required onPressed}) {
  return Builder(
      builder: (context) => RaisedButton(
            elevation: 0,
            color: Theme.of(context).primaryColor,
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(standardBorderRadius),
            //     side: BorderSide(
            //         color: Theme.of(context).primaryColor, width: 1)),
            padding: EdgeInsets.symmetric(vertical: 20),

            // style: ButtonStyle(
            //     shape: MaterialStateProperty.resolveWith((states) =>
            //         RoundedRectangleBorder(
            //             borderRadius:
            //                 BorderRadius.circular(standardBorderRadius),
            //             side: BorderSide(color: Colors.blue, width: 10))),
            //     padding: MaterialStateProperty.resolveWith(
            //         (states) => EdgeInsets.symmetric(vertical: 15)),
            //     backgroundColor: MaterialStateProperty.resolveWith(
            //       (states) => Colors.red,
            //     )),
            onPressed: () {
              onPressed();
            },
            // width: double.infinity,
            // padding: EdgeInsets.symmetric(vertical: 20),
            // backgroundColor: Colors.yellow,
            child: Text(
                AppLocalizations.of(context)!
                    .translate("addToCart")
                    .toUpperCase(),
                style: TextStyle(color: Colors.white)),
          ));
}

// class BtnAddToCart extends StatefulWidget {
//   BtnAddToCart({required this.product});
//   final Product product;
//   @override
//   _BtnAddToCartState createState() => _BtnAddToCartState();
// }

// class _BtnAddToCartState extends State<BtnAddToCart> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<CartBloc, CartState>(
//       listener: (context, CartState state) async {},
//       child: Padding(
//         padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
//         child: AspectRatio(
//           aspectRatio: 10 / 1.2,
//           child: Container(
//               width: double.infinity,
//               height: 45,
//               child: FlatButton(
//                 color: Theme.of(context).primaryColor,
//                 onPressed: () {
//                   addToCartModal(context, widget.product);
//                 },
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5)),
//                 padding: EdgeInsets.all(0.0),
//                 child: Container(
//                   alignment: Alignment.center,
//                   child: Text(
//                     AppLocalizations.of(context)!
//                         .translate('addToCart')
//                         .toUpperCase(),
//                     textScaleFactor: 1.2,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white, letterSpacing: 1),
//                   ),
//                 ),
//               )),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
