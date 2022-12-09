import 'package:flutter/material.dart';

Widget logoHolder() => Row(
      children: [
        Expanded(flex: 25, child: Container()),
        Expanded(
            flex: 50,
            child: AspectRatio(
              aspectRatio: 1,
              child: FittedBox(
                  child:
                      Image(image: AssetImage("assets/icons/ic_launcher.png"))),
            )),
        Expanded(flex: 25, child: Container()),
      ],
    );
