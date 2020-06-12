import 'package:flutter/material.dart';
import 'package:newsapi/newsapi.dart';
import 'package:money_alarm/database/database.dart';
import 'secrets.dart';

class NewsData extends ChangeNotifier {
  Map<String, String> _news = Map();

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

    var newsObj = await newsApi.everything(
      q: '$assetName',
      language: 'en',
      pageSize: 20,
    );
    var newsLists = newsObj.articles.toList();

    for (var newsList in newsLists) {
      //print('------ ${newsList.url} -----');
      _news[newsList.title] = newsList.url;
    }
    print('news length!! : ${_news.length}');

    notifyListeners();
  }
}
