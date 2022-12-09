import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/features/authentication/bloc/index.dart';
import 'package:lady_skin/src/features/buy_now/models/buy_now_item.dart';
import 'package:lady_skin/src/features/cart/bloc/cart_bloc.dart';
import 'package:lady_skin/src/features/cart/bloc/index.dart';
import 'package:lady_skin/src/features/product/models/product.dart';

import 'package:lady_skin/src/features/product/screens/widgets/quantity_counter.dart';
import 'package:lady_skin/src/shared/bloc/indexing/index.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';

import 'add_to_cart_status_dialog.dart';
import 'btn_buy_now.dart';
import 'chip_choice_option.dart';

List<IndexingBloc> variantOptionTypeIndexingBLocList = [];
void buyNowModal(context, Product product) {
  List<Widget> chipChoiceOptionList = [];
  int index = 0;
  product.variantOptionTypeList.forEach((variantOptionType) {
    List<String> optionList = [];
    variantOptionType.variantOptionTypeDataList
        .forEach((variantOptionTypeData) {
      optionList.add(variantOptionTypeData.name);
    });
    variantOptionTypeIndexingBLocList.add(IndexingBloc());
    chipChoiceOptionList.add(ChipChoiceOption(
      type: variantOptionType.type,
      options: optionList,
      variantOptionTypeIndex: index,
    ));
    index++;
  });

  Future<void> future = showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext bc) {
        return BlocListener<CartBloc, CartState>(
          listener: (context, CartState state) {
            // Helper.handleState(state: state, context: context);
            if (state is AddedToCart) {
              Navigator.of(context).pop();
              addToCartStatusDialog(context, isSuccceed: true);
            }
            if (state is ErrorCart) {
              Helper.handleState(state: state, context: context);
              Navigator.of(context).pop();
              addToCartStatusDialog(context, isSuccceed: false);
            }
          },
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    alignment: Alignment.topRight,
                    icon: Icon(Icons.clear),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      variantOptionTypeIndexingBLocList.forEach((element) {
                        element.close();
                      });
                      variantOptionTypeIndexingBLocList.clear();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3.5,
                        height: MediaQuery.of(context).size.width / 3.5,
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.contain,
                          placeholder: "assets/images/product_placeholder.jpg",
                          image: product.thumbnail,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Opacity(
                              opacity: 0.2,
                              child: Image.asset(
                                  "assets/images/product_placeholder.jpg"),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment:
                            //MainAxisAlignment.spaceBetween,
                            children: [
                              (product.promoPercent != null)
                                  ? Row(
                                      children: [
                                        Text(
                                          ("" + product.promoPrice.toString()),
                                          style: TextStyle(
                                              color: Colors.red[300],
                                              fontWeight: FontWeight.bold),
                                          textScaleFactor: 1.3,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          ("" + product.price.toString()),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                          textScaleFactor: 1,
                                        ),
                                      ],
                                    )
                                  : Text(
                                      ("" + product.price.toString()),
                                      style: TextStyle(
                                          color: Colors.red[300],
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.bold),
                                      textScaleFactor: 1.3,
                                    ),
                              // Text(
                              //   "" + product.price.toString(),
                              //   style: TextStyle(
                              //       color: Theme.of(context).primaryColor,
                              //       fontWeight: FontWeight.bold),
                              //   textScaleFactor: 1.3,
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                product.name,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .color),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textScaleFactor: 1.1,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                Column(
                    children: chipChoiceOptionList
                        .map((chipChoiceOption) => chipChoiceOption)
                        .toList()),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (AppLocalizations.of(context)!.translate('quantity')),
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.headline1!.color),
                      ),
                      QuantityCounter()
                    ],
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    child: Container(
                        width: double.infinity,
                        child: btnBuyNow(onPressed: () {
                          if (BlocProvider.of<AuthenticationBloc>(context).state
                              is NotAuthenticated) {
                            Navigator.pushNamed(context, loginRegister,
                                arguments: true);
                          }
                          if (BlocProvider.of<AuthenticationBloc>(context).state
                              is Authenticated) {
                            int variantId = 0;
                            int index = 0;
                            variantOptionTypeIndexingBLocList
                                .forEach((variantOptionTypeIndexingBLoc) {
                              variantId += int.parse(product
                                  .variantOptionTypeList[index]
                                  .variantOptionTypeDataList[
                                      variantOptionTypeIndexingBLoc.state]
                                  .id);
                              index++;
                            });
                            Navigator.pushNamed(context, buyNow,
                                arguments: BuyNowItem(
                                    product: product,
                                    quantity: QuantityCounterState.count,
                                    variantId: (variantId == 0)
                                        ? null
                                        : variantId.toString()));
                            // BlocProvider.of<CartBloc>(context).add(AddToCart(
                            //   variantId: (variantId == 0)
                            //       ? null
                            //       : variantId.toString(),
                            //   productId: product.id,
                            //   quantity: QuantityCounterState.count,
                            // ));
                          }
                        }))),
              ],
            ),
          ),
        );
      });
  future.then((void value) {
    variantOptionTypeIndexingBLocList.forEach((element) {
      element.close();
    });
    variantOptionTypeIndexingBLocList.clear();
  });
}
