import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:money_alarm/database/database.dart';
import 'package:newsapi/newsapi.dart';
import 'secrets.dart';
import 'package:money_alarm/database/asset_bloc.dart';

class NewsList extends StatefulWidget {
  final String assetName;
  NewsList({this.assetName});

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List news = [];
  final bloc = AssetBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dynamic name = bloc.getFirstAsset();
    String firstAsset = name["name"].values;
    print('asset name!! ${firstAsset}');
    getAssetNews(firstAsset);
  }

  void getAssetNews(String assetName) async {
    var newsApi = NewsApi();
    newsApi.init(debugLog: true, apiKey: apiKey);

    var headlines = await newsApi.topHeadlines(
      q: '$assetName',
      language: 'en',
      pageSize: 20,
    );
    var headlineList = headlines.articles.toList();
    for (var headline in headlineList) {
      print('------ ${headline.title} -----');
      news.add(headline.title);
    }
    print('news length!! : ${news.length}');
  }

  @override
  Widget build(BuildContext context) {
    getAssetNews(widget.assetName);
    if (news.length != 0) {
      return ListView(
          children: new List.generate(
              20, (index) => ListTile(title: Text('${news[index].title}'))));
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
