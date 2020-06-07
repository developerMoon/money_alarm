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
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectedNotification);
  }

  Future onSelectedNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Asset List'),
        content: Text('Your Asset Selection : $payload'),
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
          var time = Time(14, 34, 0);
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

//          await flutterLocalNotificationsPlugin.showDailyAtTime(
//              0,
//              'show daily title',
//              'Daily notification shown at approximately ${time.toString()}',
//              time,
//              platformChannelSpecifics);
//
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
