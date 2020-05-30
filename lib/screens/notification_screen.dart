import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:money_alarm/models/notification_data.dart';
import 'package:money_alarm/widgets/notifications_list.dart';
import 'dart:collection';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
          DatePicker.showTimePicker(context,
              showTitleActions: true,
              showSecondsColumn: false, onConfirm: (time) {
            String formattedTime = DateFormat('kk:mm').format(time);
            print('confirm $formattedTime');
            Provider.of<NotificationData>(context, listen: false)
                .addNotification(formattedTime);
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
