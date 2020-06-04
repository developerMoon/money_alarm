import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:money_alarm/models/news.dart';
import 'package:money_alarm/widgets/asset_tile.dart';
import 'package:provider/provider.dart';
import 'package:money_alarm/models/asset_data.dart';
import 'package:money_alarm/models/asset.dart';
import 'package:sqflite/sqflite.dart';
import 'package:money_alarm/database/database.dart';
import 'package:money_alarm/database/asset_bloc.dart';
import 'package:newsapi/newsapi.dart';
import 'package:money_alarm/models/secrets.dart';

class AssetsList extends StatefulWidget {
  @override
  _AssetsListState createState() => _AssetsListState();
}

class _AssetsListState extends State<AssetsList> {
  final bloc = AssetBloc();

  @override
  void dispose() {
    //bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    return Consumer<AssetData>(
//      builder: (context, assetData, child) {
//        return ListView.builder(
//          itemBuilder: (context, index) {
//            final asset = assetData.assets[index];
//            return AssetTile(
//                assetName: asset.name,
//                assetPrice: asset.price,
//                longPressDeleteTask: () {
//                  assetData.deleteAsset(asset);
//                });
//          },
//          itemCount: assetData.assetCount,
//        );
//      },
//    );
    return Container(
      child: StreamBuilder<dynamic>(
          stream: bloc.assets,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Asset asset = snapshot.data[index];
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        bloc.delete(asset.name);
                      },
                      child: AssetTile(
                          assetName: asset.name,
                          assetPrice: asset.price,
                          onTapShowNews: () async {
                            NewsList newsList = NewsList(
                              assetName: asset.name,
                            );
                            setState(() {
                              newsList.getAssetNews();
                            });
                          }),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class NewsList extends StatelessWidget {
  final String assetName;
  NewsList({this.assetName});
  List news = [];

  void getAssetNews() async {
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
    getAssetNews();
//    if (news.length != 0) {
    return ListView(
        children: new List.generate(
            20, (index) => ListTile(title: Text('${news[index].title}'))));
//    } else {
//      return Center(child: CircularProgressIndicator());
//    }
  }
}
