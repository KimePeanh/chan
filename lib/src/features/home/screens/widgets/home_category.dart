import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';

import 'package:lady_skin/src/config/routes/routes.dart';

import 'package:lady_skin/src/features/category/bloc/index.dart';
import 'package:lady_skin/src/features/category/models/category.dart';

class HomeCategory extends StatelessWidget {
  // void initState() {
  //   categoryListBloc.add(FetchCategory(accessToken: null));
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, CategoryState state) {
      if (state is FetchingCategory) {
        return Container();
        // return HomeCategoryShimmer();
      } else if (state is ErrorFetchingCategory) {
        return Container();
      } else
        return Container(
          // padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(AppLocalizations.of(context)!.translate("shopByCategory"),
                  textScaleFactor: 1.1,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 4.0),
                    itemCount: 4,
                    itemBuilder: (BuildContext ctx, index) {
                      return _tile(
                          data: BlocProvider.of<CategoryBloc>(context)
                              .category[index]);
                    }),
              ),
            ],
          ),
        );
    });
  }
}

Widget _tile({required Category data}) {
  return Builder(
    builder: (context) => InkWell(
      onTap: () {
        Navigator.pushNamed(context, productListByCategory, arguments: data);
        // int index =
        //     BlocProvider.of<CategoryBloc>(context).category.indexOf(data);
        // AppBottomNavigationBarState.onButtonNavigationTapped(1);

        // BlocProvider.of<CategoryBloc>(context).add(ChangeIndex(index: index));
        // CategoryPageState.scrollToIndex(index);
        // if (CategoryPageState.invokingBLocList[index].isInvoked == false) {
        //   CategoryPageState.invokingBLocList[index].add(InvokingEvent.Invoke);
        // }
      },
      child: Container(
        margin: EdgeInsets.only(right: 5),
        child: AspectRatio(
          aspectRatio: 70 / 100,
          child: Column(
            children: [
              Container(
                // color: Colors.red,
                child: Row(
                  children: [
                    Expanded(flex: 15, child: Center()),
                    Expanded(
                      flex: 70,
                      child: (data.image.split(".").last == "png")
                          ? AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Center(),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: data.image,
                                        errorWidget: (context, a, error) {
                                          return Text("!");
                                        },
                                        // color: Colors.white,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(),
                                    ),
                                  ],
                                ),
                                width: double.infinity,
                                // height: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            )
                          : AspectRatio(
                              aspectRatio: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: CachedNetworkImage(
                                  maxWidthDiskCache: 250,
                                  maxHeightDiskCache: 250,
                                  fit: BoxFit.cover,
                                  imageUrl: data.image,
                                  placeholder: (context, url) => Image.asset(
                                      "assets/images/product_placeholder.jpg",
                                      fit: BoxFit.fill),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          "assets/images/product_placeholder.jpg",
                                          fit: BoxFit.fill),
                                ),
                              ),
                            ),
                    ),
                    Expanded(flex: 15, child: Center()),
                  ],
                ),
              ),
              Expanded(
                  // flex: 45,
                  child: Container(
                margin: EdgeInsets.all(3),
                alignment: Alignment.topCenter,
                child: Text(data.name,
                    textAlign: TextAlign.center,
                    textScaleFactor: 0.8,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        height: 1.5,
                        letterSpacing: 0,
                        color: Theme.of(context).textTheme.headline1!.color
                        // fontWeight: FontWeight.w300
                        )),
              ))
            ],
          ),
        ),
      ),
    ),
  );
}

// Widget _more() {
//   return Builder(
//     builder: (context) => InkWell(
//       onTap: () {
//         AppBottomNavigationBarState.onButtonNavigationTapped(1);
//         // BlocProvider.of<CategoryBloc>(context).add(ChangeIndex(index: 0));
//         // CategoryPageState.scrollToIndex(0);
//         // if (CategoryPageState.invokingBLocList[0].isInvoked == false) {
//         //   CategoryPageState.invokingBLocList[0].add(InvokingEvent.Invoke);
//         // }
//       },
//       child: Container(
//         margin: EdgeInsets.only(right: 5),
//         child: AspectRatio(
//           aspectRatio: 70 / 100,
//           child: Column(
//             children: [
//               Expanded(
//                 flex: 55,
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.red[50],
//                       borderRadius: BorderRadius.circular(10)),
//                   child: AspectRatio(
//                       aspectRatio: 4 / 4,
//                       child: Row(
//                         children: [
//                           Expanded(flex: 1, child: Center()),
//                           Expanded(
//                             flex: 3,
//                             child: FittedBox(
//                                 child: Icon(
//                               Icons.more_horiz_outlined,
//                               color: Theme.of(context).primaryColor,
//                             )),
//                           ),
//                           Expanded(flex: 1, child: Center()),
//                         ],
//                       )),
//                 ),
//               ),
//               Expanded(
//                   flex: 45,
//                   child: Container(
//                     margin: EdgeInsets.all(3),
//                     alignment: Alignment.topCenter,
//                     child: Text(AppLocalizations.of(context)!.translate("more"),
//                         textAlign: TextAlign.center,
//                         textScaleFactor: 0.9,
//                         maxLines: 2,
//                         style: TextStyle(
//                             height: 1.5,
//                             letterSpacing: 0,
//                             color: Theme.of(context).textTheme.headline1!.color
//                             // fontWeight: FontWeight.w300
//                             )),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

final List<Color?> colorList = [
  Colors.red[500],
  Colors.blue[500],
  Colors.green[500],
  Colors.purple[500],
  Colors.orange[500],
  Colors.yellow[700],
  Colors.pink[500],
  Colors.brown[500],
  Colors.lime[700]
];
