import 'package:flutter/material.dart';
import 'package:lady_skin/src/shared/bloc/indexing/index.dart';

import 'add_to_cart_modal.dart';

class ChipChoiceOption extends StatefulWidget {
  ChipChoiceOption(
      {required this.type,
      required this.options,
      required this.variantOptionTypeIndex});
  final String type;
  final List<String> options;
  final int variantOptionTypeIndex;
  @override
  ChipChoiceOptionState createState() => new ChipChoiceOptionState();
}

class ChipChoiceOptionState extends State<ChipChoiceOption>
    with TickerProviderStateMixin {
  late int selectedIndex;
  Widget _buildChips() {
    List<Widget> chips = [];
    for (int i = 0; i < widget.options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: i == selectedIndex
                ? Theme.of(context).primaryColor
                : Colors.black12,
            width: (i == selectedIndex) ? 2.0 : 1,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        padding: EdgeInsets.all(10),
        selected: selectedIndex == i,
        label: Text(
          widget.options[i],
          style: TextStyle(color: Theme.of(context).textTheme.headline1!.color),
        ),
        pressElevation: 5,
        shadowColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedColor: Theme.of(context).scaffoldBackgroundColor,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              setState(() {
                selectedIndex = i;
              });
              variantOptionTypeIndexingBLocList[widget.variantOptionTypeIndex]
                  .add(Taped(index: i));
            }
          });
        },
      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), child: choiceChip));
    }

    return Container(
      margin: EdgeInsets.only(left: 15, top: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Container(
              margin: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                widget.type,
                textScaleFactor: 1.2,
                style: TextStyle(
                    color: Theme.of(context).textTheme.headline1!.color),
              )),
          Wrap(
            children: chips,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    setState(() {
      selectedIndex = 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildChips(),
    );
  }
}
