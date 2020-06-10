import 'package:flutter/material.dart';
import 'package:money_alarm/database/database.dart';
import 'package:money_alarm/models/asset_data.dart';
import 'package:money_alarm/models/secrets.dart';
import 'package:money_alarm/screens/notification_screen.dart';
import 'package:money_alarm/screens/add_asset_screen.dart';
import 'package:money_alarm/widgets/assets_list.dart';
import 'package:provider/provider.dart';
import 'package:finance_quote/finance_quote.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:money_alarm/models/asset.dart';
import 'package:money_alarm/database//asset_bloc.dart';
import 'package:newsapi/newsapi.dart';
import 'package:money_alarm/widgets/news_list.dart';
import 'package:money_alarm/models/news_data.dart';

class DashBoardScreen extends StatefulWidget {
  static const id = 'dashboard_screen';

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final bloc = AssetBloc();
  AssetData assetData = AssetData();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String selectedAssetName;
  @override
  void initState() {
    super.initState();
    Provider.of<NewsData>(context, listen: false).getFirstAssetNews();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
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
//                Container(
//                  alignment: Alignment.centerRight,
//                  child: FlatButton(
//                    child: Container(
//                      padding: EdgeInsets.only(left: 13, top: 8),
//                      child: Icon(
//                        Icons.add,
//                        color: Colors.deepPurple,
//                      ),
//                    ),
//                    onPressed: () => showNotification(),
//                  ),
//                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Container(
                      padding: EdgeInsets.only(left: 25, top: 8),
                      child: Icon(
                        Icons.refresh,
                        color: Colors.grey,
                      ),
                    ),
                    onPressed: () {
//                      Provider.of<AssetData>(context, listen: false)
//                          .setAssetPrice(context);
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: AssetsList(
                selectedAssetName: selectedAssetName,
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
              child: NewsList(
                  //assetName: selectedAssetName,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
