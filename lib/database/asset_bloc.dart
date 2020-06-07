import 'package:flutter/cupertino.dart';
import 'package:money_alarm/database/database.dart';
import 'package:money_alarm/models/asset.dart';
import 'dart:async';
import 'package:finance_quote/finance_quote.dart';

class AssetBloc extends ChangeNotifier {
  AssetBloc() {
    getAssets();
  }
  final _assetController = StreamController<List<Asset>>.broadcast();
  get assets => _assetController.stream;

  dispose() {
    _assetController.close();
  }

  getAssets() async {
    _assetController.sink.add(await DBProvider.db.getAllAssetsDB());
    notifyListeners();
  }

  getFirstAsset() async {
    await DBProvider.db.getFirstAssetDB();
    //notifyListeners();
  }

  delete(String assetName) {
    DBProvider.db.deleteAssetDB(assetName);
    getAssets();
  }

  add(String newAssetName) async {
    final Map<String, Map<String, String>> quotePrice =
        await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.yahoo,
            symbols: <String>[newAssetName]);

    final asset = Asset(
        name: newAssetName, price: '${quotePrice[newAssetName]['price']}');
    DBProvider.db.addAssetDB(asset);
    getAssets();
  }
}
