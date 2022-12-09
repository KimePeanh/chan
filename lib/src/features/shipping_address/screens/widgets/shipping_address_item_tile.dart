import 'package:flutter/material.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/shipping_address/bloc/index.dart';
import 'package:lady_skin/src/features/shipping_address/bloc/select_shipping_address_bloc.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';
import '../shipping_address_page.dart';
import '../../../checkout/screens/widgets/select_shipping_address_btn.dart';

class ShippingAddressItemTile extends StatelessWidget {
  final bool isView;
  ShippingAddressItemTile({
    required this.index,
    required this.isView,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isView == false) {
          shippingAddressBloc.add(SetDefaultAddress(
              address: shippingAddressBloc.addressList[index]));
          selectShippingAddressBloc.add(
              SelectAddress(address: shippingAddressBloc.addressList[index]));
          Navigator.of(context).pop();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(standardBorderRadius)),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shippingAddressBloc.addressList[index].description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      textAlign: TextAlign.start,
                      style: TextStyle(),
                    ),
                    (shippingAddressBloc.addressList[index].isDefault == "t")
                        ? Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(standardBorderRadius),
                              color: Colors.blue,
                            ),
                            child: Text(
                              "Default",
                              style: TextStyle(color: Colors.white),
                              textScaleFactor: 0.8,
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Center(),
                  ]),
            ),
            PopupMenuButton<String>(
              itemBuilder: (context) {
                return [
                  "0", "1"
                  //{"key":"d","value":AppLocalizations.of(context)!.translate("setDefault")},
                  // AppLocalizations.of(context)!.translate("setDefault"),
                  // AppLocalizations.of(context)!.translate("delete")
                ].map((str) {
                  return PopupMenuItem(
                    value: str,
                    child: (str == "0")
                        ? Text(AppLocalizations.of(context)!
                            .translate("setDefault"))
                        : Text(
                            AppLocalizations.of(context)!.translate("delete")),
                  );
                }).toList();
              },
              child: Icon(Icons.more_vert),
              onSelected: (v) {
                if (v == "1") {
                  shippingAddressBloc.add(RemoveAddressStarted(
                      address: shippingAddressBloc.addressList[index]));
                }
                if (v == "0") {
                  shippingAddressBloc.add(SetDefaultAddress(
                      address: shippingAddressBloc.addressList[index]));
                }
              },
            )
          ],
        ),
      ),
    );
    // return AspectRatio(
    //     aspectRatio: 7 / 3,
    //     child: Container(
    //       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //       child: FlatButton(
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(standardBorderRadius)),
    //         color: Colors.grey[100],
    //         padding: EdgeInsets.all(0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           // crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Expanded(
    //               flex: 8,
    //               child: Container(
    //                 margin: EdgeInsets.all(20),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       shippingAddressBloc.addressList[index].description,
    //                       overflow: TextOverflow.ellipsis,
    //                       maxLines: 5,
    //                       textAlign: TextAlign.start,
    //                       style: TextStyle(),
    //                     ),
    //                     (shippingAddressBloc.addressList[index].isDefault ==
    //                             "t")
    //                         ? Container(
    //                             padding: EdgeInsets.all(5),
    //                             decoration: BoxDecoration(
    //                               borderRadius: BorderRadius.circular(18),
    //                               color: Colors.blue,
    //                             ),
    //                             child: Text(
    //                               "Default",
    //                               style: TextStyle(color: Colors.white),
    //                               textScaleFactor: 0.8,
    //                               textAlign: TextAlign.center,
    //                             ),
    //                           )
    //                         : Center(),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             Expanded(
    //               flex: 1,
    //               child: Container(
    //                   margin: EdgeInsets.only(top: 0, right: 0),
    //                   alignment: Alignment.topRight,
    //                   child: DropdownButton<String>(
    //                     isExpanded: true,
    //                     icon: Icon(Icons.more_vert),
    //                     underline: Container(),
    //                     elevation: 0,
    //                     items: <String>["Set as default", "delete"]
    //                         .map((String value) {
    //                       return new DropdownMenuItem<String>(
    //                         value: value,
    //                         child: new Text(value),
    //                       );
    //                     }).toList(),
    //                     onChanged: (_) {},
    //                   )
    //                   // IconButton(
    //                   //   icon: Icon(Icons.more_vert),
    //                   //   color: Colors.red[300],
    //                   //   onPressed: () {
    //                   //     shippingAddressBloc.add(RemoveAddressStarted(
    //                   //         address: shippingAddressBloc.addressList[index]));
    //                   //   },
    //                   // )
    //                   ),
    //             )
    //           ],
    //         ),
    //         onPressed: () {
    //           if (isView == false) {
    //             selectShippingAddressBloc.add(SelectAddress(
    //                 address: shippingAddressBloc.addressList[index]));
    //             Navigator.of(context).pop();
    //           }
    //         },
    //       ),
    //     ));
  }
}
