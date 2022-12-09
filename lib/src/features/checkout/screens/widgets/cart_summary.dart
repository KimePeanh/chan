import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/cart/bloc/index.dart';
import 'package:lady_skin/src/features/cart/models/cart.dart';

class CartSummary extends StatelessWidget {
  final Cart cart;
  CartSummary({required this.cart});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            // Helper.handleState(state: state, context: context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate("cartSummary"),
                  style: Theme.of(context).primaryTextTheme.subtitle1,
                ),
                SizedBox(
                  height: 15,
                ),
                // Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.translate("subtotal")),
                    Text("" + cart.total,
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        AppLocalizations.of(context)!.translate("deliveryFee")),
                    Text("" + cart.deliveryFee,
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.translate("total")),
                    Text("" + cart.grandTotal,
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                )
              ],
            );
          },
        ));
  }
}
