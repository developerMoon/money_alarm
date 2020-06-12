import 'dart:async';

import 'package:flutter/material.dart';
import 'package:money_alarm/database/database.dart';
import 'package:provider/provider.dart';
import 'package:money_alarm/models/asset_data.dart';
import 'package:money_alarm/database/asset_bloc.dart';
import 'package:finance_quote/finance_quote.dart';
import 'package:money_alarm/models/asset.dart';

class AddAssetScreen extends StatefulWidget {
  static String newAssetName;

  @override
  _AddAssetScreenState createState() => _AddAssetScreenState();
}

class _AddAssetScreenState extends State<AddAssetScreen> {
  final bloc = AssetBloc();
  final textController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            //color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Add Asset',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
              TextField(
                autofocus: true, //keyboard enabled, focusted
                textAlign: TextAlign.center,
                controller: textController,
                onChanged: (newText) {
                  AddAssetScreen.newAssetName = newText;
                },
              ),
              FlatButton(
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.deepPurple,
                onPressed: () {
                  //add task
                  print('onpressed add ${AddAssetScreen.newAssetName}');
                  setState(() {
                    bloc.add(AddAssetScreen.newAssetName);
                  });

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
