import 'package:flutter/material.dart';
import 'package:money_alarm/widgets/asset_tile.dart';
import 'package:provider/provider.dart';
import 'package:money_alarm/models/asset_data.dart';
import 'package:money_alarm/models/asset.dart';
import 'package:sqflite/sqflite.dart';
import 'package:money_alarm/database/database.dart';

class AssetsList extends StatefulWidget {
  @override
  _AssetsListState createState() => _AssetsListState();
}

class _AssetsListState extends State<AssetsList> {
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
          future: DBProvider.db.getAllAssetsDB(),
          builder: (context, snapshot) {
            //builder: (BuildContext context, AssetData snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Asset asset = snapshot.data[index];
                  return AssetTile(
                    assetName: asset.name,
                    assetPrice: asset.price,
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
