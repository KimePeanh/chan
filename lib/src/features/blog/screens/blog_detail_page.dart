import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:lady_skin/src/features/blog/bloc/bloc_detail/blog_detail_bloc.dart';
import 'package:lady_skin/src/features/blog/bloc/bloc_detail/blog_detail_event.dart';
import 'package:lady_skin/src/features/blog/bloc/bloc_detail/blog_detail_state.dart';
import 'package:lady_skin/src/features/blog/models/blog.dart';
import 'package:lady_skin/src/shared/bloc/indexing/index.dart';
import 'package:lady_skin/src/shared/widgets/error_snackbar.dart';
import 'blog_comment_page.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:webview_flutter/webview_flutter.dart';

// import 'package:webview_flutter_plus/webview_flutter_plus.dart';
class BlogDetailPageWrapper extends StatefulWidget {
  final dynamic blogOrId;
  BlogDetailPageWrapper({required this.blogOrId});

  @override
  _BlogDetailPageWrapperState createState() => _BlogDetailPageWrapperState();
}

class _BlogDetailPageWrapperState extends State<BlogDetailPageWrapper> {
  final BlogDetailBloc blogDetailBloc = BlogDetailBloc();
  @override
  void dispose() {
    blogDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.blogOrId is Blog) {
      return BlogDetailPage(
        blog: widget.blogOrId,
      );
    } else {
      blogDetailBloc.add(FetchBlogDetail(blogId: widget.blogOrId));
      return BlocConsumer(
          bloc: blogDetailBloc,
          listener: (c, state) {
            if (state is ErrorFetchingBlogDetail) {
              errorSnackBar(text: state.error.toString(), context: context);
            }
          },
          builder: (c, state) {
            if (state is ErrorFetchingBlogDetail) {
              return Scaffold(
                body: Center(
                  child: TextButton(
                    onPressed: () {
                      blogDetailBloc
                          .add(FetchBlogDetail(blogId: widget.blogOrId));
                    },
                    child: Text("Retry"),
                  ),
                ),
              );
            } else if (state is FetchedBlogDetail) {
              return BlogDetailPage(
                blog: state.blog,
              );
            } else {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          });
    }
  }
}

class BlogDetailPage extends StatefulWidget {
  final Blog blog;
  BlogDetailPage({required this.blog});

  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  IndexingBloc indexingBloc = IndexingBloc();
  //late WebViewController _webViewController;
  late String finalHtmlString;
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));
  @override
  void initState() {
    super.initState();
    var document = parse(widget.blog.content);
    var elements = document.getElementsByTagName("iframe");
    log(document.outerHtml);
    print(elements.length);
    elements.asMap().forEach((i, element) {
      var a = parse("<div></div>");
      var iframeWrapper = a.createElement('div');
      iframeWrapper.classes.add("intrinsic-container");
      iframeWrapper.classes.add("intrinsic-container-16x9");
      iframeWrapper.innerHtml =
          document.getElementsByTagName("iframe")[i].outerHtml;
      document.getElementsByTagName("iframe")[i].replaceWith(iframeWrapper);
    });
    var imageElements = document.getElementsByTagName("img");
    imageElements.asMap().forEach((i, element) {
      document.getElementsByTagName("img")[i].attributes["width"] = "100%";
      document.getElementsByTagName("img")[i].attributes["height"] = "";
    });
    log("widget.blog.content ${widget.blog.content}");
    log("document.outerHtml ${document.outerHtml}");
    finalHtmlString = """
    <html>
      <head>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
         video {
          height: auto;
          width: 100%;
          object-fit: contain; // use "cover" to avoid distortion
        }
        p {
          word-break: break-all;
            line-height: 25px !important;
        }
        .intrinsic-container-16x9 {
            padding-bottom: 56.25%;
        }
        a {
          word-break: break-all;
        }
        .intrinsic-container iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
        .intrinsic-container {
            position: relative;
            height: 0;
            overflow: hidden;
        }
        </style>
      </head>
      
      <body>
      ${document.outerHtml}</body>
    </html>
    """;
    // Enable hybrid composition.
    // if (Platform.isAndroid) WebView.pl
    //atform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    indexingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.blog.content.split("gotourl").length == 3) {
      log("notEmpty");
    }
    log(finalHtmlString);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      floatingActionButton: SizedBox(
          width: 55,
          height: 55,
          child: FloatingActionButton(
              tooltip: "comment",
              elevation: 5,
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (c) => BlogCommentPage(
                          blog: widget.blog,
                        )));
              },
              child: Icon(Icons.comment, color: Colors.blue))),
      body: InAppWebView(
        // key: webViewKey,
        initialUrlRequest: URLRequest(
            url: (widget.blog.content.split("gotourl").length == 3)
                ? Uri.parse(widget.blog.content.split("gotourl")[1])
                : Uri.dataFromString(finalHtmlString,
                    mimeType: 'text/html',
                    encoding: Encoding.getByName('utf-8'))),
        initialOptions: options,
        // pullToRefreshController: pullToRefreshController,
        onWebViewCreated: (controller) async {
          // await Future.delayed(Duration(milliseconds: 200));
          indexingBloc.add(Taped(index: 1));
          // webViewController = controller;

          // webViewController!.loadData(data: finalHtmlString);
        },
        // onLoadStart: (controller, url) {
        //   setState(() {
        //     this.url = url.toString();
        //     urlController.text = this.url;
        //   });
        // },
        androidOnPermissionRequest: (controller, origin, resources) async {
          return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT);
        },
        // shouldOverrideUrlLoading: (controller, navigationAction) async {
        //   var uri = navigationAction.request.url!;

        //   if (![ "http", "https", "file", "chrome",
        //     "data", "javascript", "about"].contains(uri.scheme)) {
        //     if (await canLaunch(url)) {
        //       // Launch the App
        //       await launch(
        //         url,
        //       );
        //       // and cancel the request
        //       return NavigationActionPolicy.CANCEL;
        //     }
        //   }

        //   return NavigationActionPolicy.ALLOW;
        // },
      ),
      // WebView(

      //   // initialUrl: Uri.dataFromString(widget.htmlString, mimeType: 'text/html')
      //   //     .toString(),
      //   javascriptMode: JavascriptMode.unrestricted,
      //   initialUrl: '',
      //   onWebViewCreated: (WebViewController webViewController) async {
      //     _webViewController = webViewController;
      //     _webViewController.loadUrl(Uri.dataFromString(widget.htmlString,
      //             mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
      //         .toString());
      //   },
      // ),
    );
  }
}
