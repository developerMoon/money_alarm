import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:money_alarm/database/database.dart';
import 'package:money_alarm/models/notification_data.dart';
import 'package:money_alarm/widgets/notifications_list.dart';
import 'dart:collection';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:money_alarm/database/asset_bloc.dart';
import 'package:money_alarm/models/asset.dart';
import 'package:flutter/cupertino.dart';

class NotificationScreen extends StatefulWidget {
  static const id = 'notification_screen';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationData notificationData = NotificationData();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final bloc = AssetBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var android = AndroidInitializationSettings('@mipmap/money_icon');
    var iOS = IOSInitializationSettings(
//        requestAlertPermission: false,
//        requestBadgePermission: false,
//        requestSoundPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initSettings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectedNotification);
    requestPermission();
  }

  requestPermission() async {
    var result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future onSelectedNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Watchlist'),
        content: Text('$payload'),
      ),
    );
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
//              Navigator.of(context, rootNavigator: true).pop();
//              await Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => SecondScreen(payload),
//                ),
//              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //var time = Time(14, 34, 0);
          var androidPlatformChannelSpecifics = AndroidNotificationDetails(
              'repeatDailyAtTime channel id',
              'repeatDailyAtTime channel name',
              'repeatDailyAtTime description');
          var iOSPlatformChannelSpecifics = IOSNotificationDetails();
          var platformChannelSpecifics = NotificationDetails(
              androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

          DatePicker.showTimePicker(context,
              showTitleActions: true,
              showSecondsColumn: false, onConfirm: (time) async {
            String formattedTime = DateFormat('kk:mm').format(time);
            print('confirm $formattedTime');
            Provider.of<NotificationData>(context, listen: false)
                .addNotification(formattedTime);

            String message = await DBProvider.db.getAssetListPricesDB();
            print('messasge in notification: $message');
            await flutterLocalNotificationsPlugin.show(
                0, 'Your Assetlist Prices', message, platformChannelSpecifics,
                payload: message);
          }, locale: LocaleType.ko);

          var time = Time(22, 12, 30);

          await flutterLocalNotificationsPlugin.showDailyAtTime(
              0,
              'show daily title',
              'Daily notification shown at approximately $time}',
              time,
              platformChannelSpecifics);
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: NotificationsList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
