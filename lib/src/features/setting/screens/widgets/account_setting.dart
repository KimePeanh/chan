import 'package:flutter/material.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';

Widget accountSetting({required BuildContext context}) {
  tile(
      {required String title,
      required IconData iconData,
      required Function onPressed}) {
    return FlatButton(
      padding: EdgeInsets.all(15),
      color: Theme.of(context).buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      onPressed: () {
        onPressed();
      },
      child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    Icon(
                      iconData,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline1!.color,
                      ),
                    )
                  ],
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
              ])
            ],
          )),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            AppLocalizations.of(context)!.translate("accountSetting"),
            textScaleFactor: 1.2,
            style:
                TextStyle(color: Theme.of(context).textTheme.headline1!.color),
          )),
      SizedBox(height: 10),
      tile(
          title: AppLocalizations.of(context)!.translate("changeName"),
          iconData: Icons.label_outline,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => ChangeNamePage(
            //             token: user.accessToken,
            //           )),
            // );

            Helper.requiredLoginFuntion(
                context: context,
                callBack: () {
                  Navigator.pushNamed(
                    context,
                    changeName,
                  );
                });
          }),
      SizedBox(height: 5),
      tile(
          title: AppLocalizations.of(context)!.translate("changePassword"),
          iconData: Icons.vpn_key_outlined,
          onPressed: () {
            Helper.requiredLoginFuntion(
                context: context,
                callBack: () {
                  Navigator.pushNamed(context, changePassword);
                });
          }
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => ChangePasswordPage(user: user)),
          // );
          ),
    ],
  );
}
