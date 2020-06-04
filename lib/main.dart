import 'package:flutter/material.dart';
import 'package:money_alarm/models/asset_data.dart';
import 'package:money_alarm/models/notification_data.dart';
import 'package:money_alarm/screens/dashboard_screen.dart';
import 'package:money_alarm/screens/notification_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MoneyAlarm());

class MoneyAlarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //ChangeNotifierProvider<AssetData>(create: (context) => AssetData()),
        ChangeNotifierProvider<NotificationData>(
            create: (context) => NotificationData()),
      ],
      child: MaterialApp(
        initialRoute: DashBoardScreen.id,
        routes: {
          DashBoardScreen.id: (context) => DashBoardScreen(),
          NotificationScreen.id: (context) => NotificationScreen(),
        },
      ),
    );
  }
}
