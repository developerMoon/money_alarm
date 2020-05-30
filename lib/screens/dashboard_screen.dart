import 'package:flutter/material.dart';
import 'package:money_alarm/models/asset_data.dart';
import 'package:money_alarm/screens/notification_screen.dart';
import 'package:money_alarm/screens/add_asset_screen.dart';
import 'package:money_alarm/widgets/assets_list.dart';
import 'package:provider/provider.dart';
import 'package:finance_quote/finance_quote.dart';
import 'package:intl/intl.dart';

class DashBoardScreen extends StatefulWidget {
  static const id = 'dashboard_screen';

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  AssetData assetData = AssetData();
  @override
  void initState() {
    super.initState();
    Provider.of<AssetData>(context, listen: false).setAssetPrice(context);
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
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
                onPressed: () {
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
          Container(
            height: 250,
            color: Colors.grey,
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
      )),
    );
  }
}
