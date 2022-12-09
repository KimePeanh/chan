import 'package:flutter/material.dart';
import 'package:lady_skin/src/features/stores/models/store.dart';

Widget storeItemTileHorizontal({required Store store}) {
  return Container(
    //color: Colors.yellow,
    margin: EdgeInsets.only(right: 15),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            //color: Colors.green,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: AspectRatio(
                  aspectRatio: 1.91,
                  child: Image(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                        "https://scontent.fpnh1-2.fna.fbcdn.net/v/t1.0-9/156911654_3861039040598327_870102867332529030_o.jpg?_nc_cat=103&ccb=1-3&_nc_sid=973b4a&_nc_ohc=ulpDsMQ0yA4AX-3h9-g&_nc_ht=scontent.fpnh1-2.fna&oh=b31e7457752cbdab22ab2aeaf45cecc2&oe=607ADBB6"),
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store.name,
                  textScaleFactor: 1.1,
                ),
                SizedBox(height: 10),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit,",
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
