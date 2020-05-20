import 'package:flutter/material.dart';
import 'package:money_alarm/widgets/asset_tile.dart';
import 'package:provider/provider.dart';
import 'package:money_alarm/models/asset_data.dart';

class AssetsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AssetData>(
      builder: (context, assetData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final asset = assetData.assets[index];
            return AssetTile(
              assetName: asset.name,
              assetPrice: asset.price,
            );
          },
          itemCount: assetData.assetCount,
        );
      },
    );
  }
}
