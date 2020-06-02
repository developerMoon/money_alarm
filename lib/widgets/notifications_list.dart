import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:money_alarm/models/notification_data.dart';

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
              onLongPress: () {
                notificationData.deletNotification(index);
              },
            );
          },
          itemCount: notificationData.notificationCount,
        );
      },
    );
  }
}
