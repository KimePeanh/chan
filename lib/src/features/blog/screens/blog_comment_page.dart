import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/account/bloc/index.dart';
import 'package:lady_skin/src/features/authentication/bloc/index.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_comment/blog_comment_event.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_comment/blog_comment_bloc.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_comment/blog_comment_state.dart';
import 'package:lady_skin/src/features/blog/models/blog.dart';
import 'package:lady_skin/src/features/blog/models/blog_comment.dart';
import 'package:lady_skin/src/shared/widgets/error_snackbar.dart';
import 'package:lady_skin/src/shared/widgets/loading_dialogs.dart';
import 'package:lady_skin/src/shared/widgets/login_button.dart';
import 'package:lady_skin/src/shared/widgets/register_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/modal_edit_comment.dart';

class BlogCommentPage extends StatefulWidget {
  final Blog blog;
  BlogCommentPage({required this.blog});

  @override
  _BlogCommentPageState createState() => _BlogCommentPageState();
}

class _BlogCommentPageState extends State<BlogCommentPage> {
  late BlogCommentBloc blogCommentBloc;
  TextEditingController commentCtl = TextEditingController();
  final _refreshController = RefreshController();
  final _controller = ScrollController();
  final _focusNode = FocusNode();
  @override
  void initState() {
    blogCommentBloc = BlogCommentBloc(blogId: widget.blog.id)
      ..add(InitializeCommentList());
    super.initState();
  }

  @override
  void dispose() {
    blogCommentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Theme.of(context).primaryColor,
        brightness: Brightness.dark,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.translate("comment"),
          // AppLocalizations.of(context)!.translate("cart"),
          style: TextStyle(
            color: Colors.white,
          ),
          textScaleFactor: 1.2,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SmartRefresher(
              scrollController: _controller,
              controller: _refreshController,
              enablePullUp: true,
              enablePullDown: true,
              onRefresh: () {
                blogCommentBloc.add(InitializeCommentList());
              },
              onLoading: () {
                blogCommentBloc.add(FetchCommentList());
              },
              child: SingleChildScrollView(
                // controller: _controller,
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: ExtendedImage.network(widget.blog.thumbnail,
                          errorWidget: Image.asset(
                              "assets/images/product_placeholder.jpg"),
                          enableMemoryCache: true,
                          clearMemoryCacheWhenDispose: true,
                          clearMemoryCacheIfFailed: false,
                          fit: BoxFit.cover,
                          cache: true,
                          width: 350,
                          cacheHeight: 350),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: BlocConsumer(
                        bloc: blogCommentBloc,
                        listener: (c, state) {
                          if (state is FetchedCommentList) {
                            _refreshController.loadComplete();
                            _refreshController.refreshCompleted();
                            if (blogCommentBloc.isEndofList) {
                              _refreshController.loadNoData();
                            }
                          }
                          if (state is ErrorFetchingCommentList) {
                            _refreshController.refreshCompleted();
                            _refreshController.loadFailed();
                          }
                          if (state is ProcessingComment) {
                            loadingDialogs(context);
                          } else if (state is ProcessedComment) {
                            Navigator.pop(context);
                          } else if (state is ErrorProcessingComment) {
                            Navigator.pop(context);
                            errorSnackBar(
                                text: state.error.toString(), context: context);
                          } else if (state is AddedComment) {
                            _controller.animateTo(
                              _controller.position.maxScrollExtent,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 500),
                            );
                          }
                        },
                        builder: (c, state) {
                          log(state.toString());
                          if (blogCommentBloc.blogCommentList.length == 0) {
                            if (state is InitializingCommentList) {
                              return Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 50),
                                child: TextButton(
                                  onPressed: () {},
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else if (state is ErrorFetchingCommentList) {
                              return Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 50),
                                child: TextButton(
                                  onPressed: () {
                                    blogCommentBloc
                                        .add(InitializeCommentList());
                                  },
                                  child: Text("Retry"),
                                ),
                              );
                            } else {
                              return Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 50),
                                  child: Text("Empty",
                                      style: TextStyle(color: Colors.grey)));
                            }
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    blogCommentBloc.blogCommentList.length,
                                itemBuilder: (c, i) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: commentItemTile(
                                      blogComment:
                                          blogCommentBloc.blogCommentList[i],
                                    ),
                                  );
                                });
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (c, state) {
              if (state is Authenticated) {
                // return Container();
                return Row(
                  children: [
                    Expanded(
                        child: TextField(
                      focusNode: _focusNode,
                      controller: commentCtl,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: AppLocalizations.of(context)!
                            .translate("addComment"),
                        contentPadding:
                            const EdgeInsets.only(left: 15, bottom: 0, top: 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                      ),
                    )),
                    SizedBox(width: 15),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(18)),
                      child: IconButton(
                          icon: Icon(
                            Icons.comment,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (commentCtl.text.isNotEmpty) {
                              _focusNode.unfocus();
                              blogCommentBloc
                                  .add(AddComment(text: commentCtl.text));
                              commentCtl.clear();
                            }
                          }),
                    ),
                  ],
                );
              } else {
                // return Container();
                return Column(
                  children: [
                    Divider(),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(child: loginButton(context: context)),
                        SizedBox(width: 10),
                        Text('Or'),
                        SizedBox(width: 10),
                        Expanded(child: registerButton(context: context)),
                      ],
                    ),
                  ],
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  commentItemTile({required BlogComment blogComment}) {
    return GestureDetector(
      onLongPress: () {
        modalCommentAction(context, blogComment: blogComment);
      },
      child: Container(
        width: double.infinity,
        color: Colors.red.withOpacity(0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Colors
                        .grey[300]!, //                   <--- border color
                    width: 1,
                  ),
                ),
                width: 50,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: blogComment.user.profileImage == ""
                      ? Icon(Icons.person_outline)
                      : Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(blogComment.user.profileImage),
                        ),
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          blogComment.user.name,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${blogComment.text}",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "${blogComment.date}",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  modalCommentAction(BuildContext context, {required BlogComment blogComment}) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      isDismissible: true,
      builder: (context) => WillPopScope(
        onWillPop: () async => true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // titleWidget ??
              //     Text(
              //       title,
              //       textAlign: TextAlign.left,
              //       style: Theme.of(context).textTheme.headline2,
              //     ),
              // SizedBox(height: 0),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Clipboard.setData(new ClipboardData(text: blogComment.text))
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Copied to clipboard"),
                      duration: Duration(milliseconds: 1000),
                    ));
                  });
                },
                child: Container(
                  color: Colors.red.withOpacity(0),
                  child: Row(
                    children: [
                      Icon(Icons.copy),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        AppLocalizations.of(context)!.translate("copy"),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              BlocProvider.of<AccountBloc>(context).state.user != null &&
                      (BlocProvider.of<AccountBloc>(context).state.user!.id ==
                          blogComment.user.id)
                  ? Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            modalEditComment(context, (text) {
                              print("text");
                              Navigator.pop(context);
                              Navigator.pop(context);
                              blogCommentBloc.add(EditComment(
                                  blogComment: blogComment, text: text));
                            }, blogComment: blogComment);
                          },
                          child: Container(
                            color: Colors.red.withOpacity(0),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Icon(Icons.edit_outlined),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate("edit"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            blogCommentBloc
                                .add(DeleteComment(comment: blogComment));
                          },
                          child: Container(
                            color: Colors.red.withOpacity(0),
                            child: Row(
                              children: [
                                Icon(Icons.delete_outlined),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate("delete"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center()

              // contentWidget ??
              //     Text(
              //       content,
              //       textAlign: TextAlign.left,
              //       style: Theme.of(context)
              //           .textTheme
              //           .bodyText2
              //           .copyWith(height: 1.5),
              //     ),
              // SizedBox(height: 20),
              // if (actions != null)
              //   ...actions
              // else
              //   OutlineButton(
              //     child: Text('GOT IT!'),
              //     borderSide: BorderSide(color: theme.primaryColor),
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
