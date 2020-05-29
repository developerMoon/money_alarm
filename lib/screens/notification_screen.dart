import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:money_alarm/models/notification_data.dart';
import 'package:money_alarm/models/notification_data.dart';
import 'dart:collection';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  static const id = 'notification_screen';
  NotificationData notificationData = NotificationData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DatePicker.showTime12hPicker(context, showTitleActions: true,
              onChanged: (time) {
            print('change $time');
          }, onConfirm: (time) {
            print('confirm $time');
            //notificationData.addNotification(time);
            Provider.of<NotificationData>(context, listen: false)
                .addNotification(time);
          }, currentTime: DateTime.now(), locale: LocaleType.en);
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: NotificationsList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationData>(
      builder: (context, notificationData, child) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                '${notificationData.notifications[index]}',
              ),
            );
          },
          itemCount: notificationData.notificationCount,
        );
      },
    );
  }
}
