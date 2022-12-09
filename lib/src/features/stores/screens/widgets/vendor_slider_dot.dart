import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/shared/bloc/indexing/index.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';

class VendorSliderDot extends StatefulWidget {
  final int dotQty;
  VendorSliderDot({required this.dotQty});
  @override
  _VendorSliderDotState createState() => _VendorSliderDotState();
}

class _VendorSliderDotState extends State<VendorSliderDot> {
  List dots = [];
  @override
  void initState() {
    dots = List.generate(widget.dotQty, (index) => index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndexingBloc, int>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dots
              .map((e) => e == state
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(searchBarBorderRadius))),
                      width: 20,
                      height: 5,
                      margin: EdgeInsets.only(right: 5),
                    )
                  : Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(searchBarBorderRadius))),
                      margin: EdgeInsets.only(right: 5),
                    ))
              .toList(),
        );
      },
    );
  }
}
