import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lady_skin/src/features/account/bloc/index.dart';
import 'package:lady_skin/src/shared/bloc/file_pickup/index.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';

class InformationTile extends StatefulWidget {
  const InformationTile({Key? key}) : super(key: key);

  @override
  _InformationTileState createState() => _InformationTileState();
}

class _InformationTileState extends State<InformationTile> {
  FilePickupBloc _filePickupBloc = FilePickupBloc();
  AccountBloc accountBloc = AccountBloc();
  @override
  void dispose() {
    accountBloc.close();
    _filePickupBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      if (state is ErrorFetchingAccount) {
        Helper.handleState(state: state, context: context);
        //  Helper.handleState(state: state, context: context);
        BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
        return Center();
      } else if (state is FetchedAccount) {
        return Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(31000)),
                              child: BlocConsumer(
                                  bloc: accountBloc,
                                  builder: (c, state) {
                                    if (state is UpdatingAccount) {
                                      return Text("Uploading",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis);
                                    } else {
                                      return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: CachedNetworkImage(
                                          maxWidthDiskCache: 250,
                                          maxHeightDiskCache: 250,
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                          placeholder: (c, a) {
                                            return Center(
                                              child: Text("loading",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            );
                                          },
                                          imageUrl:
                                              BlocProvider.of<AccountBloc>(
                                                      context)
                                                  .state
                                                  .user!
                                                  .profileImage,
                                          errorWidget: (context, url, error) {
                                            return Icon(
                                              Icons.person_outlined,
                                              color: Colors.grey,
                                              size: 30,
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                  listener: (c, state) {
                                    if (state is UpdatedAccount ||
                                        state is ErrorUpdatingAccount) {
                                      BlocProvider.of<AccountBloc>(context)
                                          .add(FetchAccountStarted());
                                    }
                                  }))
                          // Text(
                          //   user.name[0],
                          //   textScaleFactor: 2,
                          //   style: TextStyle(fontWeight: FontWeight.bold),
                          // ),h
                          ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(100)),
                        // decoration: ,
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 20,
                        ))
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.user.name,
                        textScaleFactor: 1.3,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        // user.phone,
                        state.user.phone,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ))
            ],
          ),
        );
      } else {
        return Container(
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Center(child: CircularProgressIndicator()));
      }
    });
  }

  // @override
  // void dispose() {
  //   _filePickupBloc.close();
  //   super.dispose();
  // }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Library'),
                      onTap: () async {
                        Helper.imgFromGallery((image) async {
                          File? croppedFile = await ImageCropper.cropImage(
                              sourcePath: image.path,
                              aspectRatioPresets: Platform.isAndroid
                                  ? [
                                      CropAspectRatioPreset.square,
                                    ]
                                  : [
                                      CropAspectRatioPreset.square,
                                    ],
                              androidUiSettings: AndroidUiSettings(

                                  // toolbarTitle: 'Cropper',
                                  hideBottomControls: true,
                                  toolbarColor: Colors.deepOrange,
                                  toolbarWidgetColor: Colors.white,
                                  initAspectRatio:
                                      CropAspectRatioPreset.original,
                                  lockAspectRatio: true),
                              iosUiSettings:
                                  IOSUiSettings(aspectRatioLockEnabled: true
                                      // hide
                                      // title: 'Cropper',
                                      ));
                          accountBloc.add(UpdateAccount(
                              imageFile: croppedFile,
                              user: BlocProvider.of<AccountBloc>(context)
                                  .state
                                  .user!));
                          Navigator.of(context).pop();
                        });
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      Helper.imgFromCamera((image) {
                        accountBloc.add(UpdateAccount(
                            imageFile: image,
                            user: BlocProvider.of<AccountBloc>(context)
                                .state
                                .user!));
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}

Widget ienformationTile(context) =>
    BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      // Helper.handleState(state: state, context: context);
      if (state is ErrorFetchingAccount) {
        Helper.handleState(state: state, context: context);
        BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
        return Center();
      } else if (state is FetchedAccount) {
        return Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 3,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        radius: 30,
                        child: FittedBox(
                            child: Icon(
                          Icons.person,
                          color: Colors.red,
                        ))
                        // Text(
                        //   user.name[0],
                        //   textScaleFactor: 2,
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // ),
                        ),
                  )),
              SizedBox(width: 20),
              Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.user.name,
                        textScaleFactor: 1.3,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        // user.phone,
                        state.user.phone,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ))
            ],
          ),
        );
      } else {
        return Container(
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Center(child: CircularProgressIndicator()));
      }
    });
