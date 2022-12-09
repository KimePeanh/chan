import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/shared/bloc/indexing/index.dart';

import 'vendor_slider_dot.dart';

final List<Map> storeBanner = [
  {
    "name": "Xiaomi Cambodia",
    "id": "1",
    "profile_image":
        "https://scontent.fpnh1-2.fna.fbcdn.net/v/t1.0-9/57155585_2224717340897180_4067439225945980928_n.png?_nc_cat=1&ccb=1-3&_nc_sid=973b4a&_nc_ohc=tHkV7VA_2dMAX-_DkVL&_nc_ht=scontent.fpnh1-2.fna&oh=b41d438d208001c3ac3d5881664c25c1&oe=607A8FEA",
    "cover_image":
        "https://scontent.fpnh1-2.fna.fbcdn.net/v/t1.0-9/156911654_3861039040598327_870102867332529030_o.jpg?_nc_cat=103&ccb=1-3&_nc_sid=973b4a&_nc_ohc=ulpDsMQ0yA4AX-3h9-g&_nc_ht=scontent.fpnh1-2.fna&oh=b31e7457752cbdab22ab2aeaf45cecc2&oe=607ADBB6"
  },
  {
    "name": "Samsung Cambodia",
    "id": "2",
    "profile_image":
        "https://scontent.fpnh1-2.fna.fbcdn.net/v/t1.0-9/27752263_10155060259366786_7106004900315601198_n.jpg?_nc_cat=1&ccb=1-3&_nc_sid=973b4a&_nc_ohc=LQ2zix-gbl4AX9-Cvw8&_nc_oc=AQl_sq4XVzHnoRWhKnx6vG2cg8mulCpMB5n6vrvopErCP69XifSKICkELnFFtNrKw6A&_nc_ht=scontent.fpnh1-2.fna&oh=9f79657d8f8c4d32746a67d4ef14a303&oe=607A81BD",
    "cover_image":
        "https://scontent.fpnh1-1.fna.fbcdn.net/v/t1.0-9/120100692_10157286975911786_5025229462285239958_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=973b4a&_nc_ohc=qj0KdBlaHDoAX_P8RQ9&_nc_ht=scontent.fpnh1-1.fna&oh=a10c49e017844127d19289b7552ac60d&oe=60799B41"
  },
  {
    "name": "Sony Cambodia",
    "id": "2",
    "profile_image":
        "https://scontent.fpnh1-2.fna.fbcdn.net/v/t1.0-9/1483139_10151919523921997_815462249_n.png?_nc_cat=1&ccb=1-3&_nc_sid=973b4a&_nc_ohc=wPbEsKsYjdsAX_B-NQm&_nc_ht=scontent.fpnh1-2.fna&oh=94c812e16b1e5195afad1a093abb1020&oe=607AA2CD",
    "cover_image":
        "https://scontent.fpnh1-2.fna.fbcdn.net/v/t1.0-9/69437551_10156973271566997_268225144336416768_o.jpg?_nc_cat=111&ccb=1-3&_nc_sid=973b4a&_nc_ohc=4odFktQn7rMAX85A-M-&_nc_ht=scontent.fpnh1-2.fna&oh=ada81d12fd7db1cf0cfbb46abf8add84&oe=607BB5E2"
  }
];

class VendorSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          // color: Colors.green,
          child: CarouselSlider(
              items: storeBanner
                  .map((store) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      padding: EdgeInsets.symmetric(
                          // top: ,
                          vertical:
                              (((MediaQuery.of(context).size.width * 52.08) /
                                          100) *
                                      20 /
                                      100) /
                                  2),
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                child: Image(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(store["cover_image"]))),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, bottom: 10),
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(store["profile_image"]),
                                  // radius: 100,
                                  backgroundColor: Colors.red,
                                  // child: Image(
                                  //     image: NetworkImage(store["profile_image"])),
                                ),
                                SizedBox(width: 10),
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Text(store["name"]))
                              ],
                            ),
                          )
                        ],
                      )))
                  .toList(),
              options: CarouselOptions(
                onPageChanged: (index, s) {
                  BlocProvider.of<IndexingBloc>(context)
                      .add(Taped(index: index));
                },
                // height: 400,
                aspectRatio: 2.27,
                viewportFraction: 0.9,
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
        ),
        Container(
          //color: Colors.blue,
          alignment: Alignment.center,
          height:
              (((MediaQuery.of(context).size.width * 52.08) / 100) * 20 / 100) /
                  2,
          child: VendorSliderDot(
            dotQty: storeBanner.length,
          ),
        ),
      ],
    );
  }
}
