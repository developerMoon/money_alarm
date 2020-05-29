import 'package:finance_quote/finance_quote.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_alarm/models/asset.dart';
import 'dart:collection';

class AssetData extends ChangeNotifier {
  List<Asset> _assets = [
    Asset(name: 'GOOG', price: 'waiting'),
    Asset(name: 'AMZN', price: 'waiting'),
    Asset(name: 'AAPL', price: 'waiting'),
  ];

  UnmodifiableListView<Asset> get assets {
    return UnmodifiableListView(_assets);
  }

  void addAsset(String newAssetName) {
    final asset = Asset(name: newAssetName, price: 'waiting');
    _assets.add(asset);
    notifyListeners();
  }

  int get assetCount {
    return _assets.length;
  }

  void setAssetPrice() async {
    for (var i = 0; i < _assets.length; i++) {
      final Map<String, Map<String, String>> quotePrice =
          await FinanceQuote.getPrice(
              quoteProvider: QuoteProvider.yahoo,
              symbols: <String>[_assets[i].name]);
      print(
          'Current market price for ${_assets[i].name}: ${quotePrice[_assets[i].name]['price']}.');
      _assets[i].price = quotePrice[_assets[i].name]['price'];
      notifyListeners();
    }
  }
}
