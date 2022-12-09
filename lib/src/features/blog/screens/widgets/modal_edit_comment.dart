import 'package:flutter/material.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/blog/models/blog_comment.dart';

modalEditComment(
  BuildContext context,
  onSubmit(String text), {
  required BlogComment blogComment,
}) {
  final FocusNode focusNode = FocusNode();
  TextEditingController commentCtl = TextEditingController()
    ..text = blogComment.text;
  focusNode.requestFocus();

  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    isDismissible: true,
    builder: (context) => FractionallySizedBox(
      heightFactor: 0.9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 15),
          Center(
            child: Text(
              AppLocalizations.of(context)!.translate("edit"),
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 10),
          Divider(
            thickness: 2,
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
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
                          ? Icon(Icons.people_outline)
                          : Image(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(blogComment.user.profileImage),
                            ),
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextField(
                  maxLines: null,
                  focusNode: focusNode,
                  controller: commentCtl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    hintText:
                        AppLocalizations.of(context)!.translate("editComment"),
                    contentPadding: const EdgeInsets.only(
                        left: 15, bottom: 8, top: 8, right: 5),
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
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.grey[300],
                          primary: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.translate("cancel"),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        onSubmit(commentCtl.text);
                        focusNode.unfocus();
                        focusNode.dispose();
                      },
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Theme.of(context).primaryColor,
                          primary: Colors.white),
                      child: Text(
                        AppLocalizations.of(context)!.translate("update"),
                      ))
                ],
              ))
        ],
      ),
    ),
  );
}
