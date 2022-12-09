import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lady_skin/src/features/account/models/contact.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

contactUsModal(BuildContext context, Contact contact) {
  _tile({
    required String title,
    required Function onTap,
    required IconData iconData,
  }) =>
      GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).buttonColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(iconData, color: Theme.of(context).primaryColor),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  title,
                  textScaleFactor: 0.9,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color),
                ),
              ),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ),
      );
  _cancelTile() => GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).buttonColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          width: double.infinity,
          child: Center(
            child: Text(
              "Cancel",
              textScaleFactor: 1.1,
              textAlign: TextAlign.start,
              style: TextStyle(
                  letterSpacing: 0.5, color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      );
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          margin: EdgeInsets.all(15),
          decoration: new BoxDecoration(
              color: Colors.transparent,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
              )),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              contact.phone1 == null
                  ? Center()
                  : Column(
                      children: [
                        _tile(
                            title: contact.phone1!,
                            iconData: Icons.call,
                            onTap: () {
                              launch("tel: ${contact.phone1}");
                            }),
                        Container(
                          width: double.infinity,
                          color: Colors.transparent,
                          height: 10,
                        ),
                      ],
                    ),
              contact.phone2 == null
                  ? Center()
                  : Column(
                      children: [
                        _tile(
                            title: contact.phone2!,
                            iconData: Icons.call,
                            onTap: () {
                              launch("tel: ${contact.phone2}");
                            }),
                        Container(
                          width: double.infinity,
                          color: Colors.transparent,
                          height: 10,
                        ),
                      ],
                    ),

              contact.phone3 == null
                  ? Center()
                  : Column(
                      children: [
                        _tile(
                            title: contact.phone3!,
                            iconData: Icons.call,
                            onTap: () {
                              launch("tel: ${contact.phone3}");
                            }),
                        Container(
                          width: double.infinity,
                          color: Colors.transparent,
                          height: 10,
                        ),
                      ],
                    ),

              // _tile(
              //     title: "(Smart) 096 256 3777",
              //     iconData: Icons.call,
              //     onTap: () {
              //       launch("tel: 0972563777 ");
              //     }),
              // Container(
              //   color: Colors.transparent,
              //   height: 10,
              // ),
              // _tile(
              //     title: "(Metfone) 097 456 9777",
              //     iconData: Icons.call,
              //     onTap: () {
              //       launch("tel: 0972563777 ");
              //     }),
              // Container(
              //   color: Colors.transparent,
              //   height: 10,
              // ),
              // _tile(
              //     title: "(Metfone) +855 16200181",
              //     iconData: MdiIcons.telegram,
              //     onTap: () {
              //       launch("https://t.me/ladyskincambodia");
              //     }),
              // Container(
              //   color: Colors.transparent,
              //   height: 10,
              // ),
              contact.facebook == null
                  ? Center()
                  : Column(
                      children: [
                        _tile(
                            title: "Visit facebook page",
                            iconData: MdiIcons.facebook,
                            onTap: () {
                              launch(contact.facebook!);
                            }),
                        Container(
                          width: double.infinity,
                          color: Colors.transparent,
                          height: 10,
                        ),
                      ],
                    ),

              // _tile(
              //     title: "Visit facebook page",
              //     iconData: MdiIcons.facebook,
              //     onTap: () {
              //       launch("https://www.facebook.com/ChamroeunPhalGroups");
              //     }),
              // Container(
              //   color: Colors.transparent,
              //   height: 10,
              // ),
              contact.email == null
                  ? Center()
                  : Column(
                      children: [
                        _tile(
                            title: contact.email!,
                            iconData: Icons.email_outlined,
                            onTap: () {
                              // launch(
                              // "https://www.facebook.com/ChamroeunPhalGroups");
                            }),
                        Container(
                          width: double.infinity,
                          color: Colors.transparent,
                          height: 10,
                        ),
                      ],
                    ),
              // _tile(
              //     title: "(email) charoeunphalnutrition@gmail.com",
              //     iconData: Icons.email_outlined,
              //     onTap: () {
              //       // launch("https://www.galaxycomputer168.com/");
              //     }),
              // Container(
              //   color: Colors.transparent,
              //   height: 10,
              // ),
              contact.website == null
                  ? Center()
                  : Column(
                      children: [
                        _tile(
                            title: contact.website!,
                            iconData: Icons.public,
                            onTap: () {
                              launch(contact.website!);
                            }),
                        Container(
                          width: double.infinity,
                          color: Colors.transparent,
                          height: 10,
                        ),
                      ],
                    ),
              contact.address == null
                  ? Center()
                  : Column(
                      children: [
                        _tile(
                            title: contact.address!,
                            iconData: Icons.home_outlined,
                            onTap: () {
                              // launch("https://www.chamroeunphal.com");
                            }),
                        Container(
                          width: double.infinity,
                          color: Colors.transparent,
                          height: 10,
                        ),
                      ],
                    ),
              // _tile(
              //     title: "(Website) www.chamroeunphal.com",
              //     iconData: Icons.public,
              //     onTap: () {
              //       launch("https://www.chamroeunphal.com");
              //     }),
              // Container(
              //   color: Colors.transparent,
              //   height: 10,
              // ),
              _cancelTile()
            ],
          ),
        );
      });
}
