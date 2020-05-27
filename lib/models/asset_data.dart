import 'package:finance_quote/finance_quote.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_alarm/models/asset.dart';
import 'dart:collection';

class AssetData extends ChangeNotifier {
  List<Asset> _assets = [
    Asset(name: 'GOOG', price: '1200'),
    Asset(name: 'AMZN', price: '2900'),
    Asset(name: 'AAPL', price: '200'),
  ];

//  UnmodifiableListView<Asset> get assets {
//    return UnmodifiableListView(_assets);
//  }

//  ListView<Asset> get assets {
//    return ListView(_assets);
//  }
//
  void addAsset(String newAssetName) {
    final asset = Asset(name: newAssetName);
    _assets.add(asset);
    notifyListeners();
  }

  int get assetCount {
    return _assets.length;
  }

  void setAssetPrice() async {
    for (var asset in _assets) {
      final Map<String, Map<String, String>> quotePrice =
          await FinanceQuote.getPrice(
              quoteProvider: QuoteProvider.yahoo,
              symbols: <String>[asset.name]);
      print(
          'Current market price for ${asset.name}: ${quotePrice[asset.name]['price']}.');
      asset.price = quotePrice[asset.name]['price'];
      print('asset.price: ${asset.price}');
      notifyListeners();
    }
  }
}
