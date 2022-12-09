import 'package:flutter/material.dart';
import 'package:lady_skin/src/appLocalizations.dart';

import '../address_form_page.dart';

Widget addressDetailField(BuildContext context) {
  final FocusNode inputNode = FocusNode();
  return FlatButton(
    onPressed: () {
      inputNode.requestFocus();
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    color: Colors.grey[100],
    child: Container(
      child: TextField(
        focusNode: inputNode,
        controller: AddressFormPageState.addressDetailTextController,
        keyboardType: TextInputType.multiline,
        minLines: 1, //Normal textInputField will be displayed
        maxLines: 5, //
        textAlign: TextAlign.start,
        decoration: InputDecoration(
            border: InputBorder.none,
            isDense: true,
            fillColor: Colors.grey[100],
            alignLabelWithHint: true,
            hintText: AppLocalizations.of(context)!.translate('addressDetail')),
      ),
    ),
  );
}
