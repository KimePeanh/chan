import 'package:flutter/material.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/features/stores/models/store.dart';

Widget storeItemTileVertical({required Store store}) {
  return Builder(
    builder: (context) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, storeProfilePage, arguments: store);
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[100],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                      color: Colors.red,
                      //  margin: EdgeInsets.all(10),
                      child: AspectRatio(
                          aspectRatio: 1,
                          child: FittedBox(
                            child: Image(
                                image: NetworkImage(
                                    "https://scontent.fpnh1-2.fna.fbcdn.net/v/t1.0-9/57155585_2224717340897180_4067439225945980928_n.png?_nc_cat=1&ccb=1-3&_nc_sid=973b4a&_nc_ohc=tHkV7VA_2dMAX-_DkVL&_nc_ht=scontent.fpnh1-2.fna&oh=b41d438d208001c3ac3d5881664c25c1&oe=607A8FEA")),
                          )))),
              SizedBox(width: 15),
              Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store.name,
                        textScaleFactor: 1.1,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                        maxLines: 2,
                      )
                    ],
                  )),
            ],
          ),
        ),
      );
    },
  );
  // return Container(
  //   color: Colors.yellow,
  //   margin: EdgeInsets.only(right: 15),
  //   child: ClipRRect(
  //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Container(
  //           //color: Colors.green,
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //             child: AspectRatio(
  //                 aspectRatio: 16 / 9,
  //                 child: Image(
  //                   fit: BoxFit.fitHeight,
  //                   image: NetworkImage(
  //                       "https://scontent.fpnh1-2.fna.fbcdn.net/v/t1.0-9/156911654_3861039040598327_870102867332529030_o.jpg?_nc_cat=103&ccb=1-3&_nc_sid=973b4a&_nc_ohc=ulpDsMQ0yA4AX-3h9-g&_nc_ht=scontent.fpnh1-2.fna&oh=b31e7457752cbdab22ab2aeaf45cecc2&oe=607ADBB6"),
  //                 )),
  //           ),
  //         ),
  //         SizedBox(height: 10),
  //         Text(store.name),
  //         SizedBox(height: 10),
  //         Text("fd"),
  //       ],
  //     ),
  //   ),
  // );
}
