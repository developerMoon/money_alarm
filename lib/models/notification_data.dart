import 'package:flutter/cupertino.dart';
import 'dart:collection';

class NotificationData extends ChangeNotifier {
  List<DateTime> _notifications = [
    DateTime.now(),
  ];
  UnmodifiableListView<DateTime> get notifications {
    return UnmodifiableListView(_notifications);
  }

  void addNotification(DateTime time) {
    _notifications.add(time);
    notifyListeners();
  }

  int get notificationCount {
    return _notifications.length;
  }
}
