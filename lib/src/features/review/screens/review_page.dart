import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/authentication/bloc/authentication_bloc.dart';
import 'package:lady_skin/src/features/authentication/bloc/authentication_state.dart';
import 'package:lady_skin/src/features/product/models/product.dart';
import 'package:lady_skin/src/features/review/bloc/review_bloc.dart';
import 'package:lady_skin/src/features/review/bloc/review_event.dart';
import 'package:lady_skin/src/features/review/bloc/review_state.dart';
import 'package:lady_skin/src/features/review/repositories/review_list_repository.dart';
import 'package:lady_skin/src/features/review/screens/widgets/review_tile.dart';
import 'package:lady_skin/src/shared/widgets/standard_appbar.dart';

import 'widgets/modal_add_review.dart';
import 'widgets/modal_edit_review.dart';

class ReviewPage extends StatelessWidget {
  final Product product;
  ReviewPage({required this.product});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return BlocProvider(
            create: (BuildContext context) =>
                ReviewBloc(reviewListRepository: ReviewListWithAuthRepo())
                  ..add(InitializeReviewList(arg: product.id)),
            child: ReviewPageBody(
              product: product,
            ),
          );
        } else {
          return BlocProvider(
            create: (BuildContext context) =>
                ReviewBloc(reviewListRepository: ReviewListWithoutAuthRepo())
                  ..add(InitializeReviewList(arg: product.id)),
            child: ReviewPageBody(
              product: product,
            ),
          );
        }
      },
    );
  }
}

class ReviewPageBody extends StatelessWidget {
  final Product product;
  ReviewPageBody({required this.product});
  final RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, kToolbarHeight),
            child: standardAppBar(
                context, AppLocalizations.of(context)!.translate("review"))),
        body: BlocListener<ReviewBloc, ReviewState>(
          listener: (context, state) {
            if (state is InitializedReviewList || state is FetchedReviewList) {
              _refreshController.loadComplete();
              _refreshController.refreshCompleted();
            }
            if (state is EndOfReviewList) {
              _refreshController.loadNoData();
            }
          },
          child: Column(
            children: [
              Expanded(
                child: SmartRefresher(
                    // footer: Text("jhj"),
                    // // cacheExtent: 500,
                    physics: AlwaysScrollableScrollPhysics(),
                    onRefresh: () {
                      BlocProvider.of<ReviewBloc>(context)
                          .add(InitializeReviewList(arg: product.id));
                    },
                    onLoading: () {
                      if (BlocProvider.of<ReviewBloc>(context).state
                          is EndOfReviewList) {
                      } else {
                        BlocProvider.of<ReviewBloc>(context)
                            .add(FetchReviewList(arg: product.id));
                      }
                    },
                    enablePullDown: true,
                    enablePullUp: true,
                    controller: _refreshController,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          BlocBuilder<ReviewBloc, ReviewState>(
                            builder: (context, state) {
                              if (state is InitializingReviewList &&
                                  BlocProvider.of<ReviewBloc>(context)
                                          .reviewList
                                          .length ==
                                      0) {
                                return Center();
                              } else if (state is ErrorInitializingReviewList) {
                                Helper.handleState(
                                    state: state, context: context);
                                return Center(
                                    child: FlatButton(
                                  onPressed: () {},
                                  child: Text("Retry"),
                                ));
                              }

                              return Column(
                                children: [
                                  BlocProvider.of<ReviewBloc>(context)
                                              .myReview ==
                                          null
                                      ? Container()
                                      : reviewTile(
                                          BlocProvider.of<ReviewBloc>(context)
                                              .myReview!,
                                          currentUserReviewed: true),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          BlocProvider.of<ReviewBloc>(context)
                                              .reviewList
                                              .length,
                                      itemBuilder: (context, index) {
                                        if (BlocProvider.of<ReviewBloc>(context)
                                                .myReview ==
                                            null) {
                                          return reviewTile(
                                              BlocProvider.of<ReviewBloc>(
                                                      context)
                                                  .reviewList[index]);
                                        } else {
                                          var id = BlocProvider.of<ReviewBloc>(
                                                  context)
                                              .myReview!
                                              .id;

                                          if (BlocProvider.of<ReviewBloc>(
                                                      context)
                                                  .reviewList[index]
                                                  .id ==
                                              id) {
                                            return Container();
                                          } else {
                                            return reviewTile(
                                                BlocProvider.of<ReviewBloc>(
                                                        context)
                                                    .reviewList[index]);
                                          }
                                        }
                                      }),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    )),
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                if (state is Authenticated) {
                  return BlocBuilder<ReviewBloc, ReviewState>(
                    builder: (context, state) {
                      if (BlocProvider.of<ReviewBloc>(context).canAdd ==
                          "false") {
                        if (BlocProvider.of<ReviewBloc>(context).myReview ==
                            null) {
                          return Container();
                        } else {
                          return GestureDetector(
                            onTap: () {
                              modalEditReview(context,
                                  review: BlocProvider.of<ReviewBloc>(context)
                                      .myReview!,
                                  productId: product.id,
                                  reviewBloc:
                                      BlocProvider.of<ReviewBloc>(context),
                                  onCompleted: () {
                                BlocProvider.of<ReviewBloc>(context)
                                    .add(InitializeReviewList(arg: product.id));
                              });
                            },
                            child: Container(
                              color: Colors.red.withOpacity(0),
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 15, bottom: 20),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate("editReview"),
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                                textScaleFactor: 1,
                              ),
                            ),
                          );
                        }
                      } else {
                        return (BlocProvider.of<ReviewBloc>(context).myReview ==
                                null)
                            ? GestureDetector(
                                onTap: () {
                                  modalAddReview(context,
                                      productId: product.id,
                                      reviewBloc:
                                          BlocProvider.of<ReviewBloc>(context),
                                      onCompleted: () {
                                    BlocProvider.of<ReviewBloc>(context).add(
                                        InitializeReviewList(arg: product.id));
                                  });
                                },
                                child: Container(
                                  color: Colors.red.withOpacity(0),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(top: 15, bottom: 20),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .translate("writeReview"),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                    textScaleFactor: 1,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  modalAddReview(context,
                                      productId: product.id,
                                      reviewBloc:
                                          BlocProvider.of<ReviewBloc>(context),
                                      onCompleted: () {
                                    BlocProvider.of<ReviewBloc>(context).add(
                                        InitializeReviewList(arg: product.id));
                                  });
                                },
                                child: Container(
                                  color: Colors.red.withOpacity(0),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(top: 15, bottom: 20),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .translate("editReview"),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                    textScaleFactor: 1,
                                  ),
                                ),
                              );
                      }
                      // if ((state is FetchedReviewList ||
                      //     state is InitializedReviewList ||
                      //     state is EndOfReviewList)) {
                      //   return (BlocProvider.of<ReviewBloc>(context).myReview ==
                      //           null)
                      //       ? GestureDetector(
                      //           onTap: () {
                      //             modalAddReview(context,
                      //                 productId: product.id,
                      //                 reviewBloc:
                      //                     BlocProvider.of<ReviewBloc>(context),
                      //                 onCompleted: () {
                      //               BlocProvider.of<ReviewBloc>(context).add(
                      //                   InitializeReviewList(arg: product.id));
                      //             });
                      //           },
                      //           child: Container(
                      //             color: Colors.red.withOpacity(0),
                      //             alignment: Alignment.center,
                      //             padding: EdgeInsets.only(top: 15, bottom: 20),
                      //             child: Text(
                      //               "Write a review",
                      //               style: TextStyle(
                      //                   color: Colors.blue,
                      //                   fontWeight: FontWeight.bold),
                      //               textScaleFactor: 1,
                      //             ),
                      //           ),
                      //         )
                      //       : Container(
                      //           color: Colors.red.withOpacity(0),
                      //           alignment: Alignment.center,
                      //           padding: EdgeInsets.only(top: 15, bottom: 20),
                      //           child: Text(
                      //             "Edit your review",
                      //             style: TextStyle(
                      //                 color: Colors.blue,
                      //                 fontWeight: FontWeight.bold),
                      //             textScaleFactor: 1,
                      //           ),
                      //         );
                      // } else
                      //   return Container();
                    },
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ));
  }
}
