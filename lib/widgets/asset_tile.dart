import 'package:flutter/material.dart';

class AssetTile extends StatefulWidget {
  final String assetName;
  String assetPrice;
  Function setAssetPrice;

  AssetTile({this.assetName, this.assetPrice, this.setAssetPrice});

  @override
  _AssetTileState createState() => _AssetTileState();
}

class _AssetTileState extends State<AssetTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.assetName,
      ),
      trailing: Text(
        widget.assetPrice,
      ),
      //onLongPress: longPressCallback,
    );
  }
}
