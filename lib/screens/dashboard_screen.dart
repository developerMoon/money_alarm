import 'package:flutter/material.dart';
import 'package:money_alarm/screens/notification_screen.dart';
import 'package:money_alarm/screens/add_asset_screen.dart';

class DashBoardScreen extends StatefulWidget {
  static const id = 'dashboard_screen';

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Align(
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
            height: 200,
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
            height: 300,
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
