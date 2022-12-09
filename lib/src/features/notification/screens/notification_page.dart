import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/notification/bloc/index.dart';
import 'package:lady_skin/src/features/notification/screens/widgets/notification_item_tile.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationBloc _notificationBloc = NotificationBloc();
  RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    _notificationBloc.add(InitializeNotification());
    super.initState();
  }

  @override
  void dispose() {
    _notificationBloc.close();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // backgroundColor: Theme.of(context).primaryColor,
        brightness: Brightness.light,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Notification",
          // AppLocalizations.of(context)!.translate("cart"),
          style: TextStyle(
            color: Colors.black,
          ),
          textScaleFactor: 1.2,
        ),
      ),
      body: SmartRefresher(
          onRefresh: () {
            _notificationBloc.add(InitializeNotification());
          },
          onLoading: () {
            _notificationBloc.add(FetchNotification());
          },
          enablePullDown: true,
          enablePullUp: true,
          controller: _refreshController,
          child: BlocConsumer(
            bloc: _notificationBloc,
            listener: (c, state) {
              if (state is FetchedNotification ||
                  state is ErrorFetchingNotification ||
                  state is ErrorInitializingNotification) {
                _refreshController.refreshCompleted();
                _refreshController.loadComplete();
              }
            },
            builder: (c, state) {
              return SingleChildScrollView(
                  child: BlocBuilder(
                bloc: _notificationBloc,
                builder: (c, state) {
                  if (_notificationBloc.notificationList.length == 0) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ErrorInitializingNotification) {
                    return Center(
                      child: TextButton(
                        onPressed: () {
                          _notificationBloc.add(FetchNotification());
                        },
                        child: Text("Retry"),
                      ),
                    );
                  } else {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _notificationBloc.notificationList
                            .map((data) =>
                                NotificationItemTile(notification: data))
                            .toList());
                  }
                },
              ));
            },
          )),
    );
  }
}
