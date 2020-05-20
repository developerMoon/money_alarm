import 'package:flutter/cupertino.dart';
import 'package:money_alarm/models/asset.dart';
import 'dart:collection';

class AssetData extends ChangeNotifier {
  List<Asset> _assets = [
    Asset(name: 'USD', price: 1200),
    Asset(name: 'S&P', price: 2900),
  ];

  UnmodifiableListView<Asset> get assets {
    return UnmodifiableListView(_assets);
  }

  void addAsset(String newAssetName) {
    final asset = Asset(name: newAssetName);
    _assets.add(asset);
    notifyListeners();
  }

  int get assetCount {
    return _assets.length;
  }
}
