import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:money_alarm/models/news_data.dart';
import 'package:money_alarm/widgets/news_list.dart';
import 'package:money_alarm/widgets/asset_tile.dart';
import 'package:provider/provider.dart';
import 'package:money_alarm/models/asset_data.dart';
import 'package:money_alarm/models/asset.dart';
import 'package:sqflite/sqflite.dart';
import 'package:money_alarm/database/database.dart';
import 'package:money_alarm/database/asset_bloc.dart';
import 'package:newsapi/newsapi.dart';
import 'package:money_alarm/models/secrets.dart';
import 'package:provider/provider.dart';

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
      child: FutureBuilder<dynamic>(
          //StreamBuilder<dynamic>(
          //stream: bloc.assets,
          //builder: (context, snapshot) {
          future: DBProvider.db.getAllAssetsDB(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  key: UniqueKey(),
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
                            Provider.of<NewsData>(context, listen: false)
                                .getAssetNews(asset.name);
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
