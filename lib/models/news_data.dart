import 'package:flutter/material.dart';
import 'package:newsapi/newsapi.dart';
import 'package:money_alarm/database/database.dart';
import 'secrets.dart';

class NewsData extends ChangeNotifier {
  List<String> _news = [];

  get news {
    return (_news);
  }

  int get newsCount {
    return _news.length;
  }

  void getFirstAssetNews() async {
    _news.clear();
    var list = await DBProvider.db.getAllAssetsDB();
    print('printed getFirstAssetNews : ${list[0].name}');
    getAssetNews(list[0].name);
    notifyListeners();
  }

  getAssetNews(String assetName) async {
    _news.clear();
    var newsApi = NewsApi();
    newsApi.init(debugLog: true, apiKey: apiKey);

    var headlines = await newsApi.everything(
      q: '$assetName',
      language: 'en',
      pageSize: 20,
    );
    var headlineList = headlines.articles.toList();
    //news.clear();setState(() {
    for (var headline in headlineList) {
      print('------ ${headline.title} -----');
      news.add(headline.title);
    }
    print('news length!! : ${news.length}');

    notifyListeners();
  }
}
