import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/cart/bloc/index.dart';
import 'package:lady_skin/src/features/cart/screens/widgets/cart_product_tile.dart';

class CartItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.translate("cartItem"),
            style: Theme.of(context).primaryTextTheme.subtitle1,
          ),
          SizedBox(
            height: 10,
          ),
          // Divider(),
          BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            // Helper.handleState(state: state, context: context);
            return Column(
              children: BlocProvider.of<CartBloc>(context)
                  .cart
                  .data
                  .map((data) => CartProductTile(
                        cartData: data,
                        showDeleteBtn: false,
                      ))
                  .toList(),
            );
          }),
          // ...BlocProvider.of<CartBloc>(context)
          //     .cart
          //     .data
          //     .map((data) => CartProductTile(
          //           cartData: data,
          //           showDeleteBtn: false,
          //         ))
          //     .toList()
        ],
      ),
    );
  }
}
