//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:newsapi/newsapi.dart';
//import 'secrets.dart';
//
//class NewsList extends StatelessWidget {
//  final String assetName;
//  List<String> news = [];
//  NewsList({this.assetName});
//
//  Future<ListView> getAssetNews() async {
//    var newsApi = NewsApi();
//    newsApi.init(debugLog: true, apiKey: apiKey);
//
//    var headlines = await newsApi.topHeadlines(
//      q: '$assetName',
//      language: 'en',
////                          country: 'us',
////                          category: 'business',
//      pageSize: 20,
//    );
//
//    return ListView(
//        children: [
//    ListTile(
//    var headlineList = headlines.articles.toList();
//    for (var headline in headlineList) {
//      print('------ ${headline.title} -----');
//      news.add(headline.title);
//    }
//
//          title: Text('$news[0]'),
//        )
//      ],
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return ListView(
//      children: <Widget>[
//
//        ListTile(),
//      ],
//    );
//  }
//}
