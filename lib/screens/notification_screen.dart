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
        title: Text('Watchlist'),
        content: Text('$payload'),
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

            int hour = int.parse(formattedTime.substring(0, 2));

            int minute = int.parse(formattedTime.substring(3));
            print('timeformat $hour $minute');
            var notificationTime = Time(hour, minute, 00);

            await flutterLocalNotificationsPlugin.showDailyAtTime(
                0,
                'Your Assetlist Prices',
                message,
                notificationTime,
                platformChannelSpecifics,
                payload: message);
          }, locale: LocaleType.ko);
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
