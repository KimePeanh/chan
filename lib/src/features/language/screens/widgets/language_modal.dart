import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/language/bloc/language_bloc.dart';
import 'package:lady_skin/src/features/language/bloc/language_event.dart';
import 'package:lady_skin/src/features/language/bloc/language_state.dart';

languageModal(context) {
  List options = [
    {"name": "ខ្មែរ", "code": Language.KM},
    {"name": "English", "code": Language.EN}
  ];
  int index = 0;
  return showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
            title: Text(
              AppLocalizations.of(context)!.translate("chooseLang"),
            ),
            children: [
              SimpleDialogOption(
                child: Row(
                  children: [
                    Image(
                        image: AssetImage("assets/icons/km_kh.png"),
                        width: 30,
                        height: 30),
                    SizedBox(width: 10),
                    Text(
                      "ខ្មែរ",
                      textScaleFactor: 1.1,
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context, 'user01@gmail.com');
                  BlocProvider.of<LanguageBloc>(context)
                    ..add(
                      LanguageSelected(Language.KM),
                    );
                },
              ),
              SizedBox(
                height: 10,
              ),
              SimpleDialogOption(
                child: Row(
                  children: [
                    Image(
                        image: AssetImage("assets/icons/en_us.png"),
                        width: 30,
                        height: 30),
                    SizedBox(width: 10),
                    Text(
                      "English",
                      textScaleFactor: 1.1,
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context, 'user01@gmail.com');
                  BlocProvider.of<LanguageBloc>(context)
                    ..add(
                      LanguageSelected(Language.EN),
                    );
                },
              ),
            ],
          ));
  return showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xff999999),
                  width: 0.0,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                  child: Text(
                    AppLocalizations.of(context)!.translate("cancel"),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 5.0,
                  ),
                ),
                CupertinoButton(
                  child: Text(
                    AppLocalizations.of(context)!.translate("comfirm"),
                  ),
                  onPressed: () {
                    BlocProvider.of<LanguageBloc>(context)
                      ..add(
                        LanguageSelected(options[index]["code"]),
                      );
                    Navigator.of(context).pop();
                  },
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 5.0,
                  ),
                )
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height / 3,
              color: Color(0xfff7f7f7),
              child: CupertinoPicker(
                itemExtent: 50,
                children: options
                    .map((option) => Center(
                          child: Text(option["name"]),
                        ))
                    .toList(),
                onSelectedItemChanged: (indexx) {
                  index = indexx;
                },
              ))
        ],
      );
    },
  );
}
