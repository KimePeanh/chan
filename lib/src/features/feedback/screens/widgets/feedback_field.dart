import 'package:flutter/material.dart';

class FeedbackField extends StatelessWidget {
  // static final TextEditingController textController = TextEditingController();
  final FocusNode inputNode = FocusNode();

// to open keyboard call this function;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        inputNode.requestFocus();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: Theme.of(context).buttonColor,
      child: TextField(
        focusNode: inputNode,
        keyboardType: TextInputType.multiline,
        minLines: 1, //Normal textInputField will be displayed
        maxLines: 5, //
        textAlign: TextAlign.start,
        decoration: InputDecoration(
            hintStyle: TextStyle(
              color: Theme.of(context).appBarTheme.textTheme!.headline6!.color,
            ),
            border: InputBorder.none,
            isDense: true,
            fillColor: Colors.grey[100],
            alignLabelWithHint: true,
            hintText: "Enter your feedback"),
      ),
    );
  }
}
