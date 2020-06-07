import 'package:flutter/material.dart';
import 'package:money_alarm/database/asset_bloc.dart';
import 'package:money_alarm/models/asset_data.dart';
import 'package:money_alarm/models/notification_data.dart';
import 'package:money_alarm/screens/dashboard_screen.dart';
import 'package:money_alarm/screens/notification_screen.dart';
import 'package:provider/provider.dart';
import 'package:money_alarm/models/asset.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AssetBloc>(create: (context) => AssetBloc()),
    ChangeNotifierProvider<NotificationData>(
        create: (context) => NotificationData()),
  ], child: MoneyAlarm()));
}

class MoneyAlarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: DashBoardScreen.id,
      routes: {
        DashBoardScreen.id: (context) => DashBoardScreen(),
        NotificationScreen.id: (context) => NotificationScreen(),
      },
      theme: ThemeData.dark(),
    );
  }
}
