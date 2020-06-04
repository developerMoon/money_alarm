import 'dart:convert';

import 'package:flutter/material.dart';
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
                        var newsApi = NewsApi();
                        newsApi.init(debugLog: true, apiKey: apiKey);

//                        ArticleResponse topHeadlines =
//                            await newsApi.topHeadlines(language: 'en');
//                        print(topHeadlines);

                        //ArticleResponse topHeadlines =
                        var headline = await newsApi.topHeadlines(
                          q: '${asset.name}',
                          language: 'en',
//                          country: 'us',
//                          category: 'business',
                          pageSize: 10,
                        );
//                        var vresult = headline.articles;
//
//                        print(
//                            '------result headline: ${vresult[0].toString()} ${vresult[1]}   ');
                        //var title = jsonDecode(vresult)['articles'][1]['title'];

                        //print('------result title: $title  ');
                      },
//                    longPressDeleteTask: () {
//                      snapshot.data.deleteAsset(asset);
//                    },
//    leading: Text(item.id.toString()),
//    trailing: Checkbox(
//    onChanged: (bool value) {
//    DBProvider.db.blockClient(item);
//    setState(() {});
//    },
//    value: item.blocked,
//    ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
