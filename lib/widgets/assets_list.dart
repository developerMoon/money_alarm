import 'package:flutter/material.dart';
import 'package:money_alarm/widgets/asset_tile.dart';
import 'package:provider/provider.dart';
import 'package:money_alarm/models/asset_data.dart';
import 'package:money_alarm/models/asset.dart';
import 'package:sqflite/sqflite.dart';
import 'package:money_alarm/database/database.dart';

class AssetsList extends StatelessWidget {
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
    return FutureBuilder<List<Asset>>(
        future: DBProvider.db.getAllAssetsDB(),
        builder: (BuildContext context, AsyncSnapshot<List<Asset>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Asset item = snapshot.data[index];
                return ListTile(
                  title: Text(item.name),
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
          }
        });
  }
}
