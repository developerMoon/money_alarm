import 'package:flutter/material.dart';
import 'package:money_alarm/database/database.dart';
import 'package:money_alarm/models/asset_data.dart';
import 'package:money_alarm/screens/notification_screen.dart';
import 'package:money_alarm/screens/add_asset_screen.dart';
import 'package:money_alarm/widgets/assets_list.dart';
import 'package:provider/provider.dart';
import 'package:finance_quote/finance_quote.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:money_alarm/models/asset.dart';

class DashBoardScreen extends StatefulWidget {
  static const id = 'dashboard_screen';

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

//class Notification{

//}

class _DashBoardScreenState extends State<DashBoardScreen> {
  AssetData assetData = AssetData();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    super.initState();
    Provider.of<AssetData>(context, listen: false).setAssetPrice(context);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('app_icon');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectedNotification);
  }

  Future onSelectedNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Your payload'),
        content: Text('payload? : $payload'),
      ),
    );
  }

  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 13, top: 8),
                    child: Text(
                      'Watchlist',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Container(
                      padding: EdgeInsets.only(left: 13, top: 8),
                      child: Icon(
                        Icons.add,
                        color: Colors.grey,
                      ),
                    ),
                    onPressed: () async {
                      await _showNotification();
//                    FlutterLocalNotificationsPlugin
//                        flutterLocalNotificationsPlugin =
//                        FlutterLocalNotificationsPlugin();
//                    var initializationSettingsAndroid =
//                        AndroidInitializationSettings('app_icon');
//                    var initializationSettingsIOS = IOSInitializationSettings(
//                      requestSoundPermission: false,
//                      requestBadgePermission: false,
//                      requestAlertPermission: false,
//                      //onDidReceiveLocalNotification: onSelectNotification,
//                    );
//                    var initializationSettings = InitializationSettings(
//                        initializationSettingsAndroid,
//                        initializationSettingsIOS);
//                    await flutterLocalNotificationsPlugin
//                        .initialize(initializationSettings,
//                            onSelectNotification: (String payload) async {
//                      if (payload != null) {
//                        debugPrint('notification payload: ' + payload);
//                      }
//                      //selectNotificationSubject.add(payload);
//                    });
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Container(
                      padding: EdgeInsets.only(left: 13, top: 8),
                      child: Icon(
                        Icons.refresh,
                        color: Colors.grey,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<AssetData>(context, listen: false)
                          .setAssetPrice(context);
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: AssetsList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    child: Text('Add Asset'),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => AddAssetScreen(),
                      );
                    }),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  child: Text('Notification'),
                  onPressed: () async {
                    Navigator.pushNamed(context, NotificationScreen.id);
                    Future<Asset> selectData =
                        await DBProvider.db.getAssetDB('TSLA');

                    //print('select from db: ${selectData.fromMap}');
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(left: 13, top: 8),
                child: Text(
                  'News',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Container(
                    height: 50,
                    color: Colors.amber[600],
                    child: const Center(child: Text('USD')),
                  ),
                  Container(
                    height: 50,
                    color: Colors.amber[500],
                    child: const Center(child: Text('S&P')),
                  ),
                  Container(
                    height: 50,
                    color: Colors.amber[100],
                    child: const Center(child: Text('WTI')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
