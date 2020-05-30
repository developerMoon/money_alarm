import 'package:flutter/cupertino.dart';
import 'dart:collection';

class NotificationData extends ChangeNotifier {
  List<String> _notifications = [];

  UnmodifiableListView<String> get notifications {
    return UnmodifiableListView(_notifications);
  }

  void addNotification(String time) {
    _notifications.add(time);
    notifyListeners();
  }

  int get notificationCount {
    return _notifications.length;
  }
}
