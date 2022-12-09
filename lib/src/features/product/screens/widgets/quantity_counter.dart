import 'package:flutter/material.dart';

class QuantityCounter extends StatefulWidget {
  @override
  QuantityCounterState createState() => QuantityCounterState();
}

class QuantityCounterState extends State<QuantityCounter> {
  static int count = 1;
  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     count = 1;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          child: RawMaterialButton(
            onPressed: () {
              if (count != 1) {
                setState(() {
                  count--;
                });
              }
            }, //do your action
            elevation: 2,
            constraints: BoxConstraints(),
            shape: CircleBorder(),
            fillColor: Colors.white,

            child: Icon(
              Icons.remove,
              color: Colors.red,
            ),
            padding: EdgeInsets.all(5),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(count.toString()),
        SizedBox(
          width: 15,
        ),
        Container(
          child: RawMaterialButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
            elevation: 2,
            constraints: BoxConstraints(),
            shape: CircleBorder(),
            fillColor: Colors.white,
            child: Icon(
              Icons.add,
              color: Colors.blue,
            ),
            padding: EdgeInsets.all(5),
          ),
        ),
      ],
    );
  }
}
