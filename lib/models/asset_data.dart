import 'package:finance_quote/finance_quote.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_alarm/models/asset.dart';
import 'dart:collection';
import 'package:money_alarm/database/database.dart';
import 'package:sqflite/sqflite.dart';
import 'file:///C:/Users/soyoung.moon/AndroidStudioProjects/money_alarm/lib/database/asset_bloc.dart';

//class AssetData extends ChangeNotifier {
class AssetData {
  List<Asset> _assets = [];
  final bloc = AssetBloc();

  UnmodifiableListView<Asset> get assets {
    return UnmodifiableListView(_assets);
  }

  void addAsset(BuildContext context, String newAssetName) async {
//    final Map<String, Map<String, String>> quotePrice =
//        await FinanceQuote.getPrice(
//            quoteProvider: QuoteProvider.yahoo,
//            symbols: <String>[newAssetName]);
//
//    final asset = Asset(
//        name: newAssetName, price: '${quotePrice[newAssetName]['price']}');
//    //_assets.add(asset);
//    bloc.add(asset);
//    notifyListeners();
  }

//  void deleteAsset(Asset asset) {
//    _assets.remove(asset);
//    notifyListeners();
//  }

  int get assetCount {
    return _assets.length;
  }

//  void setAssetPrice(BuildContext context) async {
//    for (var i = 0; i < _assets.length; i++) {
//      final Map<String, Map<String, String>> quotePrice =
//          await FinanceQuote.getPrice(
//              quoteProvider: QuoteProvider.yahoo,
//              symbols: <String>[_assets[i].name]);
//      print(
//          'setAssetPrice - Current market price for ${_assets[i].name}: ${quotePrice[_assets[i].name]['price']}.');
//      _assets[i].price = quotePrice[_assets[i].name]['price'];
//      DBProvider.db.updateAssetDB(_assets[i]);
//      notifyListeners();
//    }
//  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("My title"),
    content: Text("This is my message."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
