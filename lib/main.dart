import 'package:flutter/material.dart';
import 'package:money_alarm/screens/dashboard_screen.dart';
import 'package:money_alarm/screens/notification_screen.dart';

void main() => runApp(MoneyAlarm());

class MoneyAlarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: DashBoardScreen.id,
      routes: {
        DashBoardScreen.id: (context) => DashBoardScreen(),
        NotificationScreen.id: (context) => NotificationScreen(),
      },
    );
  }
}
