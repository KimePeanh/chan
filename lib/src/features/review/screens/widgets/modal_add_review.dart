import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/review/bloc/review_bloc.dart';
import 'package:lady_skin/src/features/review/bloc/review_event.dart';
import 'package:lady_skin/src/features/review/bloc/review_state.dart';
import 'package:lady_skin/src/shared/widgets/custom_dialog.dart';
import 'package:lady_skin/src/shared/widgets/loading_dialogs.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';

modalAddReview(BuildContext context,
    {required String productId,
    required ReviewBloc reviewBloc,
    required Function onCompleted}) {
  double? star;
  double bottomInsets = MediaQuery.of(context).viewInsets.bottom;
  TextEditingController _commentCtl = TextEditingController();
  _commentCtl.text = "";
  return showMaterialModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () {
        onCompleted();
        return Future.sync(() => true);
      },
      child: BlocListener(
        bloc: reviewBloc,
        listener: (context, state) {
          if (state is AddingReview) {
            loadingDialogs(context);
          }
          if (state is AddedReview) {
            onCompleted();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
          if (state is ErrorAddingReview) {
            Helper.handleState(state: state, context: context);
            Navigator.of(context).pop();
            customDialog(context, "", Text(state.error), () {});
          }
        },
        child: Scaffold(
          appBar: AppBar(
            brightness: Theme.of(context).brightness,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
                onCompleted();
              },
              icon: Icon(Icons.clear),
            ),
          ),
          body: Form(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(children: [
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .translate("yourRate?"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 1.3,
                          ),
                          SizedBox(height: 15),
                          FittedBox(
                            child: RatingBar.builder(
                              itemPadding: EdgeInsets.all(0),
                              unratedColor: Colors.grey[300],
                              initialRating: double.parse(0.toString()),
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                star = rating;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Center(),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .translate("plsShareOpinion"),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.3,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextField(
                            scrollPadding:
                                EdgeInsets.only(bottom: bottomInsets + 40.0),
                            decoration: InputDecoration(
                              // hintText: 'Reply',
                              labelText: AppLocalizations.of(context)!
                                  .translate("writeOpinion"),
                            ),
                            // autofocus: false,
                            // focusNode: _focusnode,
                            maxLines: null,
                            controller: _commentCtl,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ])),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 25),
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(standardBorderRadius)),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (star == null) {
                        customDialog(
                            context,
                            "",
                            Text(AppLocalizations.of(context)!
                                .translate("plsRate")),
                            () {});
                      } else {
                        reviewBloc.add(AddReview(
                            productId: productId,
                            star: star!,
                            comment: _commentCtl.text));
                      }
                    },
                    child: Text(
                        AppLocalizations.of(context)!
                            .translate("sendReview")
                            .toUpperCase(),
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
