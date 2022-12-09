import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lady_skin/src/features/banner/bloc/index.dart';
import 'package:lady_skin/src/features/stores/screens/widgets/vendor_slider_dot.dart';

import 'package:lady_skin/src/shared/bloc/indexing/index.dart';

class HomeBannerSlider extends StatefulWidget {
  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<HomeBannerSlider> {
  IndexingBloc indexingBloc = IndexingBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    indexingBloc.close();

    super.dispose();
  }

  // var service = AppContentsService();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        print(state);
        if (state is FetchingBanner) {
          return Container();
          // return Shimmer(
          //   // duration: Duration(seconds: 5),
          //   // color: Colors.black,
          //   child: AspectRatio(
          //     aspectRatio: 1.91,
          //     child: Container(
          //         //color: Colors.blue,
          //         height: double.infinity,
          //         width: double.infinity),
          //   ),
          // );
        } else if (state is ErrorFetchingBanner) {
          return Container();
        } else {
          // print(BlocProvider.of<BannerBloc>(context).banners.length);
          int dotL = BlocProvider.of<BannerBloc>(context).banners.length;
          print("dotL $dotL");
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider(
                  items: BlocProvider.of<BannerBloc>(context)
                      .banners
                      .map((banner) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          padding: EdgeInsets.only(
                              top: 2,
                              bottom:
                                  ((((MediaQuery.of(context).size.width / 100) *
                                                  14) -
                                              12) /
                                          2) +
                                      0),
                          // padding: EdgeInsets.symmetric(
                          //     // top: ,
                          //     vertical:
                          //         (((MediaQuery.of(context).size.width) /
                          //                     100) *
                          //                 20 /
                          //                 100) /
                          //             2),
                          width: double.infinity,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                child: CachedNetworkImage(
                                    fit: BoxFit.fill, imageUrl: banner.image)),
                          )))
                      .toList(),
                  options: CarouselOptions(
                    onPageChanged: (index, s) {
                      indexingBloc.add(Taped(index: index));
                    },
                    // height: 400,
                    aspectRatio: 2.05,
                    viewportFraction: 0.86,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    // onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  )),
              Container(
                // color: Colors.blue,
                alignment: Alignment.center,
                height:
                    ((((MediaQuery.of(context).size.width / 100) * 10) - 12) /
                            2) +
                        5,
                child: BlocProvider(
                  create: (BuildContext context) => indexingBloc,
                  child: Container(
                    // color: Colors.red,
                    child: VendorSliderDot(
                      dotQty:
                          BlocProvider.of<BannerBloc>(context).banners.length,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

// return Shimmer(
//   duration: Duration(seconds: 5),
//   color: Colors.black,
//   child: AspectRatio(
//     aspectRatio: 18 / 9,
//     child: Container(
//         //color: Colors.blue,
//         height: double.infinity,
//         width: double.infinity),
//   ),
// );
