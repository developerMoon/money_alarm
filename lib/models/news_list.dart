import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:money_alarm/database/database.dart';
import 'package:newsapi/newsapi.dart';
import 'secrets.dart';
import 'package:money_alarm/database/asset_bloc.dart';
import 'asset.dart';

class NewsList extends StatefulWidget {
  final String assetName;
  final Function getAssetNews;
  NewsList({this.assetName, this.getAssetNews});

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

    //getAssetNews('GOOG');
    getFirstAssetNews();
  }

  void getFirstAssetNews() async {
    //dynamic name = await bloc.getFirstAsset();
    //print('name?? $name  ${name.runtimeType}');
    //await print('name:: ${name[0].value}');

    //String firstAsset = name;
    //print('asset name!! ${firstAsset}');
//    await getAssetNews('GOOG');

    var list = await DBProvider.db.getAllAssetsDB();
    print('printed getFirstAssetNews : ${list[0].name}');
    getAssetNews(list[0].name);
  }

  Future getAssetNews(String assetName) async {
    var newsApi = NewsApi();
    newsApi.init(debugLog: true, apiKey: apiKey);

    var headlines = await newsApi.topHeadlines(
      q: '$assetName',
      language: 'en',
      pageSize: 20,
    );
    var headlineList = headlines.articles.toList();
    //news.clear();
    setState(() {
      for (var headline in headlineList) {
        print('------ ${headline.title} -----');
        news.add(headline.title);
      }
      print('news length!! : ${news.length}');
    });
    return news;
  }

  @override
  Widget build(BuildContext context) {
//    setState(() {
//      getAssetNews(widget.assetName);
//    });
    //getAssetNews(widget.assetName);
    if (news.length != 0) {
      return ListView(
          children: List.generate(
              news.length, (index) => ListTile(title: Text('${news[index]}'))));
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
