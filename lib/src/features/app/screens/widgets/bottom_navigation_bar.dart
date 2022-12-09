import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/cart/bloc/cart_bloc.dart';
import 'package:lady_skin/src/features/cart/bloc/cart_state.dart';
import 'package:lady_skin/src/features/home/screens/home_page.dart';
import 'package:lady_skin/src/shared/bloc/indexing/index.dart';
import 'package:lady_skin/src/shared/bloc/invoking/invoking_bloc.dart';

import '../app_page.dart';

class AppBottomNavigationBar extends StatefulWidget {
  @override
  AppBottomNavigationBarState createState() => AppBottomNavigationBarState();
}

class AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  // static List<InvokingBloc> bottomNavigationPagesInvokingBloc;
  // static IndexingBloc bottomNavigationIndexBloc;
  // @override
  // void initState() {
  //   bottomNavigationIndexBloc = IndexingBloc();
  //   bottomNavigationPagesInvokingBloc = [
  //     InvokingBloc(),
  //     InvokingBloc(),
  //     InvokingBloc(),
  //     InvokingBloc(),
  //   ];
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bottomNavigationIndexBloc,
        builder: (BuildContext context, int state) {
          return BottomNavigationBar(
            // selectedLabelStyle: TextStyle(fontSize: (state == 0) ? 1 : 12),
            // selectedIconTheme: IconThemeData(size: 50),
            selectedFontSize: (state == 0) ? 5 : 14,
            unselectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            // showSelectedLabels: (state == 0) ? false : true,
            currentIndex: state,
            onTap: (index) {
              onButtonNavigationTapped(index);
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: (state == 0)
                    ? Stack(
                        children: [
                          // Column(children: [
                          //   Icon
                          // ],),
                          Container(
                              // color: Colors.blue,
                              height: 42,
                              width: 42,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/ic_launcher.jpg")),
                              )),
                        ],
                      )
                    : Icon(Icons.home_outlined),
                label: (state == 0)
                    ? ""
                    : AppLocalizations.of(context)!.translate("home"),
              ),
              BottomNavigationBarItem(
                icon: (state == 0)
                    ? Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 12),
                            child: Icon(Icons.category_outlined),
                          )
                          // Text(
                          //   "ដដថ",
                          //   style: TextStyle(fontSize: 12),
                          // )
                        ],
                      )
                    : Icon(Icons.category_outlined),
                label: AppLocalizations.of(context)!.translate("category"),
              ),
              BottomNavigationBarItem(
                icon: (state == 0)
                    ? Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 12),
                            child: Icon(Icons.article_outlined),
                          )
                          // Text(
                          //   "ដដថ",
                          //   style: TextStyle(fontSize: 12),
                          // )
                        ],
                      )
                    : Icon(Icons.article_outlined),
                label: AppLocalizations.of(context)!.translate("blog"),
              ),
              BottomNavigationBarItem(
                icon: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state2) {
                    // Helper.handleState(state: state2, context: context);
                    return Badge(
                      showBadge:
                          BlocProvider.of<CartBloc>(context).cart.data.length ==
                                  0
                              ? false
                              : true,
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                      badgeContent: Text(
                        BlocProvider.of<CartBloc>(context)
                            .cart
                            .data
                            .length
                            .toString(),
                        textScaleFactor: 0.6,
                        style: TextStyle(color: Colors.white),
                      ),
                      position: BadgePosition.topEnd(top: -8, end: -5),
                      child: (state == 0)
                          ? Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 12),
                                  child: Icon(Icons.shopping_cart_outlined),
                                )
                                // Text(
                                //   "ដដថ",
                                //   style: TextStyle(fontSize: 12),
                                // )
                              ],
                            )
                          : Icon(
                              Icons.shopping_cart_outlined,
                              // color: Theme.of(context).primaryColor,
                            ),
                    );
                  },
                ),
                label: AppLocalizations.of(context)!.translate("cart"),
              ),
              BottomNavigationBarItem(
                icon: (state == 0)
                    ? Column(
                        children: [
                          Container(
                              padding: EdgeInsets.only(bottom: 12),
                              child: Icon(Icons.account_circle_outlined)),
                          // Text(
                          //   "ដដថ",
                          //   style: TextStyle(fontSize: 12),
                          // )
                        ],
                      )
                    : Icon(Icons.account_circle_outlined),
                label: AppLocalizations.of(context)!.translate("account"),
              ),
            ],
          );
        });
  }

  static void onButtonNavigationTapped(int index) {
    if (bottomNavigationIndexBloc.state == 0 && index == 0) {
      HomePage.scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      );
    }

    if (AppPageState.bottomNavigationPagesInvokingBloc[index].isInvoked ==
        false) {
      AppPageState.bottomNavigationPagesInvokingBloc[index]
          .add(InvokingEvent.Invoke);
    }
    bottomNavigationIndexBloc.add(Taped(index: index));
  }

  @override
  void dispose() {
    bottomNavigationIndexBloc.close();
    AppPageState.bottomNavigationPagesInvokingBloc.forEach((bloc) {
      bloc.close();
    });
    super.dispose();
  }
}
