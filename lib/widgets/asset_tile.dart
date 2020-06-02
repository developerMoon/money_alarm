import 'package:flutter/material.dart';

class AssetTile extends StatelessWidget {
  final String assetName;
  String assetPrice;
  final Function longPressDeleteTask;

  AssetTile({this.assetName, this.assetPrice, this.longPressDeleteTask});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        assetName,
      ),
      trailing: Text(
        assetPrice,
      ),
      onLongPress: longPressDeleteTask,
    );
  }
}
