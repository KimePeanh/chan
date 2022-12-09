import 'package:flutter/material.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/appLocalizations.dart';

Widget settingTile(context) => RaisedButton(
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => SettingPage(
        //             user: user,
        //           )),
        // );
        Navigator.pushNamed(context, setting);
      },
      elevation: 0,
      //color: Colors.grey[100],
      padding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 40,
              child: AspectRatio(
                aspectRatio: 1,
                child:
                    FittedBox(fit: BoxFit.fill, child: AnimatedSettingIcon()),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              flex: 60,
              child: Text(
                AppLocalizations.of(context)!.translate("setting"),
                textScaleFactor: 1.1,
                style: TextStyle(
                  // letterSpacing: 0.5,
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );

class AnimatedSettingIcon extends StatefulWidget {
  @override
  _AnimatedSettingIconState createState() => _AnimatedSettingIconState();
}

class _AnimatedSettingIconState extends State<AnimatedSettingIcon> {
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.settings);
  }
}
