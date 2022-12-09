import 'package:flutter/material.dart';

class QualitySelectorTile extends StatefulWidget {
  @override
  _QualitySelectorTileState createState() => _QualitySelectorTileState();
}

class _QualitySelectorTileState extends State<QualitySelectorTile> {
  int qualityIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).buttonColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          _tile("High", 0),
          Divider(height: 0),
          _tile("Medium", 1),
          Divider(height: 0),
          _tile("Low", 2)
        ],
      ),
    );
  }

  _tile(String title, int index) => GestureDetector(
        onTap: () {
          setState(() {
            qualityIndex = index;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline1!.color),
                  )),
            ),
            qualityIndex == index
                ? Icon(
                    Icons.check_outlined,
                    color: Theme.of(context).primaryColor,
                  )
                : Center()
          ],
        ),
      );
}
