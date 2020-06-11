import 'dart:async';

import 'package:flutter/material.dart';
import 'package:money_alarm/database/database.dart';
import 'package:provider/provider.dart';
import 'package:money_alarm/models/asset_data.dart';
import 'package:money_alarm/database/asset_bloc.dart';
import 'package:finance_quote/finance_quote.dart';
import 'package:money_alarm/models/asset.dart';

class AddAssetScreen extends StatelessWidget {
  static String newAssetName;
  final bloc = AssetBloc();
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
                onChanged: (newText) {
                  newAssetName = newText;
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
                onPressed: () async {
                  //add task
                  print('onpressed add $newAssetName');
//
//                  final Map<String, Map<String, String>> quotePrice =
//                      await FinanceQuote.getPrice(
//                          quoteProvider: QuoteProvider.yahoo,
//                          symbols: <String>[newAssetName]);
//
//                  final asset = Asset(
//                      name: newAssetName,
//                      price: '${quotePrice[newAssetName]['price']}');
//                  DBProvider.db.addAssetDB(asset);
                  bloc.add(newAssetName);

                  //bloc.getAssets();
                  //StreamController<>.broadcast
                  //.addAsset(context, newAssetName);

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
